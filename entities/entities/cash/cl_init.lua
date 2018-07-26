include( "shared.lua" )

local gradient = surface.GetTextureID("gui/center_gradient")

function ENT:Draw()

    self:DrawModel()
	
	//if !self:InView() then return end
	
	local pos = self:GetPos()
	
	local ang = self:GetAngles()
	
	surface.SetFont( "Trebuchet24" )
	
	local amt = "$" .. string.Comma( self:GetNWInt( "Amount" ) )
	
	local w, h = surface.GetTextSize( amt )
	
	local offset = 0.825
	
	if self:GetModel() == "models/oldbill/big red cash bundle.mdl" then
		
		offset = 3.8
		
	end
	
	cam.Start3D2D( pos + ang:Up() * offset, ang, 0.1 )
		
		draw.RoundedBox( 0, - ( w / 2 ) - 5, - ( h / 2 ) - 2.5, w + 10, h + 5, Color( 0, 128, 0, 150 ) )
		
		draw.RoundedBox( 0, - ( w / 2 ) - 5, - ( h / 2 ) - 2.5, w + 10, 1.25, Color( 40, 168, 40, 150 ) )
		
		surface.SetTexture( gradient )
	
		surface.SetDrawColor( 50, 178, 50, 255 )
	
		surface.DrawTexturedRect( - ( w / 2 ) - 5, - ( h / 2 ) - 2.5, w + 10, h + 5 )
		
		draw.SimpleText( amt, "Trebuchet24", 0, 2.5, Color( 215, 215, 215 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER ) 
		
	cam.End3D2D()
	
end

function ENT:Think()

end