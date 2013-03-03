======================================
== GMod 13 Clientside Addon Loader ===
======================================
  Why?
In GMod 13, clientside addons
need to be manually loaded. This makes 
that process one helluva lot easier.

I also added in the ability to load from 
data and lua folders. Just for shiggles.

Author: Adult

==================================
===== Instructions:

Bind a key to "lua_openscript_cl autorun/addon-loader.lua"
Use commands.

==================================
===== Commands:  

loadaddon <folder>
	-Recursively loads all .lua files in the given folder.
	-Ex: loadaddon addons/Wallhack
	-Ex: loadaddon lua/test

loadaddon_menu
	-Opens a menu in order to make loading addons easier.
