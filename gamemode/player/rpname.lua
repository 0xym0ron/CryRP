function meta.Player:SetName( str )

	self:SetSQLVar( "Name", str, function()
		
		self:Notify( "Name changed to '" .. str .. "'", 0, 2 )
	
		self:GetSQLVar( "Name", function( name )
		
			self:SetNWString( "Name", name )
		
		end )
	
	end )

end