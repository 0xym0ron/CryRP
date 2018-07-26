--[[---------------------------------------------------------
	MySQL database integration	
	Also my first attempt at using SQL.
-----------------------------------------------------------]]

require( "mysqloo" )

--[[---------------------------------------------------------
	Make initial SQL connection
-----------------------------------------------------------]]

function rp.ConnectToSQL( func )

	rp.SQL = mysqloo.connect( rp.Config.SQL.Host, rp.Config.SQL.Username, rp.Config.SQL.Password, rp.Config.SQL.Name, rp.Config.SQL.Port )

	rp.SQL.onConnected = function()
	
		rp.Msg( "Connected to SQL server" )
		
		if isfunction( func ) then
		
			func()
		
		end
		
	end
	
	rp.SQL.onConnectionFailed = function( e )
	
		rp.Error( "Failed to connect to SQL server (" .. e .. ")" )
	
	end
	
	rp.SQL:connect()
	
end

--[[---------------------------------------------------------
	Create initial SQL tables
-----------------------------------------------------------]]

function rp.CreateSQLTables()

	local query = rp.SQL:query( [[CREATE TABLE IF NOT EXISTS Players(
	SID BIGINT NOT NULL PRIMARY KEY,
	Name VARCHAR(45),
	Money INTEGER NOT NULL,
	Bank INTEGER NOT NULL
	)]] )
	
	query.onSuccess = function( q )	
	end
		
	query.onError = function( q, e )
	end	
	
	query:start()
	
end

--[[---------------------------------------------------------
	Set a variable for a player
-----------------------------------------------------------]]

function meta.Player:SetSQLVar( k, v, func )
	
	local query = rp.SQL:query( "SELECT * FROM Players WHERE SID = '" .. self:SteamID64() .. "'" )
	
	query.onSuccess = function( q )
	
		local data = q:getData()
		
		if data[1]["SID"] != self:SteamID64() then
			
			rp.Error( "Failed to get SQL table for '" .. self:SteamID64() .. "' unable to set SQL var" )
			
			return
			
		end
		
		if isnumber( v ) then
			
			v = tostring( v ) 
			
		end
		
		local modify = rp.SQL:query( "UPDATE Players SET `" .. rp.SQL:escape( k ) .. "` = '" .. rp.SQL:escape( v ) .. "' WHERE SID = " .. self:SteamID64() .. ";" )
		
		modify.onSuccess = function( q )
		
			if isfunction( func ) then
			
				func()
			
			end
			
		end
	
		modify.onError = function( q, e )
		
			rp.Error( "Failed to insert data '" .. v .. "' into '" .. self:SteamID64() .. "'s 'Player' table (" .. e .. ")" )
			
			if isfunction( func ) then
			
				func()
			
			end
			
		end
		
		modify:start()
	
	end
	
	query.onError = function( q, e )
		
		rp.Error( "Failed to insert data '" .. v .. "' into '" .. self:SteamID64() .. "'s 'Player' table (" .. e .. ")" )
		
	end
	
	query:start()

end

--[[---------------------------------------------------------
	Get a variable for a player
-----------------------------------------------------------]]

function meta.Player:GetSQLVar( k, func )

	local query = rp.SQL:query( "SELECT `" .. k .. "` FROM Players WHERE SID = '" .. self:SteamID64() .. "'" )
	
	local ret = nil
	
	query.onData = function( q, d )
	
		if d && d[k] then
			
			ret = d[k]
			
			if isfunction( func ) then
					
				func( ret )	
					
			end
			
		end
	
	end
	
	query.onError = function( q, e )
		
		rp.Error( "Failed to get SQL var '" .. k .. "' for '" .. self:SteamID64() .. "'" )
		
		ret = "nil"

		if isfunction( func ) then
			
			func( ret )
			
		end
		
	end
	
	query:start()
	
end

--[[---------------------------------------------------------
	Load or create player data SQL table
-----------------------------------------------------------]]

function meta.Player:LoadPlayerData()

	if self:IsBot() then return end

	local query = rp.SQL:query( "SELECT * FROM Players WHERE SID = '" .. self:SteamID64() .. "'" )

	query.onSuccess = function( q )
		
		local data = q:getData()
		
		if data != nil && data[1] != nil && data[1]["SID"] == self:SteamID64() then
			
			self:SetupVars( data[1] )
			
			rp.Msg( "Loading player data for '" .. self:SteamID64() .. "'" )
			
			return
			
		end
		
		local insert = rp.SQL:query( "INSERT INTO Players( SID, Money, Bank ) VALUES ( '" .. self:SteamID64() .. "', " .. rp.Config["Starting Money"] .. ", " .. rp.Config["Starting Bank Money"] .. " )" )
		
		insert.onSuccess = function( q )
			
			self:LoadPlayerData()
			
			rp.Msg( "Created SQL table for '" .. self:SteamID64() .. "'" )
		
		end
		
		insert.onError = function( q, e )
		
			rp.Error( "Failed to create SQL table for '" .. self:SteamID64() .. "' (" .. e .. ")" )
		
		end
		
		insert:start()
	
	end
	
	query.onError = function( q, e )
	
		rp.Error( "Failed to access Players table for '" .. self:SteamID64() .. "' (" .. e .. ")" )
	
	end
	
	query:start()
	
end

--[[---------------------------------------------------------
	Connect to the SQL then proceed to do shit
-----------------------------------------------------------]]

rp.ConnectToSQL( function() 

	rp.CreateSQLTables()
	
end )
