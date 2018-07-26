--[[---------------------------------------------------------
	entity:InView( distance )
-----------------------------------------------------------]]

function meta.Entity:InView( dist )

	if !IsValid( self ) then return false end
	
	if dist == nil then
		
		dist = 1000
	
	end
	
	if LocalPlayer():GetPos():Distance( self:GetPos() ) > dist then return false end

	return true

end