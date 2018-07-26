--[[---------------------------------------------------------

   Unnamed Roleplay Project
   by 0xymoron (Tyler Wearing)
   
   Let's try to make this right.
   
-----------------------------------------------------------]]

rp = rp or {}

meta = {
	Player = FindMetaTable( "Player" ),
	Entity = FindMetaTable( "Entity" ),
}

DeriveGamemode( "sandbox" )

DEFINE_BASECLASS( "gamemode_sandbox" )

GM.Sandbox = BaseClass

--[[---------------------------------------------------------
	Client notification functions
-----------------------------------------------------------]]

function rp.Msg( str )
	
	MsgC( Color( 195, 195, 195 ), "[CryRP] " )

	MsgC( color_white, str .. "\n" )

end

function rp.Error( str )

	MsgC( Color( 195, 195, 195 ), "[CityRP] [" )
	
	MsgC( Color( 0, 255, 0 ), "*" )
	
	MsgC( Color( 195, 195, 195 ), "] " )
	
	MsgC( color_white, str .. "\n" )

end

function rp.include( path )

	MsgC( Color( 195, 195, 195 ), "[CryRP] " )	
	MsgC( Color( 195, 195, 195 ), "[" )	
	MsgC( Color( 0, 255, 0 ), "+" )		
	MsgC( Color( 195, 195, 195 ), "] " )
	MsgC( color_white, path .. "\n" )

	return include( path )
	
end

net.Receive( "rp_Notify", function( len )

	local msg = net.ReadString()
	
	local typ = net.ReadString()
	
	local dur = net.ReadString()
	
	rp.Msg( msg )
	
	GAMEMODE:AddNotify( msg, typ, dur )
	
	surface.PlaySound( "buttons/lightswitch2.wav" )

end )

--[[---------------------------------------------------------
	Load everything manually to keep it in proper order
-----------------------------------------------------------]]

function rp.Initialize()

	rp.Msg( "Loading gamemode files" )

	rp.include( "base/cl_optimization.lua" )
	
	rp.include( "hooks/cl_gamemode.lua" )
	
	rp.include( "hud/cl_scoreboard.lua" )
	
	rp.include( "hud/cl_hud.lua" )
	
	rp.include( "doors/cl_door_hud.lua" )
	
	rp.include( "doors/sh_doors.lua" )

	rp.Msg( "Finished loading gamemode files" )
	
end

rp.Initialize()
