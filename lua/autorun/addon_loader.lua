-- Load everything

if SERVER then 
	AddCSLuaFile( "loadaddon.lua" )
	AddCSLuaFile( "loadaddon_menu.lua" )
end

if CLIENT then
	include( "loadaddon.lua" )
	include( "loadaddon_menu.lua" )
end