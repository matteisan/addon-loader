--[[
	GMod 13 Clientside Addon Loader.
	Why? In GMod 13, clientside addons
	need to be manually loaded. This makes 
	that process one helluva lot easier.

	I also added in the ability to load from 
	data and lua folders. Just for shiggles.

	Author: Adult
]]--


-- Takes off the "..../lua/"
-- Global to use in menus
function takeOffDirectory( directory )
	local _, e = string.find( directory, "lua/" )
	if not e then return directory end 

	return string.sub( directory, e + 1, string.len( directory ) ) 
end

-- Loads the script
local function openScript( filename )
	-- Don't load non-lua files.
	if string.sub( filename, -4 ) ~= ".lua" then return end

	print("Loading file: " .. filename )
	include( filename )
end


-- Returns expanded directory
function expand( dir, tbl )
        local files, dirs = file.Find( dir .. "/*", "GAME" )
        local ret = tbl or {}

        local files = files or {}
        local dirs  = dirs or {}

        -- add the files
        for i=1,#files do
                table.insert( ret, dir .. "/" .. files[i] )
        end

        if not dirs then return ret end 
        
        -- add all the files in the directory
        for _,v in pairs( dirs ) do 
                expand( dir .. "/" .. v, ret )
        end
        
        return ret 
end

-- Loads files from a directory
-- Global to use in menu
function openAllFromDir( addon )
	-- Fancy shit
	MsgC( Color(0,255,0), "==================================\n" )
	MsgC( Color(0,255,0), "======= Loading Client Lua =======\n" )
	MsgC( Color(0,255,0), "==================================\n" )

	local isdir = file.IsDir( addon, "GAME" )

	-- Error checking
	if not isdir and not file.Exists( addon, "GAME" ) then
		MsgC( Color(255,0,0), addon .. " not found!" )
		return 
	end

	-- Defeats the purpose if it's just loading a single file.
	if not isdir then
		openScript( takeOffDirectory( addon ) )
		return 
	end

	-- Tell you what's going on pls.
	MsgC( Color(0,255,0), "Loading: " .. addon .. "\n" )

	local tmp = expand( addon )

	for _,v in pairs( tmp ) do
		openScript( takeOffDirectory( v ) )
	end
end


concommand.Add( "loadaddon", function( _, _, args)
	openAllFromDir( args[1] )
end)
