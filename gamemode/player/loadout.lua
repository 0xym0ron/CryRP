--[[---------------------------------------------------------
	Player Loadout
-----------------------------------------------------------]]

function rp.PlayerLoadout( ply )

	ply:StripWeapons()

	ply:Give( "weapon_physcannon" )
	
	ply:Give( "weapon_physgun" )
	
	ply:Give( "gmod_tool" )
	
	ply:Give( "gmod_camera" )

end