--[[---------------------------------------------------------
	GM:KeyPress
-----------------------------------------------------------]]

function GM:KeyPress( ply, code )

    self.Sandbox.KeyPress( self, ply, code )
	
end

--[[---------------------------------------------------------
	GM:Initialize
-----------------------------------------------------------]]

function GM:Initialize()

    self.Sandbox.Initialize( self )
	
end

--[[---------------------------------------------------------
	GM:PlayerSpawn
-----------------------------------------------------------]]

function GM:PlayerSpawn( ply )

	rp.PlayerLoadout( ply )
	
	ply:SetModel( "models/player/kleiner.mdl" ) // lol
	
end

--[[---------------------------------------------------------
	GM:PlayerInitialSpawn
-----------------------------------------------------------]]

function GM:PlayerInitialSpawn( ply )
	
	ply:LoadPlayerData()

end

--[[---------------------------------------------------------
	GM:DoPlayerDeath
-----------------------------------------------------------]]

function GM:DoPlayerDeath( ply )

	ply:CreateRagdoll()
	
end