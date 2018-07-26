--[[---------------------------------------------------------
	AddChatCommand
-----------------------------------------------------------]]

rp.ChatCommands = {

	["/dropmoney"] = function( ply, arg )
		
		local amt = tonumber( arg[2] )
		
		if !isnumber( amt ) then
			
			ply:Notify( "Invalid amount", 1, 2 )
			
			return
			
		end
		
		ply:dropMoney( amt )
	
	end,
	
	["/give"] = function( ply, arg )
	
		local targ = ply:GetEyeTrace().Entity
		
		local amt = tonumber( arg[2] )
		
		if !IsValid( targ ) then 
		
			ply:Notify( "Must be looking at a player to use '/give'", 1, 2 )
		
			return
			
		end
		
		if !isnumber( amt ) or amt < 1 then 
		
			ply:Notify( "Invalid amount", 1, 2 )
		
			return
		
		end
		
		ply:giveMoney( targ, amt )
	
	end,
	
	["/name"] = function( ply, arg )

		if !isstring( arg[2] ) or !isstring( arg[3] ) then
			
			ply:Notify( "You must choose a valid first & last name", 1, 2 )
			
			return
			
		end
	
		local str = tostring( arg[2] .. " " .. arg[3] )
		
		if !isstring( str ) then
			
			ply:Notify( "Invalid name", 1, 2 )
			
			return
			
		end
		
		ply:SetName( str )
	
	end,
	
	["/buy"] = function( ply, arg )
	
		local trace = ply:GetEyeTrace().Entity
		
		if !IsValid( trace ) then
			
			return
			
		end
		
		if !trace:isDoor() then 
			
			ply:Notify( "You must be looking at a door to use '/buy'", 1, 2 )
		
			return
			
		end
		
		ply:buyDoor( trace )
	
	end

}

// todo: fix
function rp.AddChatCommand( cmd, func )
	
	rp.Msg( "Added chat command '" .. cmd .. "'" )
	
	rp.ChatCommands[cmd] = func()
	
end


--[[---------------------------------------------------------
	PlayerSay hook for chat commands
-----------------------------------------------------------]]

function GM:PlayerSay( ply, text, team )

	local tab = string.Explode( " ", text )
	
	local cmd = string.lower( tab[1] )
	
	if text[1] == "/" && rp.ChatCommands[cmd] == nil then
	
		ply:Notify( "Unknown command", 1, 2 )
	
		return false
	
	end
	
	if rp.ChatCommands[cmd] != nil then
	
		rp.ChatCommands[tab[1]]( ply, tab )
	
		return false
	
	end

end