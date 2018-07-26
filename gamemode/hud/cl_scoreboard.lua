sb = sb or {}

function sb.Show()
	
	sb.test = vgui.Create( "DFrame" )
	sb.test:SetSize( 400, 400 )
	sb.test:Center()
	sb.test:MakePopup()
	sb.test:SetTitle( GetHostName() )
	
	sb.test:SetDraggable( false )
	sb.test:ShowCloseButton( false )
	
	sb.test.Paint = function( self, w, h )
	
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 200 ) )
	
	end

	local yPos = 25
	
	for k, v in next, player.GetAll() do
	
		local DCollapsible = vgui.Create( "DCollapsibleCategory", sb.test )
		DCollapsible:SetPos( 5, yPos )
		DCollapsible:SetSize( sb.test:GetWide() - 10, 30 )
		DCollapsible:SetExpanded( 0 )
		DCollapsible:SetLabel( v:GetNWString( "Name" ) )

		local DermaList = vgui.Create( "DPanelList", DermaPanel )
		DermaList:EnableVerticalScrollbar( false )
		DermaList:SetSpacing( 5 )
		DermaList:EnableHorizontal( false )	
		
		DCollapsible:SetContents( DermaList )
		
		local Money = vgui.Create( "DLabel" )
		Money:SetText( "Money: $" .. string.Comma( v:GetNWInt( "Money" ) ) )
		
		DermaList:AddItem( Money )
		
		yPos = yPos + 25
	
	end
	
end

function sb.Hide()

	if ispanel( sb.test ) then
		
		sb.test:Close()
		
	end

end

function GM:ScoreboardShow() 

	sb.Show()
	
	return false

end

function GM:ScoreboardHide()
	
	return sb.Hide()

end