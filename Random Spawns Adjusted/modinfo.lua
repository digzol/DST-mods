name = "Random Spawns Adjusted"
description = [[This mod allows spawning random entities around players every few seconds or by using a command.
Entities are set in various categories (edibles, mobs, weapons, bosses, etc.) which have configurable spawn chances.]]
author = "Platypus"
version = "1.0.9"
version_compatible = "1.0.0"
api_version = 10
all_clients_require_mod = false
dont_starve_compatible = false
dst_compatible = true
--icon_atlas = "modicon.xml"
--icon = "modicon.tex"

local weighted_chance_options = {}
local function GetWeightedChances()
	if #weighted_chance_options < 1 then
		weighted_chance_options = {}
		weighted_chance_options[1] = {description = "None", data = 0}
		weighted_chance_options[2] = {description = "1", data = 1}
		for i=1,40 do
			weighted_chance_options[i + 2] = {description = i * 5, data = i * 5}
		end
	end
	return weighted_chance_options
end

configuration_options =
{
	{
		name = "AUTO_START",
		label = "Auto start",
		hover = "Automatically start the spawning timer on server startup.",
		options = {
			{description = "Yes", data = true},
			{description = "No", data = false}
		},
		default = true
	},
	{
		name = "ALLOW_WATER",
		label = "Allow boat spawns",
		hover = "Whether spawns can happen while on a boat or should only happen on land.",
		options = {
			{description = "Yes", data = true},
			{description = "No", data = false}
		},
		default = true
	},
	{
		name = "MAX_SPAWN_DISTANCE",
		label = "Spawn range",
		hover = "The maximum distance from the player an entity can spawn.\nDefault: 2",
		options = {
			{description = "0", data = 0},
			{description = "1", data = 1},
			{description = "2", data = 2},
			{description = "3", data = 3},
			{description = "4", data = 4},
			{description = "5", data = 5},
			{description = "6", data = 6},
			{description = "7", data = 7},
			{description = "8", data = 8},
			{description = "9", data = 9},
			{description = "10", data = 10},
			{description = "11", data = 11},
			{description = "12", data = 12},
			{description = "13", data = 13},
			{description = "14", data = 14},
			{description = "15", data = 15},
		},
		default = 2
	},
	{
		name = "SPAWN_DELAY",
		label = "Spawn delay",
		hover = "Seconds until the next spawn.\nDefault value: 30 seconds",
		options = {
			{description = "1 second", data = 1},
			{description = "2 seconds", data = 2},
			{description = "5 seconds", data = 5},
			{description = "10 seconds", data = 10},
			{description = "15 seconds", data = 15},
			{description = "30 seconds", data = 30},
			{description = "45 seconds", data = 45},
			{description = "1 minute", data = 60},
			{description = "2 minutes", data = 120},
			{description = "5 minutes", data = 300},
			{description = "10 minutes", data = 600},
			{description = "15 minutes", data = 900},
			{description = "30 minutes", data = 1800},
			{description = "60 minutes", data = 3600},
		},
		default = 30
	},
	{
		name = "ARMOR_CHANCE",
		label = "Armor chance",
		hover = "Armor items spawn chance weighted against other categories.\nDefault value: 40",
		options = GetWeightedChances(),
		default = 60
	},
	{
		name = "BLUEPRINT_CHANCE",
		label = "Blueprint chance",
		hover = "Blueprints spawn chance weighted against other categories.\nDefault value: 10",
		options = GetWeightedChances(),
		default = 10
	},
	{
		name = "BOSS_CHANCE",
		label = "Boss chance",
		hover = "Bosses spawn chance weighted against other categories.\nDefault value: 10",
		options = GetWeightedChances(),
		default = 10
	},
	{
		name = "CLOTHING_CHANCE",
		label = "Clothing chance",
		hover = "Clothing spawn chance weighted items against other categories.\nDefault value: 15",
		options = GetWeightedChances(),
		default = 15
	},
	{
		name = "EFFECT_CHANCE",
		label = "Effect chance",
		hover = "Special effects spawn chance weighted against other categories.\nDefault value: 15",
		options = GetWeightedChances(),
		default = 15
	},
	{
		name = "FOOD_CHANCE",
		label = "Edibles chance",
		hover = "Edible items spawn chance weighted against other categories.\nDefault value: 10",
		options = GetWeightedChances(),
		default = 10
	},
	{
		name = "HEALING_CHANCE",
		label = "Healing item chance",
		hover = "Healing items spawn chance weighted against other categories.\nDefault value: 20",
		options = GetWeightedChances(),
		default = 20
	},
	{
		name = "MATERIAL_CHANCE",
		label = "Material item chance",
		hover = "Material items spawn chance weighted against other categories.\nDefault value: 10",
		options = GetWeightedChances(),
		default = 10
	},
	{
		name = "MOB_CHANCE",
		label = "Creature chance",
		hover = "Creatures spawn chance weighted against other categories.\nDefault value: 180",
		options = GetWeightedChances(),
		default = 180
	},
	{
		name = "STRUCTURE_CHANCE",
		label = "Structure chance",
		hover = "Structures spawn chance weighted against other categories.\nDefault value: 40",
		options = GetWeightedChances(),
		default = 40
	},
	{
		name = "TOOL_CHANCE",
		label = "Tool chance",
		hover = "Tools spawn chance weighted against other categories.\nDefault value: 30",
		options = GetWeightedChances(),
		default = 30
	},
	{
		name = "TRINKET_CHANCE",
		label = "Trinket chance",
		hover = "Trinkets spawn chance weighted against other categories.\nDefault value: 5",
		options = GetWeightedChances(),
		default = 5
	},
	{
		name = "WEAPON_CHANCE",
		label = "Weapon chance",
		hover = "Weapons spawn chance weighted against other categories.\nDefault value: 40",
		options = GetWeightedChances(),
		default = 60
	},
	{
		name = "MISC_CHANCE",
		label = "Misc. stuff chance",
		hover = "Miscellaneous stuff spawn chance weighted against other categories.\nDefault value: 10",
		options = GetWeightedChances(),
		default = 10
	},
}