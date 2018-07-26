--[[---------------------------------------------------------
	entity:DisplayDoorInfo() 
-----------------------------------------------------------]]

function meta.Entity:DisplayDoorInfo()

	local x, y = ScrW() / 2, ScrH() / 2
	
	local str = "Unowned"
	
	if IsValid( self:GetNWEntity( "Owner" ) ) then
		
		local owner = self:GetNWEntity( "Owner" )
		
		str = owner:Nick()
		
	end
	
	draw.SimpleText( str, "Trebuchet24", x, y, color_white, 1, 1 )
	
end