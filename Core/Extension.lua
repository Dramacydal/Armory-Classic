function Armory:dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k, v in pairs(o) do
         if type(k) ~= 'number' then k = '"' .. k .. '"' end
         s = s .. '[' .. k .. '] = ' .. self:dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local icons = {
   ['inv'] = 133823,
   ['bags'] = 130716,
   ['auc'] = 133785,
   ['bank'] = 'Interface/Addons/BagBrother/art/achievement-guildperk-mobilebanking',
   ['mail'] = 133469,
}

function Armory:getIcon(name)
   local iconId = icons[name]
   if iconId ~= nil then
      return '|T' .. iconId .. ':12:12:6:0|t'
   end

   return nil
end

local ALLIANCE_BANNER = 'Interface/Icons/Inv_BannerPvP_02'
local DEFAULT_COORDS = { 0, 1, 0, 1 }
local HORDE_BANNER = 'Interface/Icons/Inv_BannerPvP_01'
local RACE_TEXTURE = 'Interface/Glues/CharacterCreate/UI-CharacterCreate-Races'
local RACE_TABLE = {
   HUMAN_MALE      = { 0, 0.25, 0, 0.25 },
   DWARF_MALE      = { 0.25, 0.5, 0, 0.25 },
   GNOME_MALE      = { 0.5, 0.75, 0, 0.25 },
   NIGHTELF_MALE   = { 0.75, 1.0, 0, 0.25 },
   TAUREN_MALE     = { 0, 0.25, 0.25, 0.5 },
   SCOURGE_MALE    = { 0.25, 0.5, 0.25, 0.5 },
   TROLL_MALE      = { 0.5, 0.75, 0.25, 0.5 },
   ORC_MALE        = { 0.75, 1.0, 0.25, 0.5 },
   HUMAN_FEMALE    = { 0, 0.25, 0.5, 0.75 },
   DWARF_FEMALE    = { 0.25, 0.5, 0.5, 0.75 },
   GNOME_FEMALE    = { 0.5, 0.75, 0.5, 0.75 },
   NIGHTELF_FEMALE = { 0.75, 1.0, 0.5, 0.75 },
   TAUREN_FEMALE   = { 0, 0.25, 0.75, 1.0 },
   SCOURGE_FEMALE  = { 0.25, 0.5, 0.75, 1.0 },
   TROLL_FEMALE    = { 0.5, 0.75, 0.75, 1.0 },
   ORC_FEMALE      = { 0.75, 1.0, 0.75, 1.0 },
}

function Armory:GetIconTexture(unit, size, x, y)
   local icon, coords = self:GetIcon(unit)
   if coords then
      local u, v, w, z = unpack(coords)
      return CreateTextureMarkup(icon, 128, 128, size or 12, size or 12, u, v, w, z, x or 0, y or 0)
   else
      return CreateAtlasMarkup(icon, size, size, 0, 0)
   end
end

function Armory:GetIcon(unit)
   local sex = self:UnitSex(unit);
   local _, raceEn = self:UnitRace(unit);
   if raceEn then
      return RACE_TEXTURE, RACE_TABLE[raceEn:upper() .. '_' .. (sex == 3 and 'FEMALE' or 'MALE')]
   end

   return self.faction and ALLIANCE_BANNER or HORDE_BANNER, DEFAULT_COORDS
end
