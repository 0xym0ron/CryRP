--[[---------------------------------------------------------

   Unnamed Roleplay Project
   by 0xymoron (Tyler Wearing)
   
   Let's try to make this right.
   
   References:
	
	Citizen Models: https://steamcommunity.com/sharedfiles/filedetails/?id=610653135
	Medic Models: https://steamcommunity.com/sharedfiles/filedetails/?id=231834252
	Cops: https://steamcommunity.com/sharedfiles/filedetails/?id=108513751
	Jailed: https://steamcommunity.com/sharedfiles/filedetails/?id=250537769
	Zombies: https://steamcommunity.com/sharedfiles/filedetails/?id=129669178
   
-----------------------------------------------------------]]

rp = rp or {}

meta = {
	Player = FindMetaTable( "Player" ),
	Entity = FindMetaTable( "Entity" ),
}

DeriveGamemode( "sandbox" )

DEFINE_BASECLASS( "gamemode_sandbox" )

GM.Sandbox = BaseClass

util.AddNetworkString( "rp_Notify" )

--[[---------------------------------------------------------
	Server notification functions
-----------------------------------------------------------]]

function rp.Msg( str )
	
	MsgC( Color( 195, 195, 195 ), "[CryRP] " )

	MsgC( color_white, str .. "\n" )

end

function rp.Error( str )

	MsgC( Color( 195, 195, 195 ), "[CryRP] [" )
	
	MsgC( Color( 255, 0, 0 ), "*" )
	
	MsgC( Color( 195, 195, 195 ), "] " )
	
	MsgC( color_white, str .. "\n" )

end

function rp.include( path )

	MsgC( Color( 195, 195, 195 ), "[CryRP] " )
	
	local fileSize
	
	if file.Exists( "gamemodes/cryrp/gamemode/" .. path, "GAME" ) then
	
		fileSize = math.Round( tonumber( file.Size( "gamemodes/cryrp/gamemode/" .. path, "GAME" ) ) / 1000 ) or "?"
	
		MsgC( Color( 195, 195, 195 ), "[" )	
		MsgC( Color( 0, 255, 0 ), "+" )		
		MsgC( Color( 195, 195, 195 ), "] " )	
		MsgC( color_white, path )	
		MsgC( Color( 255, 255, 0 ), " (" .. fileSize .. "kb)\n" )
		
	else
		
		MsgC( Color( 195, 195, 195 ), "[" )	
		MsgC( Color( 255, 0, 0 ), "-" )		
		MsgC( Color( 195, 195, 195 ), "] " )
		MsgC( color_white, path )		
		MsgC( Color( 255, 0, 0 ), " (Not found)\n" )
		
		return
		
	end

	return include( path )
	
end

function meta.Player:Notify( msg, typ, dur )

	net.Start( "rp_Notify" )
	
		net.WriteString( msg )
		
		net.WriteString( typ )
		
		net.WriteString( dur )
	
	net.Send( self )

end

--[[---------------------------------------------------------
	Load everything manually to keep it in proper order
-----------------------------------------------------------]]

function rp.Initialize()
	
	AddCSLuaFile( "shared.lua" )
	
	AddCSLuaFile( "base/cl_optimization.lua" )
	
	AddCSLuaFile( "hooks/cl_gamemode.lua" )
	
	AddCSLuaFile( "hud/cl_scoreboard.lua" )
	
	AddCSLuaFile( "hud/cl_hud.lua" )	
	
	AddCSLuaFile( "doors/sh_doors.lua" )
	
	AddCSLuaFile( "doors/cl_door_hud.lua" )
	
	AddCSLuaFile( "cl_init.lua" )
		
	rp.include( "shared.lua" )

	rp.include( "config/sv.lua" )
		
	rp.include( "sql/sql.lua" )	
	
	rp.include( "doors/sh_doors.lua" )
	
	rp.include( "doors/sv_doors.lua" )
	
	rp.include( "money/sv_money.lua" )
		
	rp.include( "player/data.lua" )
	
	rp.include( "player/loadout.lua" )
	
	rp.include( "player/rpname.lua" )
	
	rp.include( "hooks/sv_gamemode.lua" )
	
	rp.include( "chat/commands.lua" )
	
end

rp.Initialize()
