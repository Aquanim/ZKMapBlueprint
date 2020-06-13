
local featureDef	=	{
	alwaysvisible		= true,
	name				= "geocrack",
	blocking			= false,
	category			= "misc",
	--collisionVolumeScales = [0,0,0],
	damage				= 10000,
	description			= "visual crack for geovent",
	energy				= 0,
	flammable			= 0,
	footprintX			= 0,
	footprintZ			= 0,
	height				= "8",
	hitdensity			= "0",
	indestructible 	= true,
	metal				= 0,
	--object				= "crystal.dae",
	reclaimable			= false,
	autoreclaimable		= false, 	
	world				= "All Worlds",
	useBuildingGroundDecal =true,
	buildingGroundDecalDecaySpeed= 2.0,
  buildingGroundDecalType = "geo.dds",
  buildingGroundDecalSizeX = 3,
  buildingGroundDecalSizeY = 3,
}
return lowerkeys({geocrack = featureDef})