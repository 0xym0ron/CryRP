--[[---------------------------------------------------------
	Scoreboard Control
-----------------------------------------------------------]]

function GM:ScoreboardShow()

	sb.Show()

end

function GM:ScoreboardHide()

	sb.Hide()

end

--[[---------------------------------------------------------
	HUDShouldDraw - Remove default HUD elements
-----------------------------------------------------------]]

local fuckoff = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudCrosshair"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHudSecondaryAmmo"] = true,
	//["CHudWeaponSelection"] = true,
	//["CHudZoom"] = true,
}

function GM:HUDShouldDraw( name )
	
	if fuckoff[name] then return false end
	
	return self.Sandbox.HUDShouldDraw( self, name )
	
end
