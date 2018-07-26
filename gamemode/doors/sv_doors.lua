rp.DoorData = rp.DoorData or {}

function rp.SetupDoorData()

	for k, v in next, ents.GetAll() do
	
		if !v:isDoor() or rp.DoorData[v] != nil then continue end
		
		rp.DoorData[v] = {
		
			["Owner"] = nil,
		
		}
		
		v:SetNWEntity( "Owner", rp.DoorData[v].Owner )
	
	end

end

function meta.Entity:setDoorOwner( ply )

	if !self:isDoor() then return end
	
	if rp.DoorData[self] == nil then return end
	
	rp.DoorData[self].Owner = ply
	
	self:SetNWEntity( "Owner", ply )

end

function meta.Player:buyDoor( door )

	if !door:isDoor() or rp.DoorData[door] == nil then 
		
		self:Notify( "Invalid door", 1, 2 )
		
		return
		
	end
	
	if IsValid( rp.DoorData[door].Owner ) then
		
		self:Notify( "This door is already owned by " .. rp.DoorData[door].Owner:Nick() )
		
		return
		
	end
	
	self:takeMoney( 50 )
	
	self:Notify( "You have purchased this door for $50", 0, 2 )
	
	door:setDoorOwner( self )

end

rp.SetupDoorData()