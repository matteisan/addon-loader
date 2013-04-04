--[[
	Menu shit 
	Remade to use DTree
]]--

-- Helper
local function parentsToDir( panel, text )
    local parent = panel:GetParent()
    local text = text or ""

    if IsValid( parent ) then
        local t = parent:GetText() 
        if t ~= "" then 
            text = parent:GetText() .. "/" .. text
        end

        text = parentsToDir( parent, text )
    end

    return string.TrimRight( text, "/" )
end

local function openMenu() 
	local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 310, 340 )
		Frame:Center()
		Frame:MakePopup()
		Frame:SetTitle( "Addon Loader" )


	local Tree = vgui.Create( "DTree", Frame )
		Tree:SetPos( 5, 25 )
		Tree:SetPadding( 5 )
		Tree:SetSize( 300, 275 )

	local Load = vgui.Create( "DButton", Frame )
		Load:SetText( "Load Files" )
		Load:SetSize( 100, 20 )
		Load:SetPos( 100, 310 ) 

		Load.DoClick = function()
			local item = Tree:GetSelectedItem()
			local text = parentsToDir( item )
			local val = text .. "/" .. item:GetText()
			openAllFromDir( val ) 
		end

	local _,d = file.Find( "*", "GAME" )
	for _,v in pairs( d ) do
		local node = Tree:AddNode( v )
		node:MakeFolder( v, "GAME", true )
	end
end

concommand.Add( "loadaddon_menu", openMenu )
