local mapInfo = {
  author = "Your Name Here",
  description = "Map blueprint for ZK",
  modtype = 3,
  name = "ZKMapBlueprint",
  shortname = "ZKMapBlueprint",
  version = "v0.0",
  voidGround = false,
  voidWater = false,
  custom = {},
  depend = {
    "Map Helper v1",
  },
  grass = {},
  replace = {},
  maphardness     = 350,
  gravity         = 130,
  tidalStrength   = 0,
  maxMetal        = 1.7,
  extractorRadius = 100.0,
  resources = {
	detailTex = "cont_DET.bmp",
	splatDetailTex = "Zsplat.dds",
	splatDetailNormalDiffuseAlpha = 1,
  },
  smf = {
    maxheight = 100,
    minheight = -50,
    smtFileName0 = "mapblueprint.smt",
  },
  teams = {
    [0] = {
      startPos = {
        x = 3072,
        z = 3072,
      },
    },
    [1] = {
      startPos = {
        x = 3072,
        z = 3072,
      },
    },
    [2] = {
      startPos = {
        x = 3072,
        z = 3072,
      },
    },
  },
  terrainTypes = {},
  atmosphere = {

		minWind      = 2,
		maxWind      = 30,

		fogStart     = 0.58,
		fogEnd       = 0.85,
		fogColor     = {1.0, 0.8, 0.4},

		sunColor     = {1.0, 0.8, 0.0},
		skycolor     = {0.3, 0.45, 0.9},
		skyDir       = {0.0, 0.0, -1.0},
		--skyBox       = "",

		cloudDensity = 0.65,
		cloudColor   = {1.0, 0.9, 0.7},
	},

	lighting = {
		--// dynsun
		sunStartAngle = 0.0,
		sunOrbitTime  = 1440.0,
		sundir        = { -0.5, 0.5, 0.5 },

		--// unit & ground lighting
         groundambientcolor            = { 0.94, 0.64, 0.74 },
         grounddiffusecolor            = { 1.0, 0.75, 0.8 },
         groundshadowdensity           = 0.95,
         unitambientcolor           = { 0.85, 0.55, 0.65 },
         unitdiffusecolor           = { 1.0, 0.75, 0.8 },
         unitshadowdensity          = 0.95,
		 specularsuncolor           = { 1.0, 0.65, 0.75 },
		 
		specularExponent    = 100.0,
	},
	
	water = {
		damage =  0,

		repeatX = 0.0,
		repeatY = 0.0,

		absorb    = { 0.012, 0.006, 0.0045 },
		basecolor = { 0.70, 0.9, 1.0 },
		mincolor  = { 0.02, 0.45, 0.65 },

		ambientFactor  = 1.3,
		diffuseFactor  = 1.0,
		specularFactor = 1.4,
		specularPower  = 40.0,

		surfacecolor  = { 0.6, 0.54, 0.86 },
		surfaceAlpha  = 0.16,
		--diffuseColor  = {0.0, 0.0, 0.0},
		specularColor = {0.5, 0.5, 0.5},
		planeColor = {0.008, 0.035, 0.00},

		fresnelMin   = 0.3,
		fresnelMax   = 0.8,
		fresnelPower = 8.0,

		reflectionDistortion = 1.0,

		blurBase      = 2.0,
		blurExponent = 1.5,

		perlinStartFreq  =  8.0,
		perlinLacunarity = 3.0,
		perlinAmplitude  =  0.9,
		windSpeed = 1.0, --// does nothing yet

		shoreWaves = true,
		forceRendering = false,
		
		hasWaterPlane = false,

		--// undefined == load them from resources.lua!
		--texture =       "",
		--foamTexture =   "",
		--normalTexture = "",
		--caustics = {
		--	"",
		--	"",
		--},
	},
}
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Helper

local function lowerkeys(ta)
    local fix = {}
    for i,v in pairs(ta) do
        if (type(i) == "string") then
            if (i ~= i:lower()) then
                fix[#fix+1] = i
            end
        end
        if (type(v) == "table") then
            lowerkeys(v)
        end
    end

    for i=1,#fix do
        local idx = fix[i]
        ta[idx:lower()] = ta[idx]
        ta[idx] = nil
    end
end

lowerkeys(mapInfo)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Map Options

if (Spring) then
    local function tmerge(t1, t2)
        for i,v in pairs(t2) do
            if (type(v) == "table") then
                t1[i] = t1[i] or {}
                tmerge(t1[i], v)
            else
                t1[i] = v
            end
        end
    end

    -- make code safe in unitsync
    if (not Spring.GetMapOptions) then
        Spring.GetMapOptions = function() return {} end
    end
    function tobool(val)
        local t = type(val)
        if (t == 'nil') then
            return false
        elseif (t == 'boolean') then
            return val
        elseif (t == 'number') then
            return (val ~= 0)
        elseif (t == 'string') then
            return ((val ~= '0') and (val ~= 'false'))
        end
        return false
    end

    getfenv()["mapInfo"] = mapInfo
        local files = VFS.DirList("mapconfig/mapinfo/", "*.lua")
        table.sort(files)
        for i=1,#files do
            local newcfg = VFS.Include(files[i])
            if newcfg then
                lowerkeys(newcfg)
                tmerge(mapInfo, newcfg)
            end
        end
    getfenv()["mapInfo"] = nil
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return mapInfo
