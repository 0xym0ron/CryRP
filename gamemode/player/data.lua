--[[---------------------------------------------------------
	Setup player's networked vars
-----------------------------------------------------------]]

function meta.Player:SetupVars( data )

	if !istable( data ) then
		
		rp.Msg( "Error: meta.Player:SetupVars( data ) 'data' isn't a table!" )
		
		return
		
	end
	
	for k, v in pairs( data ) do
		
		if k == "Money" then
			
			self:SetNWInt( "Money", v )
			
		elseif k == "Name" then
			
			self:SetNWString( "Name", v )
			
		elseif k == "Bank" then
			
			self:SetNWInt( "Bank", v )
			
		end

	end

end
