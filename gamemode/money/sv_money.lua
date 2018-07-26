--[[---------------------------------------------------------
	Add money to a player's account	
-----------------------------------------------------------]]

function meta.Player:addMoney( amt )

	if amt < 0 then return end // fuck off please
	
	self:GetSQLVar( "Money", function( v )
	
		local add = tonumber( v ) + tonumber( amt )
	
		self:SetSQLVar( "Money", add, function()
		
			self:syncMoney()
	
		end )
		
	end )

end

--[[---------------------------------------------------------
	Take money from a player's account	
-----------------------------------------------------------]]

function meta.Player:takeMoney( amt )

	if amt < 0 then return end
	
	self:GetSQLVar( "Money", function( v )
	
		local take = tonumber( v ) - tonumber( amt )
		
		self:SetSQLVar( "Money", take, function()
		
			self:syncMoney()
			
		end )
	
	end )

end

--[[---------------------------------------------------------
	Can Afford (Avoid going into negatives)
-----------------------------------------------------------]]

function meta.Player:canAfford( amt )

	if amt < 0 then return end

	if self:GetNWInt( "Money" ) >= amt then
			
		return true
			
	end
		
	return false

end

--[[---------------------------------------------------------
	Sync money from the database to the player
-----------------------------------------------------------]]

function meta.Player:syncMoney( func )

	self:GetSQLVar( "Money", function( v )
		
		self:SetNWInt( "Money", v )
		
		if isfunction( func ) then
			
			func()
			
		end
		
	end )

end

--[[---------------------------------------------------------
	player:dropMoney( amount ) 
-----------------------------------------------------------]]

function meta.Player:dropMoney( amt )

	if !self:Alive() then return end
	
	if !self:canAfford( amt ) then 
	
		self:Notify( "You cannot afford this", 1, 2 )
	
		return 
		
	end
	
	if amt < 1 then return end
	
	amt = math.Round( amt )
	
	local cash = ents.Create( "cash" )
	
	cash:SetNWInt( "Amount", amt )
	
	cash:Spawn()	

	local tr = {}
	tr.start = self:EyePos()
	tr.endpos = tr.start + self:GetAimVector() * 75
	tr.filter = self
	
	local trace = util.TraceLine( tr )
	
	cash:SetPos( trace.HitPos )
	
	self:takeMoney( amt )
	
	self:Notify( "Dropped $" .. string.Comma( amt ), 0, 2 )

end

--[[---------------------------------------------------------
	player:giveMoney( player, amount )
-----------------------------------------------------------]]

function meta.Player:giveMoney( ply, amt )

	if !self:canAfford( amt ) then 
		
		self:Notify( "You cannot afford this" )
		
		return 
		
	end
	
	if !IsValid( self ) or !IsValid( ply ) then return end
	
	amt = math.Round( amt )
	
	self:takeMoney( amt )
	
	self:Notify( "You have given $" .. string.Comma( amt ) .. " to " .. ply:Nick(), 0, 2 )
	
	ply:addMoney( amt )

	ply:Notify( self:Nick() .. " has given you $" .. string.Comma( amt ), 0, 2 )
	
end

--[[---------------------------------------------------------
	rp.CreateCash( pos, amt )
-----------------------------------------------------------]]

function rp.CreateCash( pos, amt )

	if amt < 1 then return end
	
	amt = math.Round( amt )
	
	if !isvector( pos ) then return end

	local cash = ents.Create( "cash" )
	
	cash:SetNWInt( "Amount", amt )
	
	cash:SetPos( pos )
	
	cash:Spawn()

end