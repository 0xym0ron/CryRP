--[[---------------------------------------------------------
	Open MOTD
-----------------------------------------------------------]]

function rp.MOTD()

	local frame = vgui.Create( "DFrame" )	
	frame:SetSize( ScrW() / 2, ScrH() - 400 )	
	frame:SetPos( ScrW() / 2 - ( frame:GetWide() / 2 ), 200 )
	frame:SetTitle( "CryRP MOTD" )
	frame:MakePopup()

end