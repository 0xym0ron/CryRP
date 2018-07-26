local gradient = surface.GetTextureID("gui/center_gradient")
local gradient_left = surface.GetTextureID("vgui/gradient-l")

--[[---------------------------------------------------------
	GM:HUDPaint - Attempt to load all paints in this hook
-----------------------------------------------------------]]

function GM:HUDPaint()
	
	if !LocalPlayer():Alive() then return end
	
	local trace = LocalPlayer():GetEyeTrace().Entity
	
	// Player HUD
	
	surface.SetFont( "Trebuchet24" )
	
	local money_str = "Money: $" .. string.Comma( LocalPlayer():GetNWString( "Money" ) )
	local money_w, money_h = surface.GetTextSize( money_str )
	
	local name_str = "Name: " .. LocalPlayer():GetNWString( "Name" )
	local name_w, name_h = surface.GetTextSize( name_str )
	
	local dev_str = "CryRP | In Development"
	local dev_w, dev_h = surface.GetTextSize( dev_str )

	draw.SimpleText( dev_str, "Trebuchet24", 5, 0, HSVToColor( RealTime() * 120 % 360, 1, 1 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	
	surface.SetTexture( gradient_left )
	
	surface.SetDrawColor( 0, 0, 0, 150 )
	
	surface.DrawTexturedRect( 0, 0, dev_w * 1.25, dev_h + 5 )

	//draw.SimpleText( name_str, "Trebuchet24", 5, ScrH() - 35, Color( 0, 255, 255, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	
	//draw.SimpleText( money_str, "Trebuchet24", name_w + 15, ScrH() - 35, Color( 0, 255, 0, 200 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
	
	draw.RoundedBox( 0, 5, ScrH() - 10 - money_h, money_w + 10, money_h + 5, Color( 60, 60, 75, 255 ) )
	
	draw.RoundedBox( 0, 5, ScrH() - 10 - money_h, money_w + 10, 1.5, Color( 90, 90, 105, 255 ) )	
	
	surface.SetTexture( gradient )
	
	surface.SetDrawColor( 80, 80, 95, 255 )
	
	surface.DrawTexturedRect( 5, ScrH() - 10 - money_h, money_w + 10, money_h + 5 )
	
	draw.SimpleText( money_str, "Trebuchet24", 10 + ( money_w / 2 ), ScrH() - 7.5 - name_h, Color( 195, 195, 195, 195 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )

	// Door Display
	
	if IsValid( trace ) && trace:isDoor() && trace:InView( 250 ) then
	
		trace:DisplayDoorInfo()
	
	end
	
end