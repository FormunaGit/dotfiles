-- Services
local fs = require("@lune/fs")
local process = require("@lune/process")

-- Constants
local WALLPAPER_FOLDER = "/home/formuna/Data/Wallpapers/"

-- Wallpapers table.
-- Holds the filepath of every wallpaper.
local Wallpapers = {}

-- Grabs every wallpaper.
for _, Category in fs.readDir(WALLPAPER_FOLDER) do -- For every wallpaper category...
	for _, Wallpaper in fs.readDir(WALLPAPER_FOLDER .. Category) do -- Get every image..
		-- And add the image to the table.
		Wallpapers[#Wallpapers + 1] = WALLPAPER_FOLDER..Category.."/"..Wallpaper
	end
end

-- Random wallpaper
local RandomIndex = math.random(1, #Wallpapers)
local ChosenWallpaper = Wallpapers[RandomIndex]

-- Change the wallpaper
local CommandResult = process.exec("awww", {
	"img",
	"-t",
	"any",
	ChosenWallpaper
})

if CommandResult.ok then
	print(CommandResult.stdout)
else
	print(CommandResult.stderr)
end
