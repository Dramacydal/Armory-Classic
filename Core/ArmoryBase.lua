--[[
    Armory Addon for World of Warcraft(tm).
    Revision: @file-revision@ @file-date-iso@
    URL: http://www.wow-neighbours.com

    License:
        This program is free software; you can redistribute it and/or
        modify it under the terms of the GNU General Public License
        as published by the Free Software Foundation; either version 2
        of the License, or (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program(see GPL.txt); if not, write to the Free Software
        Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

    Note:
        This AddOn's source code is specifically designed to work with
        World of Warcraft's interpreted AddOn system.
        You have an implicit licence to use this AddOn with these facilities
        since that is it's designated purpose as per:
        http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat
--]]

ARMORY_ID = "Armory";

ARMORY_MESSAGE_SEPARATOR = "\v";
ARMORY_LOOKUP_SEPARATOR = "\n";
ARMORY_LOOKUP_FIELD_SEPARATOR = "\r";
ARMORY_LOOKUP_CONTENT_SEPARATOR = "\f";
ARMORY_TOOLTIP_COLUMN_SEPARATOR = "\029";
ARMORY_TOOLTIP_TEXTURE_SEPARATOR = "\030";
ARMORY_TOOLTIP_CONTENT_SEPARATOR = "\031";

if ( not Armory ) then
    Armory = {
        messaging = true,

        title = ARMORY_TITLE,
        version = C_AddOns.GetAddOnMetadata("Armory", "Version"),
        dbVersion = 1,
        interface = _G.GetBuildInfo(),
        isClassic = _G.GetExpansionLevel() == LE_EXPANSION_CLASSIC,
    };
end

local Armory, _ = Armory;
local QTip = LibStub("LibQTip-1.0");
local DBIcon = LibStub("LibDBIcon-1.0");

local iconProvider, cellPrototype, baseCellPrototype = QTip:CreateCellProvider(QTip.LabelProvider)

function cellPrototype:InitializeCell()
    baseCellPrototype.InitializeCell(self);
end

function cellPrototype:SetupCell(tooltip, value, justification, font)
    local _, height = baseCellPrototype.SetupCell(self, tooltip, format("|T%s:0|t", tostring(value)), "CENTER");
    return baseCellPrototype.SetupCell(self, tooltip, format("|T%s:%2$d:%2$d:0:0:64:64:4:60:4:60|t", tostring(value), height), "CENTER");
end

function Armory:Debug(...)
    local dbEntry = self.settingsDbEntry;
    local debug = dbEntry:GetValue("Debug");
    if ( select("#", ...) > 0 ) then
        debug = ...;
        dbEntry:SetValue("Debug", debug and true or nil);
    end
    return debug;
end

function Armory:PlayWarningSound()
    if ( self:GetConfigWarningSound() ) then
        PlaySound(self:GetConfigWarningSound());
    end
end

function Armory:Fullname()
    --return self.title..LIGHTYELLOW_FONT_COLOR_CODE.." (v"..self.version..")"..FONT_COLOR_CODE_CLOSE;
    return self.title;
end

function Armory:PrintTitle(...)
    self:Print("["..self:Fullname().."]", ...);
end

function Armory:PrintWarning(text)
    if ( self:GetConfigEnableSystemWarnings() ) then
        self:PrintTitle(RED_FONT_COLOR_CODE..ARMORY_WARNING..":"..FONT_COLOR_CODE_CLOSE, text);
    end
end

function Armory:PrintError(text)
    self:PrintTitle(RED_FONT_COLOR_CODE..ARMORY_ERROR..":"..FONT_COLOR_CODE_CLOSE, text);
    self:PlayWarningSound();
end

function Armory:PrintInfo(text)
    self:PrintTitle(RED_FONT_COLOR_CODE..ARMORY_INFO..":"..FONT_COLOR_CODE_CLOSE, text);
end

function Armory:PrintRed(text)
    self:PrintTitle(RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE);
end

function Armory:PrintDebug(...)
    if ( self:Debug() ) then
        self:PrintMessage(self:ToString(1, self.interface..RED_FONT_COLOR_CODE, ...));
    end
end

function Armory:PrintCommunication(...)
    if ( self:GetConfigShowShareMessages() ) then
        self:PrintMessage(self:ToString(1, "["..self:Fullname().."]"..LIGHTYELLOW_FONT_COLOR_CODE, ...));
    end
end

function Armory:PrintSearchResult(who, line)
    local windowMode = ArmoryFindFrame:IsShown() or self:GetConfigSearchWindow();
    local what, count;
    if ( windowMode ) then
        what = line.name;
    else
        what = (line.link or line.name);
    end
    if ( line.link and what ~= line.link ) then
        local color = self:GetColorFromLink(line.link);
        if ( color ) then
            what = color..what..FONT_COLOR_CODE_CLOSE;
        end
    end

    if ( windowMode ) then
        count = line.count;
        if ( count and line.extra ) then
            if ( line.extra:sub(1, 1) == "(" ) then
                count = count..line.extra;
            else
                count = count.." ("..line.extra..")";
            end
        end
        ArmoryFindFrame_Add(who, line.label, what, line.link, line.tooltipLines, count);
    else
        if ( line.extra ) then
            what = what.." ("..line.extra..")";
        end
        if ( line.count ) then
            what = what.."x"..line.count;
        end
        if ( line.label ~= "" ) then
            who = strtrim(who.." "..NORMAL_FONT_COLOR_CODE..line.label..":"..FONT_COLOR_CODE_CLOSE);
        end
        if ( who ~= "" ) then
            self:Print(who, what);
        else
            self:Print(what);
        end
    end
end

function Armory:Print(...)
    self:PrintMessage(self:ToString(1, ...));
end

function Armory:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg);

    if ( Elephant and Elephant.InitCustomStructure and Elephant.CaptureNewMessage ) then
        local lcname, cname = strlower(ARMORY_TITLE), ARMORY_TITLE;
        Elephant:InitCustomStructure(lcname, cname);
        Elephant:CaptureNewMessage({['type'] = "SYSTEM", ['arg1'] = msg, ['time'] = time()}, lcname);
    end
end

function Armory:ChatCommand(msg)
    local args = self:String2Table(msg);
    local printUsage =
        function(cmd)
            self:PrintTitle(ARMORY_CMD_USAGE);
            for i = 1, table.getn(self.usage) do
                if ( not cmd or cmd == ARMORY_CMD_HELP or cmd == self.usage[i][3] ) then
                    self:Print(self:GetUsageLine(i));
                end
            end
        end;

    if ( args and args[1] ) then
        local command = strlower(args[1]);
        if ( command == "debug" ) then
            Armory:Debug(not Armory:Debug());
            if ( Armory:Debug() ) then
                self:Print("Debug is now on");
            else
                self:Print("Debug is now off");
            end
        elseif ( command == "who" ) then
            if ( self.users ) then
                for name, info in pairs(self.users) do
                    local channel, version, lastSeen = strsplit("|", info);
                    --if ( tonumber(lastSeen) >= time() - ARMORY_BROADCAST_DELAY - 10 ) then
                        self:Print(name, version, "("..channel..")");
                    --end
                end
            else
                self:Print("Start collecting users");
                self.users = {};
            end
        elseif ( command:find("|h") ) then
            self:Find(self:ParseArgs(args[1]));
        else
            table.remove(args, 1);
            if ( self.commands[command] ) then
                if ( self.commands[command](unpack(args)) ) then
                    printUsage(command);
                end
            else
                printUsage();
            end
        end
    else
        self:Toggle();
    end
end

function Armory:SetCommand(label, func, afterLabel)
    local command = _G[label:gsub("^(ARMORY_CMD_%u-)_.*$", "%1")];
    local help = _G[label.."_TEXT"];
    local params, options, usage, disabled, index;

    if ( label == "ARMORY_CMD_SET_NOVALUE" ) then
        params = "xxx";
    elseif ( label == "ARMORY_CMD_FIND" ) then
        local cat = {ARMORY_CMD_FIND_ALL};
        if ( self:HasInventory() ) then
            table.insert(cat, ARMORY_CMD_FIND_ITEM);
            table.insert(cat, ARMORY_CMD_FIND_INVENTORY);
        end
        if ( self:HasQuestLog() ) then
            table.insert(cat, ARMORY_CMD_FIND_QUEST);
        end
        if ( self:HasSpellBook() ) then
            table.insert(cat, ARMORY_CMD_FIND_SPELL);
        end
        if ( self:HasTradeSkills() ) then
            table.insert(cat, ARMORY_CMD_FIND_SKILL);
        end
        if ( #cat == 1 ) then
            return;
        end
        params = strjoin("|", unpack(cat));
    elseif ( label == "ARMORY_CMD_CHECK" and not self:HasInventory() ) then
        return;
    elseif ( label == "ARMORY_CMD_CHECKCD" and not self:HasTradeSkills() ) then
        return;
    elseif ( _G[label] == command ) then
        params = "";
    else
        params = _G[label] or "";
    end

    if ( self.options[label] ) then
        if ( self.options[label].disabled and self.options[label].disabled() ) then
            return;
        elseif ( self.options[label].type == "toggle" ) then
            options = ARMORY_CMD_SET_ON.."|"..ARMORY_CMD_SET_OFF;
        end
    end
    if ( _G[label.."_PARAMS_TEXT"] ) then
        options = _G[label.."_PARAMS_TEXT"];
        help = format(help, options);
    end
    if ( options and options ~= params ) then
        params = params.." "..options;
    end

    usage = SLASH_ARMORY2.." "..command;
    if ( params ~= "" ) then
        usage = usage.." "..params;
    end
    if ( afterLabel ) then
        for i = 1, table.getn(self.usage) do
            if ( self.usage[i][4] == afterLabel ) then
                index = i + 1;
                break;
            end
        end
    end

    if ( index ) then
        table.insert(self.usage, index, {usage, help, command, label});
    else
        table.insert(self.usage, {usage, help, command, label});
    end

    for _, command in ipairs(self:StringSplit("|", command)) do
        self.commands[command] = func;
    end
end

function Armory:GetUsageLine(index)
    local usage = self.usage[index];
    if ( usage ) then
        return "  "..usage[1]..GRAY_FONT_COLOR_CODE.." - "..usage[2]..FONT_COLOR_CODE_CLOSE;
    end
end

function Armory:InitializeIcon()
    if ( not DBIcon:IsRegistered(ARMORY_ID) ) then
        DBIcon:RegisterCallback("LibDBIcon_IconCreated", function(event, button, id)
            if ( id == ARMORY_ID ) then
                button:HookScript("OnDragStop", function()
                    self:SetConfigMinimapAngle(button.db.minimapPos);
                end);
            end
        end);
        DBIcon:Register(ARMORY_ID, self.LDB, { minimapPos = self:GetConfigMinimapAngle(), hide = true });
    end

    self:ShowIcon();
end

function Armory:MoveIconToPosition()
    local button = DBIcon:GetMinimapButton(ARMORY_ID);
    if ( button ) then
        button.db.minimapPos = self:GetConfigMinimapAngle();
        DBIcon:SetButtonToPosition(button, self:GetConfigMinimapAngle());
    end
end

local function ShowIcon(show)
    local button = DBIcon:GetMinimapButton(ARMORY_ID);
    if ( button ) then
        button.db.hide = not show;
    end
    if ( show ) then
        DBIcon:Show(ARMORY_ID);
    else
        DBIcon:Hide(ARMORY_ID);
    end
end

function Armory:ShowIcon(force)
    if ( force or self:GetConfigShowMinimap() ) then
        if ( not force and self:GetConfigHideMinimapIfToolbar() and (C_AddOns.IsAddOnLoaded("FuBar") or C_AddOns.IsAddOnLoaded("TitanClassic")) ) then
            ShowIcon(false);
        else
            self:MoveIconToPosition();
            ShowIcon(true);
        end
    else
        ShowIcon(false);
    end
end

function Armory:PrepareMenu()
    if ( not self.menu ) then
        self.menu = CreateFrame("Frame", "ArmoryMenu", nil, "ArmoryDropDownMenuTemplate");
        ArmoryDropDownMenu_Initialize(self.menu, self.InitializeMenu, "MENU");
    end
end

function Armory:InitializeMenu()
    if ( ARMORY_DROPDOWNMENU_MENU_LEVEL == 2 ) then
        Armory:MenuAddButton("ARMORY_CMD_SET_SHARESKILLS");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHAREQUESTS");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHARECHARACTER");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHAREALT");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHAREININSTANCE");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHAREINCOMBAT");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWSHAREMSG");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHAREALL", true);
        Armory:MenuAddButton("ARMORY_CMD_LOOKUP", true);
    else
        local info = {};
        info.text = ARMORY_TITLE;
        info.notClickable = 1;
        info.isTitle = 1;
        ArmoryDropDownMenu_AddButton(info);

        Armory:MenuAddButton("ARMORY_CMD_SET_SEARCHALL");
        Armory:MenuAddButton("ARMORY_CMD_SET_LASTVIEWED");
        Armory:MenuAddButton("ARMORY_CMD_SET_PERCHARACTER");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWALTEQUIP", true);
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWUNEQUIP");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWEQCTOOLTIPS");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWITEMCOUNT");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWKNOWNBY");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWHASSKILL");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWCANLEARN");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWCRAFTERS");
        Armory:MenuAddButton("ARMORY_CMD_SET_SHOWSUMMARY");
        Armory:MenuAddButton("ARMORY_CMD_SET_PAUSEINCOMBAT");
        Armory:MenuAddButton("ARMORY_CMD_SET_USEFACTIONFILTER");
        Armory:MenuAddButton("ARMORY_CMD_SET_USECLASSCOLORS");
        Armory:MenuAddButton("ARMORY_CMD_SET_USERACEICONS");
        Armory:MenuAddButton("ARMORY_CMD_CONFIG", true);
        Armory:MenuAddButton("ARMORY_CMD_CHECK");
        Armory:MenuAddButton("ARMORY_CMD_FIND", true);
        Armory:MenuAddButton("ARMORY_CMD_RESET_FRAME");

        ArmoryDropDownMenu_AddButton({text=ARMORY_SHARE_LABEL, hasArrow=1, owner=Armory.menu});
    end
end

function Armory:MenuAddButton(label, closeMenu)
    local entry = self.options[label];
    local info = {};

    info.text = _G[label.."_MENUTEXT"];
    info.tooltipTitle = info.text;
    info.tooltipText = _G[label.."_TOOLTIP"] or self:Proper(_G[label.."_TEXT"]);
    if ( entry.type == "toggle" ) then
        info.getFunc = entry.get;
        info.setFunc = entry.set;
        info.func = function() info.setFunc(not info.getFunc()) end;
        info.checked = entry.get();
        info.keepShownOnClick = not closeMenu;
    else
        info.runFunc = entry.run;
        info.func = function() info.runFunc() end;
    end
    if ( entry.disabled ) then
        info.disabled = entry.disabled();
    end

    ArmoryDropDownMenu_AddButton(info, ARMORY_DROPDOWNMENU_MENU_LEVEL);
end

function Armory:Init()
    self.dbLoaded = false;
    self.dbLocked = false;
    self.locked = {};
    self.modulesDbEntry = nil;
    self.settingsDbEntry = nil;
    self.settingsLocalDbEntry = nil;
    self.sharedDbEntry = nil;
    self.selectedDbBaseEntry = nil;
    self.playerRealm = _G.GetRealmName();
    self.player = _G.UnitName("player");
    self.playerDbBaseEntry = nil;
    self.characterRealm = _G.GetRealmName();
    self.character = nil;
    self.selectedPet = nil;
    self.profiles = {};
    self.selectableProfiles = {};
    self.hasEquipment = false;
    self.hasStats = false;
    self.collapsedHeaders = {};
    self.realms = {};
    self.postalRealms = {};
    self.characters = {};
    self.qtip = QTip;
    self.qtipIconProvider = iconProvider;

    if ( not self.commandHandler ) then
        self.commandHandler = ArmoryCommandHandler:new{};
    end

    SlashCmdList["ARMORY"] = function(...)
        return self:ChatCommand(...);
    end;

    self.usage = {
        {SLASH_ARMORY2, ARMORY_CMD_TOGGLE}
    };

    if ( not self.commands ) then
        self.commands = {};

        self:SetCommand("ARMORY_CMD_HELP", function() return true end);
        self:SetCommand("ARMORY_CMD_CONFIG", function() ArmoryOptionsPanel:Open() end);
        self:SetCommand("ARMORY_CMD_DELETE_ALL", function(...) return Armory:ClearDb(...) end);
        self:SetCommand("ARMORY_CMD_DELETE_REALM", function(...) return Armory:ClearDb(...) end);
        self:SetCommand("ARMORY_CMD_DELETE_CHAR", function(...) return Armory:ClearDb(...) end);
        --self:SetCommand("ARMORY_CMD_SET_NOVALUE");
        --self:SetCommand("ARMORY_CMD_SET_EXPDAYS", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_SEARCHALL", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_LASTVIEWED", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_PERCHARACTER", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_SHOWALTEQUIP", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_SHOWUNEQUIP", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_SHOWEQCTOOLTIPS", function(...) return Armory:SetConfig(...) end);
        --self:SetCommand("ARMORY_CMD_SET_SHOWITEMCOUNT", function(...) return Armory:SetConfig(...) end);
        self:SetCommand("ARMORY_CMD_RESET_FRAME", function(...) return Armory:Reset(...) end);
        self:SetCommand("ARMORY_CMD_RESET_SETTINGS", function(...) return Armory:Reset(...) end);
        self:SetCommand("ARMORY_CMD_CHECK", function(...) Armory:CheckMailItems(nil, ...) end);
        self:SetCommand("ARMORY_CMD_CHECKCD", function(...) Armory:CheckTradeSkillCooldowns(...) end);
        self:SetCommand("ARMORY_CMD_FIND", function(...) return Armory:Find(Armory:ParseArgs(...)) end);
        self:SetCommand("ARMORY_CMD_LOOKUP", function(...) ArmoryLookupFrame_Toggle() end);

        for i = 1, C_AddOns.GetNumAddOns() do
            if ( C_AddOns.GetAddOnInfo(i) == ARMORY_SHARE_DOWNLOAD_ADDON ) then
                self:SetCommand("ARMORY_CMD_DOWNLOAD", function(...) ArmoryLookupFrame_StartDownload(...) end);
                break;
            end
        end
    end
end

function Armory:InitDb()
    if ( not ArmoryModules ) then
        ArmoryModules = {};
    end
    self.modulesDbEntry = ArmoryDbEntry:new(ArmoryModules);

    if ( not ArmorySettings ) then
        ArmorySettings = {};
    end
    self.settingsDbEntry = ArmoryDbEntry:new(ArmorySettings);

    if ( not ArmoryLocalSettings ) then
        ArmoryLocalSettings = {};
    end
    self.settingsLocalDbEntry = ArmoryDbEntry:new(ArmoryLocalSettings);

    if ( not (ArmoryDB and self:IsDbCompatible()) ) then
        ArmoryDB = {};
        ArmoryShared = nil;
        ArmoryCache = nil;
    end

    if ( not ArmoryShared ) then
        ArmoryShared = {};
    end
    self.sharedDbEntry = ArmoryDbEntry:new(ArmoryShared);

    if ( self:GetConfigCharacterEnabled() ) then
        if ( not ArmoryDB[self.playerRealm] ) then
            ArmoryDB[self.playerRealm] = {};
        end
        if ( not ArmoryDB[self.playerRealm][self.player] ) then
            ArmoryDB[self.playerRealm][self.player] = {};
        end

        self.playerDbBaseEntry = ArmoryDbEntry:new(ArmoryDB[self.playerRealm][self.player]);
    elseif ( ArmoryDB[self.playerRealm] ) then
         ArmoryDB[self.playerRealm][self.player] = nil;
    end

    self:ResetProfile();
    self:ResetSelectableCharacters();
    self:SelectDefaultProfile();

    self.dbLoaded = true;
end

function Armory:IsDbCompatible()
    local dbEntry = self.settingsDbEntry;
    local dbVersion = dbEntry:GetValue("DbVersion");
    local upgraded, entry;

    if ( not dbVersion ) then
        dbEntry:SetValue("DbVersion", self.dbVersion);

    elseif ( dbVersion ~= self.dbVersion) then
        if ( upgraded ) then
            dbEntry:SetValue("DbVersion", dbVersion + 1);
            return self:IsDbCompatible();
        end

        dbEntry:SetValue("DbVersion", self.dbVersion);
        ArmoryStaticPopup_Show("ARMORY_DB_INCOMPATIBLE");
        return false;
    end

    return true;
end

local function Convert(data, label)
    if ( label == ARMORY_CACHE_CONTAINER and Armory:GetConfigUseEncoding() ) then
        data[label] = nil;
    elseif ( type(data[label]) == "table" and not ArmoryDbEntry.IsNativeTable(data[label]) ) then
        for key in pairs(data[label]) do
            Convert(data[label], key);
        end
    else
        data[label] = ArmoryDbEntry.Save(ArmoryDbEntry.Load(data[label]));
    end
end

function Armory:ConvertDb()
    for realm in pairs(ArmoryDB) do
        for character in pairs(ArmoryDB[realm]) do
            for label in pairs(ArmoryDB[realm][character]) do
                Convert(ArmoryDB[realm][character], label);
            end
        end
    end
    for label in pairs(ArmorySettings) do
        Convert(ArmorySettings, label);
    end
    for label in pairs(ArmoryModules) do
        Convert(ArmoryModules, label);
    end
    if ( Armory:GetConfigUseEncoding() ) then
        ArmoryCache = nil;
    end
end

function Armory:SetConfig(what, arg1, arg2)
    local invalidCommand = false;
    local entry;

    if ( what ) then
        what = strlower(what);

        if ( what == strlower(ARMORY_CMD_SET_EXPDAYS) ) then
            entry = self.options.ARMORY_CMD_SET_EXPDAYS;
            if ( tonumber(arg1) ) then
                arg1 = tonumber(arg1);
                if ( arg1 >= entry.minValue and arg1 <= entry.maxValue ) then
                    entry.set(tonumber(arg1));
                    if ( arg1 == 0 ) then
                        arg1 = arg1.." ("..OFF..")";
                    end
                    self:Print(format(ARMORY_CMD_SET_SUCCESS, ARMORY_CMD_SET_EXPDAYS, arg1));
                else
                    self:Print(format(ARMORY_CMD_SET_EXPDAYS_INVALID, ARMORY_CMD_SET_EXPDAYS_PARAMS_TEXT, entry.maxValue));
                end
            elseif ( entry.get() == 0 ) then
                self:Print(format(ARMORY_CMD_SET_NOVALUE, "0 ("..OFF..")"));
            else
                self:Print(format(ARMORY_CMD_SET_NOVALUE, entry.get()));
            end

        else
            if ( what == strlower(ARMORY_CMD_SET_SEARCHALL) ) then
                entry = self.options.ARMORY_CMD_SET_SEARCHALL;
            elseif ( what == strlower(ARMORY_CMD_SET_LASTVIEWED) ) then
                entry = self.options.ARMORY_CMD_SET_LASTVIEWED;
            elseif ( what == strlower(ARMORY_CMD_SET_SHOWALTEQUIP) ) then
                entry = self.options.ARMORY_CMD_SET_SHOWALTEQUIP;
            elseif ( what == strlower(ARMORY_CMD_SET_SHOWUNEQUIP) ) then
                entry = self.options.ARMORY_CMD_SET_SHOWUNEQUIP;
            elseif ( what == strlower(ARMORY_CMD_SET_SHOWEQCTOOLTIPS) ) then
                entry = self.options.ARMORY_CMD_SET_SHOWEQCTOOLTIPS;
            elseif ( what == strlower(ARMORY_CMD_SET_SHOWITEMCOUNT) ) then
                entry = self.options.ARMORY_CMD_SET_SHOWITEMCOUNT;
            elseif ( what == strlower(ARMORY_CMD_SET_PERCHARACTER) ) then
                entry = self.options.ARMORY_CMD_SET_PERCHARACTER;
            end

            if ( entry ) then
                invalidCommand = self:SwitchSetting(what, arg1, entry.set, entry.get);
            else
                invalidCommand = true;
            end
        end
    else
        invalidCommand = true;
    end

    return invalidCommand;
end

function Armory:SwitchSetting(what, arg1, onoffSet, onoffGet)
    local on = strlower(ARMORY_CMD_SET_ON);
    local off = strlower(ARMORY_CMD_SET_OFF);

    if ( arg1 ) then
        arg1 = strlower(arg1);
        if ( arg1 == on ) then
            onoffSet(self, true);
            self:Print(format(ARMORY_CMD_SET_SUCCESS, strlower(what), on));
        elseif ( arg1 == off ) then
            onoffSet(self, false);
            self:Print(format(ARMORY_CMD_SET_SUCCESS, strlower(what), off));
        else
            return true;
        end
    elseif ( onoffGet(self) ) then
        self:Print(format(ARMORY_CMD_SET_NOVALUE, on));
    else
        self:Print(format(ARMORY_CMD_SET_NOVALUE, off));
    end
    return false;
end

function Armory:ClearDb(what, arg1, arg2)
    local invalidCommand = false;
    local playerDeleted;

    if ( what ) then
        what = strlower(what);

        if ( ArmoryFrame:IsVisible() ) then
            self:Toggle();
        end

        self.dbLocked = true;
        if ( what == strlower(ARMORY_CMD_DELETE_ALL) ) then
            ArmoryDB = {};
            ArmoryShared = {};
            ArmoryCache = nil;
            if ( ArmorySettings ) then
                ArmorySettings["PerCharacter"] = nil;
            end
            playerDeleted = true;
            self:Print(ARMORY_CMD_DELETE_ALL_MSG);
        elseif ( what == strlower(ARMORY_CMD_DELETE_REALM)  ) then
            if ( not arg1 or arg1 == "" ) then
                arg1 = self.playerRealm;
            end
            self:RealmState(arg1, nil);
            if ( ArmoryDB[arg1] ) then
                for character in pairs(ArmoryDB[arg1]) do
                    self:DeleteProfile(arg1, character, true);
                end
                playerDeleted = (arg1 == self.playerRealm);
                self:Print(format(ARMORY_CMD_DELETE_REALM_MSG, arg1));
            else
                self:Print(format(ARMORY_CMD_DELETE_REALM_NOT_FOUND, arg1));
            end
        elseif ( what == strlower(ARMORY_CMD_DELETE_CHAR) ) then
            if ( not arg1 or arg1 == "" ) then
                arg1 = self.player;
            end
            if ( not arg2 or arg2 == "" ) then
                arg2 = self.playerRealm;
            end
            if ( ArmoryDB[arg2] and ArmoryDB[arg2][arg1] ) then
                self:DeleteProfile(arg2, arg1, true);
                playerDeleted = (arg1 == self.player and arg2 == self.playerRealm);
                self:Print(format(ARMORY_CMD_DELETE_CHAR_MSG, arg1, arg2));
            else
                self:Print(format(ARMORY_CMD_DELETE_CHAR_NOT_FOUND, arg1, arg2));
            end
        else
            invalidCommand = true;
        end
    else
        invalidCommand = true;
    end

    self:Init();
    self:InitDb();

    -- make sure all required values are saved once again
    if ( playerDeleted ) then
        for _, frameName in ipairs(ARMORYFRAME_SUBFRAMES) do
            local frame = _G[frameName];
            local eventHandler = frame:GetScript("OnEvent");
            if ( eventHandler ) then
                eventHandler(frame, "PLAYER_ENTERING_WORLD");
            end
        end
        for _, frameName in ipairs(ARMORYFRAME_CHILDFRAMES) do
            local frame = _G[frameName];
            local eventHandler = frame:GetScript("OnEvent");
            if ( eventHandler ) then
                eventHandler(frame, "PLAYER_ENTERING_WORLD");
            end
            _G[frameName]:Hide();
        end
    end

    return invalidCommand;
end

function Armory:CleanUpDb()
    local currentProfile = self:CurrentProfile();
    local myClasses = {};

    for realm in pairs(ArmoryDB) do
        for character in pairs(ArmoryDB[realm]) do
            self:LoadProfile(realm, character);
            local _, className = self:UnitClass("player");
            myClasses[className] = true;
        end
    end
    self:SelectProfile(currentProfile);

    local notMyClasses = {};
    for _, className in ipairs(CLASS_SORT_ORDER) do
        if ( not myClasses[className] ) then
            notMyClasses[className] = true;
        end
    end

    for className in pairs(notMyClasses) do
        ArmoryShared[className] = nil;
    end
end

function Armory:Reset(what, silent)
    local invalidCommand = false;

    if ( what ) then
        what = strlower(what);

        if ( what == strlower(ARMORY_CMD_RESET_FRAME) ) then
            for _, frameName in ipairs(ARMORYFRAME_MAINFRAMES) do
                _G[frameName]:ClearAllPoints();
                _G[frameName]:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 20, -110);
            end
            self:SetConfigFrameScale(1);
            ArmoryOptionsPanel.ScaleSlider:SetValue(1);
            if ( not silent ) then
                self:Print(ARMORY_CMD_RESET_FRAME_SUCCESS);
            end
        elseif ( what == strlower(ARMORY_CMD_RESET_SETTINGS) ) then
            self.settingsDbEntry:Clear();
            if ( not silent ) then
                self:Print(ARMORY_CMD_RESET_SETTINGS_SUCCESS);
            end
        else
            invalidCommand = true;
        end
    else
        invalidCommand = true;
    end

    return invalidCommand;
end

function Armory:Close()
    if ( ArmoryFrame:IsVisible() ) then
        ArmoryCloseChildWindows();
        self:Toggle();
    end
    self:HideSummary(true);
end

function Armory:Setting(key, subkey, ...)
    local set = select("#", ...) > 0;
    if ( self.settingsDbEntry ) then
        if ( set ) then
            self.settingsDbEntry:SetValue(2, key, subkey, ...);
            if ( key ~= "General" ) then
                self:LocalSetting(key, subkey, ...);
            end
        end
        if ( key ~= "General" and self:GetConfigPerCharacter() ) then
            return self:LocalSetting(key, subkey);
        else
            return self.settingsDbEntry:GetValue(key, subkey);
        end
    end
end

function Armory:LocalSetting(key, subkey, ...)
    local set = select("#", ...) > 0;
    if ( self.settingsLocalDbEntry ) then
        if ( set ) then
            self.settingsLocalDbEntry:SetValue(2, key, subkey, ...);
        end
        return self.settingsLocalDbEntry:GetValue(key, subkey);
    end
end

function Armory:CharacterSetting(key, unit, ...)
    local set = select("#", ...) > 0;
    if ( self.settingsDbEntry ) then
        local dbEntry = self.settingsDbEntry;
        local realm = self.playerRealm;
        local character = self.player;

        if ( set ) then
            dbEntry:SetValue(4, "PerCharacter", realm, character, key, ...);
        end

        if (unit ~= "player") then
            realm, character = self:GetPaperDollLastViewed();
        end
        return dbEntry:GetValue("PerCharacter", realm, character, key);
    end
end

function Armory:AllCharacterSetting(key, ...)
    if ( self.settingsDbEntry ) then
        local dbEntry = self.settingsDbEntry;

        for realm in pairs(ArmoryDB) do
            for character in pairs(ArmoryDB[realm]) do
                dbEntry:SetValue(4, "PerCharacter", realm, character, key, ...);
            end
        end
    end
end

function Armory:ItemFilterSetting(key)
    if ( not ArmorySettings ) then
        ArmorySettings = {};
    end
    if ( not ArmorySettings.Filters ) then
        ArmorySettings.Filters = {};
    end
    if ( not ArmorySettings.Filters[key] ) then
        ArmorySettings.Filters[key] = {};
    end

    return ArmorySettings.Filters[key];
end

function Armory:CanHandleEvents()
    return self.dbLoaded and not self.dbLocked;
end

function Armory:ExecuteConditional(func, ...)
    return self.commandHandler:AddConditionalCommand(func, ...);
end

function Armory:ExecuteDelayed(delay, func, ...)
    return self.commandHandler:AddDelayedCommand(delay, func, ...);
end

function Armory:Execute(func, ...)
    return self.commandHandler:AddCommand(func, ...);
end

function Armory:IsExecuted(command)
    return not self.commandHandler:IsQueued(command);
end

function Armory:Profiles(reload)
    if ( reload ) then
        table.wipe(self.profiles);
        table.wipe(self.selectableProfiles);
    end

    if ( ArmoryDB and table.getn(self.profiles) == 0 ) then
        for realm in pairs(ArmoryDB) do
            for character in pairs(ArmoryDB[realm]) do
                table.insert(self.profiles, {realm=realm, character=character});
            end
        end
        table.sort(self.profiles, function(a, b) return a.realm..a.character < b.realm..b.character end);
    end

    return self.profiles;
end

function Armory:SelectableProfiles()
    if ( not self:GetConfigUseFactionFilter() ) then
        return self:Profiles();
    end

    if ( table.getn(self.selectableProfiles) == 0 ) then
        for _, realm in ipairs(self:RealmList()) do
            for _, character in ipairs(self:CharacterList(realm)) do
                table.insert(self.selectableProfiles, {realm=realm, character=character});
            end
        end
    end

    return self.selectableProfiles;
end

function Armory:CurrentProfile()
    local realm, character = self:GetPaperDollLastViewed();
    return {realm=realm, character=character};
end

function Armory:SelectProfile(profile)
    return self:LoadProfile(profile.realm, profile.character);
end

function Armory:SetProfile(profile)
    self:SelectProfile(profile);
    self.LDB.icon = Armory:GetPortraitTexture("player");
    self.LDB.value = profile.character;
    if ( self:GetConfigLDBLabel() ) then
        self.LDB.text = ARMORY_TITLE..": "..profile.character;
    else
        self.LDB.text = profile.character;
    end
end

function Armory:SelectDefaultProfile()
    if ( not self:GetConfigCharacterEnabled() ) then
        if ( self:GetNumCharacters(self.playerRealm) > 0 ) then
            self:LoadProfile(self.playerRealm, self:CharacterList(self.playerRealm)[1]);
            return;
        else
            for _, realm in ipairs(self:RealmList()) do
                if ( self:GetNumCharacters(realm) > 0 ) then
                   self:LoadProfile(realm, self:CharacterList(realm)[1]);
                   return;
                end
            end
        end
        HideUIPanel(ArmoryFrame);
    end
end

function Armory:ResetProfile()
    self.selectedDbBaseEntry = self.playerDbBaseEntry;
    self.characterRealm = self.playerRealm;
    self.character = self.player;
end

function Armory:ResetSelectableCharacters()
    table.wipe(self.profiles);
    table.wipe(self.selectableProfiles);
    table.wipe(self.realms);
    table.wipe(self.characters);
end

function Armory:ProfileExists(profile)
    if ( not profile.realm or not profile.character ) then
        return false;
    elseif ( not ArmoryDB[profile.realm] ) then
        return false;
    elseif ( not ArmoryDB[profile.realm][profile.character] ) then
        return false;
    end
    return true;
end

function Armory:LoadProfile(realm, character)
    realm = realm or _G.GetRealmName();
    character = character or self.player;

    self:SetPaperDollLastViewed(realm, nil);
    self:ResetProfile();

    if ( not ArmoryDB ) then
        return;
    elseif ( not ArmoryDB[realm] ) then
        return;
    elseif ( not ArmoryDB[realm][character] ) then
        return;
    end

    self:SetPaperDollLastViewed(realm, character);
    self.selectedDbBaseEntry = ArmoryDbEntry:new(ArmoryDB[realm][character]);

    return self.selectedDbBaseEntry;
end

function Armory:DeleteProfile(realm, character, force)
    if ( (not force) and realm == self.playerRealm and character == self.player ) then
        return;
    elseif ( not ArmoryDB ) then
        return;
    elseif ( not ArmoryDB[realm] ) then
        return;
    elseif ( not ArmoryDB[realm][character] ) then
        return;
    end

    ArmoryDB[realm][character] = nil;
    self:CleanUpDb();

    self:ResetProfile();

    if ( realm ~= self.playerRealm and self:GetNumCharacters(realm) == 0 ) then
        ArmoryDB[realm] = nil;
        self:SetPaperDollLastViewed(self.playerRealm, nil);
    else
        self:SetPaperDollLastViewed(realm, nil);
    end

    self:ResetSelectableCharacters();
    self:SelectDefaultProfile();

    if ( not ArmorySettings["PerCharacter"] ) then
        return;
    elseif ( not ArmorySettings["PerCharacter"][realm] ) then
        return;
    end
    ArmorySettings["PerCharacter"][realm][character] = nil;
end

function Armory:IsPlayerSelected(profile)
    local realm, character;
    if ( profile ) then
        realm = profile.realm;
        character = profile.character;
    else
        realm, character = self:GetPaperDollLastViewed();
    end
    return realm == self.playerRealm and character == self.player;
end

function Armory:SelectedCharacter()
    return self.characterRealm .. self.character;
end

function Armory:IsSelectedCharacter(value)
    return value == self.characterRealm .. self.character;
end

function Armory:Toggle()
    if ( table.getn(self:SelectableProfiles()) == 0 ) then
        self:PrintRed(ARMORY_NO_DATA);
    elseif ( ArmoryFrame:IsVisible()  ) then
        HideUIPanel(ArmoryFrame);
    else
        ShowUIPanel(ArmoryFrame);
    end
end

function Armory:RealmState(realm, collapsed)
    if ( not ArmoryLocalSettings ) then
        ArmoryLocalSettings = {};
    end
    if ( not ArmoryLocalSettings.DropDown ) then
        ArmoryLocalSettings.DropDown = {};
    end
    if ( realm ) then
        ArmoryLocalSettings.DropDown[realm] = collapsed;
    end
    return ArmoryLocalSettings.DropDown;
end

function Armory:GetPostalRealmName(postalRealm)
    if ( ArmoryDB and #self.postalRealms == 0 ) then
        for realm in pairs(ArmoryDB) do
            self.postalRealms[realm:gsub("[%-%s]", "")] = realm;
        end
    end
    return self.postalRealms[postalRealm] or postalRealm;
end

function Armory:GetConnectedRealms()
    if ( not self.connectedRealms ) then
        self.connectedRealms = _G.GetAutoCompleteRealms();
        local numRealms = table.getn(self.connectedRealms);
        if ( numRealms == 0 ) then
            self.connectedRealms[1] = self.playerRealm;
        else
            for i = 1, numRealms do
                self.connectedRealms[i] = self:GetPostalRealmName(self.connectedRealms[i]);
            end
        end
    end
    return self.connectedRealms;
end

function Armory:IsConnectedRealm(value, explicit)
    if ( value == self.playerRealm ) then
        return not explicit;
    end

    for _, realm in ipairs(self:GetConnectedRealms()) do
        if ( realm == value ) then
            return true;
        end
    end
    return false;
end

function Armory:ConnectedRealmExists()
    for _, realm in ipairs(self:GetConnectedRealms()) do
        if ( realm ~= self.characterRealm and ArmoryDB[realm] ) then
            return true;
        end
    end
    return false;
end

local connectedProfiles = {};
function Armory:GetConnectedProfiles()
    table.wipe(connectedProfiles);
    for _, realm in ipairs(self:GetConnectedRealms()) do
        local characters = self:CharacterList(realm);
        for _, character in ipairs(characters) do
            table.insert(connectedProfiles, {realm=realm, character=character});
        end
    end
    return connectedProfiles;
end

function Armory:GetQualifiedCharacterName(showRealm)
    local realm, character = self:GetPaperDollLastViewed();
    local name = character;
    showRealm = showRealm or realm ~= self.playerRealm;
    if ( showRealm ) then
        name = name .. "-" .. realm;
    end
    local class, classEn = self:UnitClass("player");
    local classColor = self:ClassColor(classEn, true);
    if ( self:GetConfigUseClassColors() ) then
        name = "|c"..classColor..name..FONT_COLOR_CODE_CLOSE;
        if ( self:GetConfigUseRaceIcons() ) then
            name = self:GetIconTexture("player") .. ' ' .. name
        end
    end
    if ( showRealm and self:IsConnectedRealm(realm, true) ) then
        name = name .. "|TInterface\\FriendsFrame\\UI-FriendsFrame-Link.blp:0|t";
    end
    return name, "|c" .. classColor;
end

function Armory:RealmList()
    if ( ArmoryDB and table.getn(self.realms) == 0 ) then
        for realm in pairs(ArmoryDB) do
            if ( not self:GetConfigUseFactionFilter() or (self:IsConnectedRealm(realm) and table.getn(self:CharacterList(realm)) > 0) ) then
                table.insert(self.realms, realm);
            end
        end
        table.sort(self.realms);
    end
    return self.realms or {};
end

function Armory:CharacterList(realm)
    if ( realm and ArmoryDB and ArmoryDB[realm] ) then
        if ( not self.characters[realm] ) then
            self.characters[realm] = {};
        end
        if ( table.getn(self.characters[realm]) == 0 ) then
            local currentProfile = self:CurrentProfile();
            for character in pairs(ArmoryDB[realm]) do
                self:LoadProfile(realm, character);
                if ( not self:GetConfigUseFactionFilter() or _G.UnitFactionGroup("player") == self:UnitFactionGroup("player") ) then
                    table.insert(self.characters[realm], character);
                end
            end
            self:SelectProfile(currentProfile);
            table.sort(self.characters[realm]);
        end
        return self.characters[realm];
    end
    return {};
end

function Armory:GetNumCharacters(realm)
    local numCharacters = 0;
    if ( realm and ArmoryDB and ArmoryDB[realm] ) then
        for _ in pairs(ArmoryDB[realm]) do
            numCharacters = numCharacters + 1;
        end
    end
    return numCharacters;
end

local mailProfiles = {};
function Armory:CheckMailItems(mode, days)
    local maxDays = self:GetConfigExpirationDays();
    local count = 0;
    local total = 0;
    local text;

    if ( days ) then
        days = tonumber(days);
        if ( days and days > 0 ) then
            maxDays = days;
        else
            self:Print(ARMORY_CMD_CHECK_INVALID);
            return;
        end
    end

    table.wipe(mailProfiles);
    if ( maxDays > 0 and self:HasInventory() ) then
        local currentProfile = self:CurrentProfile();
        for _, profile in ipairs(self:Profiles()) do
            self:SelectProfile(profile);
            local items = self:GetExpiredMailItems(maxDays);
            if ( #items > 0 ) then
                mailProfiles[profile] = items;
                for _, item in ipairs(items) do
                    if ( not mode ) then
                        text = format(ARMORY_CHECK_MAIL_MESSAGE, profile.character, profile.realm, item.name, item.left);
                        if ( item.ignored ) then
                            text = text..NORMAL_FONT_COLOR_CODE.." ("..IGNORED..")"..FONT_COLOR_CODE_CLOSE;
                        end
                        self:PrintWarning(text);
                    end
                    if ( not item.ignored ) then
                        count = count + 1;
                    end
                    total = total + 1;
                end
            end

            if ( mode ~= 2 and maxDays < 30 and self:ContainerExists(ARMORY_MAIL_CONTAINER) ) then
                if ( self:GetConfigMailCheckVisit() and not (self:GetConfigMailExcludeVisit() or (mode == 1 and self:GetConfigMailHideLogonVisit())) ) then
                    local _, _, _, timestamp = self:GetInventoryContainerInfo(ARMORY_MAIL_CONTAINER);
                    days = floor(time() / (24 * 60 * 60)) - floor(timestamp / (24 * 60 * 60));
                    if ( days >= 30 - maxDays and days < 31 ) then
                        self:PrintWarning(format(ARMORY_MAIL_VISIT_WARNING, profile.character, profile.realm, format(DAYS_ABBR, floor(days))));
                    end
                end

                if ( self:GetConfigMailCheckCount() and not (mode == 1 and self:GetConfigMailHideLogonCount()) ) then
                    local remaining = self:GetNumRemainingMailItems();
                    if ( remaining > 0 ) then
                        self:PrintWarning(format(ARMORY_MAIL_COUNT_WARNING2, profile.character, profile.realm, remaining));
                    end
                end
             end
        end
        self:SelectProfile(currentProfile);
        if ( total == 0 and not mode ) then
            self:PrintRed(ARMORY_CHECK_MAIL_NONE);
        end
    elseif ( not mode ) then
        self:PrintRed(ARMORY_CHECK_MAIL_DISABLED);
    end

    return count, mailProfiles;
end

function Armory:GetExpiredMailItems(maxDays)
    local _, numSlots = self:GetInventoryContainerInfo(ARMORY_MAIL_CONTAINER);
    local daysLeft, ignorable, link, name, count, ignored;
    local mailItems = {};
    if ( numSlots ) then
        for i = 1, numSlots do
            daysLeft, ignorable = self:GetContainerItemExpiration(ARMORY_MAIL_CONTAINER, i);
            if ( daysLeft and floor(daysLeft) <= maxDays ) then
                if ( daysLeft >= 1 ) then
                    daysLeft = format(DAYS_ABBR, floor(daysLeft));
                else
                    daysLeft = SecondsToTime(floor(daysLeft * 24 * 60 * 60));
                end
                if ( (daysLeft or "") ~= "" ) then
                    link = self:GetContainerItemLink(ARMORY_MAIL_CONTAINER, i);
                    _, count = self:GetContainerItemInfo(ARMORY_MAIL_CONTAINER, i);
                    name = self:GetItemLinkInfo(link);
                    if ( name ) then
                        if ( self:GetConfigMailIgnoreAlts() and ignorable ) then
                            ignored = true;
                        else
                            ignored = false;
                        end
                        table.insert(mailItems, {name=name, link=link, count=count, left=daysLeft, ignored=ignored});
                    end
                end
            end
        end
    end
    return mailItems;
end

local itemCounts = {};
function Armory:GetItemCount(link)

    table.wipe(itemCounts);

    if ( link and self:GetConfigShowItemCount() ) then
        local _, itemId = self:GetItemLinkInfo(link);
        if ( itemId and itemId:match("%d+") == tostring(HEARTHSTONE_ITEM_ID) ) then
            -- Hearthstone
        else
            local currentProfile = self:CurrentProfile();
            for _, profile in ipairs(self:Profiles()) do
                self:SelectProfile(profile);
                if ( (self:GetConfigGlobalItemCount() or self:IsConnectedRealm(profile.realm)) and (self:GetConfigCrossFactionItemCount() or _G.UnitFactionGroup("player") == self:UnitFactionGroup("player")) ) then
                    local mine = self:IsPlayerSelected();
                    local suspended = mine and self.commandHandler:IsPaused();
                    local name, classColor = self:GetQualifiedCharacterName(self:GetConfigGlobalItemCount());

                    local count, bagCount, bankCount, mailCount, auctionCount = 0, 0, 0, 0, 0;
                    local perSlotCount;
                    local equipCount = self:GetEquipCount(link);
                    if ( self:HasInventory() ) then
                        count, bagCount, bankCount, mailCount, auctionCount, perSlotCount = self:ScanInventory(link);
                        if ( suspended and equipCount == 0 ) then
                            name = name..RED_FONT_COLOR_CODE.." ("..ARMORY_UPDATE_SUSPENDED..")"..FONT_COLOR_CODE_CLOSE;
                        end
                    end
                    count = count + equipCount;
                    if ( count == 0 ) then
                        if ( suspended ) then
                            table.insert(itemCounts, {name=name, classColor=classColor, count=0});
                        end
                    else
                        table.insert(itemCounts, {name=name, classColor = classColor, count=count, bags=bagCount, bank=bankCount, mail=mailCount, auction=auctionCount, equipped=equipCount, perSlot=perSlotCount, mine=mine});
                    end
                end
            end
            self:SelectProfile(currentProfile);
        end
    end

    return itemCounts;
end

local multipleItemCounts = {};
function Armory:GetMultipleItemCount(items)

    table.wipe(multipleItemCounts);

    if ( self:HasInventory() and self:GetConfigShowItemCount() ) then
        for i = 1, #items do
            multipleItemCounts[i] = {};
        end

        local currentProfile = self:CurrentProfile();
        for _, profile in ipairs(self:Profiles()) do
            self:SelectProfile(profile);
            if ( (self:GetConfigGlobalItemCount() or self:IsConnectedRealm(profile.realm)) and (self:GetConfigCrossFactionItemCount() or _G.UnitFactionGroup("player") == self:UnitFactionGroup("player")) ) then
                local result = self:ScanInventoryItems(items);
                local mine = self:IsPlayerSelected();
                local suspended = mine and self.commandHandler:IsPaused();
                local name = self:GetQualifiedCharacterName(self:GetConfigGlobalItemCount());
                if ( suspended ) then
                    name = name..RED_FONT_COLOR_CODE.." ("..ARMORY_UPDATE_SUSPENDED..")"..FONT_COLOR_CODE_CLOSE;
                end
                for k, v in ipairs(result) do
                    if ( v.count > 0 ) then
                        table.insert(multipleItemCounts[k], {name=name, count=v.count, bags=v.bags, bank=v.bank, mail=v.mail, auction=v.auction, perSlot=v.perSlot, mine=mine});
                    elseif ( suspended ) then
                        table.insert(multipleItemCounts[k], {name=name, count=0});
                    end
                end
            end
        end
        self:SelectProfile(currentProfile);
    end

    return multipleItemCounts;
end

function Armory:FormatCount(value, color)
    if ( not color ) then
        color = self:HexColor(self:GetConfigItemCountNumberColor());
    end
    if ( type(value) == "string" ) then
        local formatted, replaced = value:gsub("%%d", color .. "%1" .. FONT_COLOR_CODE_CLOSE);
        if ( replaced > 0 ) then
            return formatted;
        end
    end
    return color .. value .. FONT_COLOR_CODE_CLOSE;
end

function Armory:FormatCountDetail(label, count)
    return (Armory:getIcon(label) or label) .. '  ' .. count;
end

local detailCounts = {};
function Armory:GetCountDetails(bagCount, bankCount, mailCount, auctionCount, altCount, equipCount, perSlotCount, color, totalColor)
    local details = "";
    local total = 0;
    table.wipe(detailCounts);
    if ( (equipCount or 0) > 0 ) then
        table.insert(detailCounts, self:FormatCountDetail('inv', equipCount));
        total = total + equipCount
    end
    if ( (bagCount or 0) > 0 ) then
        if ( perSlotCount and perSlotCount.bags ) then
            for k, v in pairs(perSlotCount.bags) do
                table.insert(detailCounts, self:FormatCountDetail(BAGSLOT.." "..k, v));
            end
        else
            table.insert(detailCounts, self:FormatCountDetail('bags', bagCount));
        end
        total = total + bagCount
    end
    if ( (bankCount or 0) > 0 ) then
        if ( perSlotCount and perSlotCount.bank ) then
            for k, v in pairs(perSlotCount.bank) do
                table.insert(detailCounts, self:FormatCountDetail(ARMORY_BANK_CONTAINER_NAME.." "..k, v));
            end
        else
            table.insert(detailCounts, self:FormatCountDetail('bank', bankCount));
        end
        total = total + bankCount
    end
    if ( (mailCount or 0) > 0 ) then
        table.insert(detailCounts, self:FormatCountDetail('mail', mailCount));
        total = total + mailCount
    end
    if ( (auctionCount or 0) > 0 ) then
        table.insert(detailCounts, self:FormatCountDetail('auc', auctionCount));
        total = total + auctionCount
    end
    if ( (altCount or 0) > 0 ) then
        table.insert(detailCounts, self:FormatCountDetail(ARMORY_ALTS, altCount));
        total = total + altCount
    end
    if ( #detailCounts > 0 ) then
        details = table.concat(detailCounts, " +");
    end
    if ( #detailCounts > 1 ) then
        details = self:FormatCount(details .. ' = ', color) .. self:FormatCount(total, totalColor);
    else
        details = self:FormatCount(details, totalColor);
    end

    table.wipe(detailCounts);
    return details;
end

function Armory:IsToday(time)
    return ( date("%x", time) == date("%x") );
end

function Armory:IsInWeek(timestamp, weekOffset)
    local eow = self:GetWeeklyResetTime() + (weekOffset or 0) * 7 * 24 * 60 * 60;
    local bow = eow - 7 * 24 * 60 * 60;
    return timestamp > bow and timestamp < eow;
end

function Armory:MakeDate(day, month, year, hour, minute)
    if ( day and month and year ) then
        if ( year < 2000 ) then
            year = year + 2000;
        end
        return time({year=year, month=month, day=day, hour=hour or 0, min=minute or 0});
    end
end

local weekdays = {
    WEEKDAY_SUNDAY,
    WEEKDAY_MONDAY,
    WEEKDAY_TUESDAY,
    WEEKDAY_WEDNESDAY,
    WEEKDAY_THURSDAY,
    WEEKDAY_FRIDAY,
    WEEKDAY_SATURDAY
};
local monthNames = {
    FULLDATE_MONTH_JANUARY,
    FULLDATE_MONTH_FEBRUARY,
    FULLDATE_MONTH_MARCH,
    FULLDATE_MONTH_APRIL,
    FULLDATE_MONTH_MAY,
    FULLDATE_MONTH_JUNE,
    FULLDATE_MONTH_JULY,
    FULLDATE_MONTH_AUGUST,
    FULLDATE_MONTH_SEPTEMBER,
    FULLDATE_MONTH_OCTOBER,
    FULLDATE_MONTH_NOVEMBER,
    FULLDATE_MONTH_DECEMBER,
};
function Armory:GetFullDate(timestamp)
    local date = type(timestamp) == "table" and timestamp or date("*t", timestamp);
    local weekdayName = weekdays[date.wday];
    local monthName = monthNames[date.month];
    return weekdayName, monthName, date.day, date.year, date.month, date.hour, date.min;
end

function Armory:MinutesTime(timestamp, tens)
    local factor = tens and 600 or 60;
    return self:Round((timestamp or time()) / factor) * factor;
end

function Armory:GetServerTime()
    local date = C_DateAndTime.GetTodaysDate();
    local month = date.month;
    local day = date.day;
    local year = date.year;
    local hour, min = GetGameTime();
    local serverTime = self:MakeDate(day, month, year, hour, min);
    local localTime = self:MinutesTime();
    local offset = serverTime - localTime;
    local bias = mod(offset, 100);
    if ( bias == 40 ) then
        offset = offset + 60;
    elseif ( bias == -40 ) then
        offset = offset - 60;
    elseif ( bias == 60 ) then
        offset = offset - 60;
    elseif ( bias == -60 ) then
        offset = offset + 60;
    end
    return serverTime, offset;
end

function Armory:GetServerTimeAsLocalTime(timestamp)
    local serverTime, offset = self:GetServerTime();
    return (timestamp or serverTime) - offset;
end

function Armory:GetLocalTimeAsServerTime(timestamp)
    local serverTime, offset = self:GetServerTime();
    return (timestamp or time()) + offset;
end

function Armory:Round(num, idp)
    local factor = 10^(idp or 0);
    return math.floor(num * factor + 0.5) / factor;
    --return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function Armory:Join(separator, ...)
    local numArgs = select("#", ...);
    local s = "";
    local arg;

    for i = 1, numArgs do
        arg = select(i, ...);
        if ( type(arg) == "number" ) then
           s = s.."N:"..tostring(arg);
        elseif ( type(arg) == "string" ) then
           s = s.."S:"..arg;
        end
        if ( i < numArgs ) then
            s = s..separator;
        end
    end

    return s;
end

function Armory:Split(separator, s)
    return self:SplitValues(self:StringSplit(separator, s));
end

function Armory:SplitValues(value, i)
    local getValue = function(v)
        local type, value = v:match("(.):(.*)");
        if ( type == "N" ) then
            return tonumber(value);
        elseif ( type == "S" ) then
            return value;
        else
            return nil;
        end
    end

    if ( type(value) == "table" ) then
        i = i or 1;
        if ( i <= #value ) then
            return getValue(value[i]), self:SplitValues(value, i + 1);
        end
    else
        return getValue(value);
    end
end

function Armory:StringSplit(separator, value)
    local fields = {};
    gsub(value..separator, "([^"..separator.."]*)"..separator, function(v) table.insert(fields, v) end);
    return fields;
end

function Armory:BuildColoredListString(...)
    if ( select("#", ...) == 0 ) then
        return nil;
    end

    -- Takes input where odd items are the text and even items determine whether the arg should be colored or not
    local text, normal = ...;
    local string = text;
    for i = 3, select("#", ...), 2 do
        text, normal = select(i, ...);
        string = string..", "..text;
    end

    return string;
end

function Armory:CopyTable(src, dest)
    dest = dest or {};
    for k, v in pairs(src) do
        if ( type(v) == "table" ) then
            if ( type(dest[k]) == "table" ) then
                table.wipe(dest[k]);
            else
                dest[k] = {};
            end
            self:CopyTable(v, dest[k]);
        elseif ( type(v) ~= "function" ) then
            dest[k] = v;
        end
    end
    return dest;
end

function Armory:FillTable(t, ...)
    table.wipe(t);

    for i = 1, select("#", ...) do
        t[i] = select(i, ...);
    end
end

function Armory:FillUnbrokenTable(t, ...)
    local value;
    table.wipe(t);

    for i = 1, select("#", ...) do
        value = select(i, ...);
        if ( value ~= nil ) then
            table.insert(t, value);
        end
    end
end

function Armory:String2Table(string, ignoreQuotes)
    if ( string ) then
        string = string:gsub("(|c.-|r)", function(s) return s:gsub(" ", "\001") end);
        if ( not ignoreQuotes ) then
            string = string:gsub('"(.-)"', function(s) return s:gsub(" ", "\001") end);
            string = string:gsub("'(.-)'", function(s) return s:gsub(" ", "\001") end);
        end
        local words = self:StringSplit(" ", strtrim(string));
        for i = #words, 1, -1 do
            if ( words[i] == "" ) then
                table.remove(words, i);
            else
                words[i] = words[i]:gsub("\001", " ");
            end
        end
        return words;
    end
end

function Armory:ToString(start, ...)
    local string = "";
    for i = start, select("#", ...) do
        if ( type(select(i, ...)) == "table" ) then
            for _, v in ipairs(select(i, ...)) do
                string = string.." "..self:ToString(1, v);
            end
        else
            string = string.." "..tostring(select(i, ...));
        end
    end
    return string;
end

function Armory:Text2String(text, r, g, b)
    return strjoin(ARMORY_TOOLTIP_CONTENT_SEPARATOR, self:Round(r, 2), self:Round(g, 2), self:Round(b, 2), text);
end

function Armory:String2Text(s)
    return strsplit(ARMORY_TOOLTIP_CONTENT_SEPARATOR, s);
end

function Armory:GetItemLinkInfo(link)
    local itemColor, itemString, itemName;
    if ( link ) then
        itemColor, itemString, itemName = link:match("(|c%x+)|Hitem:([-%d:]+)|h%[(.-)%]|h|r");
    end
    return itemName, itemString, itemColor;
end

function Armory:GetLinkInfo(link)
    local color, kind, id, name;
    if ( link ) then
        color, kind, id, name = link:match("^(|c%x+)|H(.-):(.-)|h%[(.-)%]|h|r");
    end
    return color, kind, id, name;
end

function Armory:GetItemId(link)
    local itemId, suffixId;
    if ( link ) then
        itemId, suffixId = link:match("item:([-%d]+):[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:([-%d]+)");
        if ( not itemId ) then
            itemId = link:match("item:([-%d]+)");
        end
    end
    return itemId, suffixId;
end

function Armory:GetUniqueItemId(link)
    local itemId, suffixId = self:GetItemId(link);
    if ( suffixId and suffixId ~= "0" and suffixId ~= "" ) then
        return itemId..":"..suffixId;
    end
    return itemId;
end

function Armory:GetQualifiedItemId(link)
    local itemId, suffixId = self:GetItemId(link);
    if ( suffixId and suffixId ~= "0" and suffixId ~= "" ) then
        return itemId.."::::::"..suffixId;
    end
    return itemId;
end

function Armory:GetLinkId(link)
    local idType, id;
    if ( link ) then
        idType, id = link:match("^.-(%l+):([-%d]+)");
    end
    return idType, id;
end

function Armory:GetLink(kind, id, name, color)
    if ( kind == "item" and type(color) == "number" ) then
        color = ITEM_QUALITY_COLORS[color].hex;
    end
    if ( kind == "talent" ) then
        color = "|cff4e96f7";
    elseif ( kind == "spell" ) then
        color = "|cff71d5ff";
    elseif ( kind == "trade" ) then
        color = "|cffffd000";
    elseif ( kind == "enchant" ) then
        color = "|cffffd000";
    elseif ( kind == "quest" ) then
        color = "|cffffff00";
    elseif ( not color ) then
        color = "|cffffd000";
    end
    return color.."|H"..kind..":"..id.."|h["..name.."]|h|r";
end

function Armory:GetInfoFromId(idType, id)
    local name, link, fontString, color;

    if ( not (idType and id) or strlen(id) == 0 ) then
        return;
    end

    local tooltip = self:AllocateTooltip();
    self:SetHyperlink(tooltip, idType..":"..id);
    name = tooltip:GetSpell();
    if ( name ) then
        link = _G.GetSpellLink(id);
    else
        name, link = self:GetItemFromTooltip(tooltip);
    end
    if ( not name ) then
        for i = 1, tooltip:NumLines() do
            fontString = _G[tooltip:GetName().."TextLeft"..i];
            if ( fontString and fontString:IsShown() ) then
                name = fontString:GetText();
                color = self:HexColor(fontString:GetTextColor());
                break;
            end
        end
    end
    self:ReleaseTooltip(tooltip);

    if ( (name or "") == "" ) then
        if ( idType == "item" ) then
            name, link = _G.GetItemInfo(id);
        elseif ( idType == "spell" ) then
            name = _G.GetSpellInfo(id);
        end
    end

    if ( name and not link ) then
        link = self:GetLink(idType, id, name, color);
    end

    return name, link;
end

function Armory:GetNameFromLink(link)
    if ( link ) then
        return link:match("|h%[(.-)%]|h|r$");
    end
end

function Armory:GetColorFromLink(link)
    if ( link ) then
        return link:match("^(|c%x+)|H");
    end
end

function Armory:GetTextFromLink(link)
    local text = "";
    if ( link ) then
        local tooltip = self:AllocateTooltip();
        self:SetHyperlink(tooltip, link);
        text = self:Tooltip2String(tooltip, true);
        self:ReleaseTooltip(tooltip);
    end
    return text;
end

function Armory:GetItemString(link)
    local _, itemString = self:GetItemLinkInfo(link);
    -- itemId:enchantId:jewelId1:jewelId2:jewelId3:jewelId4:suffixId:uniqueId:linkLevel...
    if ( itemString ) then
        local ids = self:StringSplit(":", itemString);
        if ( #ids > 8 ) then
            for i = #ids, 8, -1 do
                table.remove(ids);
            end
            itemString = table.concat(ids, ":");
        end
    end
    return itemString;
end

function Armory:GetReagentsFromTooltip(tooltip)
    local fontString, text, quantity, reagents;
    for i = 1, tooltip:NumLines() do
        fontString = _G[tooltip:GetName().."TextLeft"..i];
        if ( fontString and fontString:IsShown() ) then
            text = fontString:GetText();
            if ( text:match(SPELL_REAGENTS.."(.*)") ) then
                reagents = Armory:StringSplit(",", text:match(SPELL_REAGENTS.."(.*)"));
                for k, v in ipairs(reagents) do
                    v = strtrim(v);
                    if ( v:match("|c%x%x%x%x%x%x%x%x(.-)|r") ) then
                        reagents[k] = v:match("|c%x%x%x%x%x%x%x%x(.-)|r");
                    else
                        reagents[k] = v;
                    end
                    if ( reagents[k]:match("%d%)$") ) then
                        quantity = tonumber(reagents[k]:match("%((%d+)%)$"));
                        text = strtrim(reagents[k]:gsub("%(%d+%)$", ""));
                    else
                        quantity = 1;
                        text = reagents[k];
                    end
                    reagents[k] = {text, quantity};
                end
                break;
            end
        end
    end
    return reagents;
end

function Armory:GetQualityFromLink(link)
    return self:GetQualityFromColor(self:GetColorFromLink(link));
end

function Armory:GetQualityFromColor(color)
    if ( color ) then
        for i = 0, 7 do
            local _, _, _, hex = GetItemQualityColor(i);
            if color == "|c"..hex then
                return i
            end
        end
    end
    return -1
end

local function GetNotEquippableText(tooltip, name)
    local fontString = _G[tooltip:GetName().."Text"..name];
    if ( fontString ) then
        local r, g, b = fontString:GetTextColor();
        r = Armory:Round(r, 1);
        g = Armory:Round(g, 1);
        b = Armory:Round(b, 1);
        if ( r == RED_FONT_COLOR.r and g == RED_FONT_COLOR.g and b == RED_FONT_COLOR.b ) then
            return fontString:GetText() or "";
        end
    end
    return "";
end

function Armory:CanEquip(link)
    if ( link and IsEquippableItem(link) ) then
        local _, _, _, itemLevel, itemMinLevel, _, _, _, equipLoc = GetItemInfo(link);
        local slotName = ARMORY_SLOTINFO[equipLoc];
        if ( slotName ) then
            if ( itemMinLevel <= _G.UnitLevel("player") ) then
                local tooltip = self:AllocateTooltip();
                self:SetHyperlink(tooltip, link);
                local text;
                for i = 2, tooltip:NumLines() do
                    text = GetNotEquippableText(tooltip, "Left"..i);
                    if ( text ~= "" and not text:match(DURABILITY_TEMPLATE) ) then
                        self:ReleaseTooltip(tooltip);
                        return nil;
                    end
                    text = GetNotEquippableText(tooltip, "Right"..i);
                    if ( text ~= "" ) then
                        self:ReleaseTooltip(tooltip);
                        return nil;
                    end
                end
                self:ReleaseTooltip(tooltip);
                return ARMORY_SLOTID[slotName], itemLevel;
            end
        end
    end
end

function Armory:Lock(semaphore)
    self.locked[semaphore] = 1;
end

function Armory:Unlock(semaphore)
    self.locked[semaphore] = nil;
end

function Armory:IsLocked(semaphore)
    return self.locked[semaphore];
end

function Armory:Proper(text)
    return text:gsub("^%l", string.upper);
end

function Armory:HexColor(r, g, b, hexOnly)
    local color;
    if ( type(r) == "table" ) then
        if ( r.r ) then
            b = r.b;
            g = r.g;
            r = r.r;
        else
            b = r[3];
            g = r[2];
            r = r[1];
        end
    end
    color = "ff"..format("%02x%02x%02x", r*255, g*255, b*255);
    if ( hexOnly ) then
        return color;
    end
    return "|c"..color;
end

function Armory:ClassColor(unitClass, hex)
    -- !ClassColors support
    local classColors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS;
    local unitColor;

    if ( unitClass and classColors and classColors[strupper(unitClass)] ) then
        unitColor = classColors[strupper(unitClass)];
    else
        unitColor = HIGHLIGHT_FONT_COLOR;
    end

    if ( hex ) then
        local r, g, b = GetTableColor(unitColor);
        return self:HexColor(r, g, b, true);
    end
    return unitColor;
end


----------------------------------------------------------
-- Modules
----------------------------------------------------------

function Armory:PetsEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("Pets", value);
    end
    return self:GetModule("Pets");
end

function Armory:TalentsEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("Talents", value);
    end
    return self:GetModule("Talents");
end

function Armory:PVPEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("PVP", value);
    end
    return self:GetModule("PVP");
end

function Armory:ReputationEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("Reputation", value);
    end
    return self:GetModule("Reputation");
end

function Armory:SkillsEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("Skills", value);
    end
    return self:GetModule("Skills");
end

function Armory:RaidEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("Raid", value);
    end
    return self:GetModule("Raid");
end

function Armory:BuffsEnabled(value)
    if ( value ~= nil ) then
        self:SetModule("Buffs", value);
    end
    return self:GetModule("Buffs");
end

function Armory:HasInventory(value)
    if ( value ~= nil ) then
        self:SetModule("Inventory", value);
    end
    return self:GetModule("Inventory");
end

function Armory:HasQuestLog(value)
    if ( value ~= nil ) then
        self:SetModule("QuestLog", value);
    end
    return self:GetModule("QuestLog");
end

function Armory:HasSpellBook(value)
    if ( value ~= nil ) then
        self:SetModule("SpellBook", value);
    end
    return self:GetModule("SpellBook");
end

function Armory:HasTradeSkills(value)
    if ( value ~= nil ) then
        self:SetModule("Professions", value);
    end
    return self:GetModule("Professions");
end

function Armory:HasDataSharing(value)
    if ( value ~= nil ) then
        self:SetModule("DataSharing", value);
    end
    return self:GetModule("DataSharing");
end

function Armory:HasSocial(value)
    if ( value ~= nil ) then
        self:SetModule("Social", value);
    end
    return self:GetModule("Social");
end

function Armory:SetModule(module, enable)
    local dbEntry = self.modulesDbEntry;

    if ( dbEntry ) then
        dbEntry:SetValue("Disable"..module, not enable);
    end
end

function Armory:GetModule(module)
    local dbEntry = self.modulesDbEntry;
    local value;

    if ( dbEntry ) then
        value = dbEntry:GetValue("Disable"..module);
    end

    return not value;
end

----------------------------------------------------------
-- General Internals
----------------------------------------------------------

function Armory:SetGetCharacterValue(key, ...)
    self:SetCharacterValue(key, ...);
    if ( self.selectedDbBaseEntry ) then
        return self:GetCharacterValue(key);
    end
    return ...;
end

function Armory:SetCharacterValue(key, ...)
    if ( self.playerDbBaseEntry ) then
        self.playerDbBaseEntry:SetValue(key, ...);
    end
end

function Armory:GetCharacterValue(key, unit)
    if ( unit == "player" ) then
        if ( self.playerDbBaseEntry ) then
            return self.playerDbBaseEntry:GetValue(key);
        end
    elseif ( self.selectedDbBaseEntry ) then
        return self.selectedDbBaseEntry:GetValue(key);
    end
end

function Armory:ClearModuleData(container)
    local currentProfile = self:CurrentProfile();
    for _, profile in ipairs(self:Profiles()) do
        local dbEntry = self:SelectProfile(profile);

        dbEntry:SetValue(container, nil);
        self:SetClassValue(nil, container, nil);

        for _, pet in ipairs(self:GetPets()) do
            self:SelectPet(dbEntry, pet):SetValue(container, nil);
        end
    end
    self:SelectProfile(currentProfile);

    self:SetClassValue("pet", container, nil);
    self:SetSharedValue(container, nil);
end

function Armory:ClearPets()
    local currentProfile = self:CurrentProfile();
    for _, profile in ipairs(self:Profiles()) do
        local dbEntry = self:SelectProfile(profile);
        dbEntry:SetValue("Pet", nil);
        dbEntry:SetValue("Pets", nil);
    end
    self:SelectProfile(currentProfile);

    self:SetSharedValue("PET", nil);
    self:SetSharedValue("PETACTION", nil);
end

function Armory:GetPetName()
    local name = _G.UnitName("pet");
    local _, isHunterPet = _G.HasPetUI();
    if ( not isHunterPet ) then
        local family = _G.UnitCreatureFamily("pet");
        return family, name;
    end
    return name;
end

function Armory:SetGetPetValue(key, ...)
    --self:PrintDebug("SetGetPetValue", _G.HasPetUI(), _G.UnitName("pet"), self:GetCurrentPet(), "=>", key, ... );
    local dbEntry = self.playerDbBaseEntry;
    if ( dbEntry ) then
        if ( not self:PetsEnabled() ) then
            dbEntry:SetValue("Pets", nil);
        elseif ( _G.HasPetUI() and self:IsPersistentPet() ) then
            self:SetPetValue(self:GetPetName(), key, ...);
        end
        if ( self:PetExists(self:GetCurrentPet()) ) then
            return self:GetPetValue(self:GetCurrentPet(), key);
        end
    end
    return ...;
end

function Armory:SelectPet(baseEntry, index)
    local dbEntry = ArmoryDbEntry:new(baseEntry);
    dbEntry:SetPosition("Pets", index);
    return dbEntry;
end

function Armory:SetPetValue(index, key, ...)
    local dbEntry = self.playerDbBaseEntry;
    if ( dbEntry and index ~= UNKNOWN and not self:IsLocked("Pets") ) then
        self:SelectPet(dbEntry, index):SetValue(key, ...);
    end
end

function Armory:GetPetValue(index, key)
    local dbEntry = self.selectedDbBaseEntry;
    if ( dbEntry and dbEntry:Contains("Pets", index, key) ) then
        return self:SelectPet(dbEntry, index):GetValue(key);
    end
end

function Armory:DeletePet(pet, unit)
    local dbEntry = self.selectedDbBaseEntry;
    if ( unit == "player" ) then
        dbEntry = self.playerDbBaseEntry;
    end

    if ( pet and dbEntry and dbEntry:Contains("Pets", pet) ) then
        dbEntry:SetValue(2, "Pets", pet, nil);
    end
end

function Armory:SetTimePlayed(seconds)
    local dbEntry = self.playerDbBaseEntry;
    if ( seconds and dbEntry ) then
        dbEntry:SetValue("Played", seconds, time());
    end
end

function Armory:GetTimePlayed(unit)
    local dbEntry = self.selectedDbBaseEntry;
    local isPlayer = self:IsPlayerSelected();
    if ( unit and unit == "player" ) then
        dbEntry = self.playerDbBaseEntry;
        isPlayer = true;
    end

    if ( dbEntry ) then
        local seconds, timestamp = dbEntry:GetValue("Played");
        if ( seconds ) then
            if ( isPlayer ) then
                return seconds + (time() - timestamp), timestamp;
            else
                return seconds, timestamp;
            end
        end
    end
end

function Armory:GetXP()
    local unit = "player";
    local exhaustionStateID, exhaustionStateName, exhaustionStateMultiplier = self:GetRestState();
    local level = self:UnitLevel(unit);
    local restTimeLeft = 0;
    local xpText, tooltipText, chatText;
    if (  level ~= GetMaxPlayerLevel() ) then
        local currXP = self:UnitXP(unit);
        local nextXP = self:UnitXPMax(unit);
        local restXP, timestamp = self:GetXPExhaustion();
        local isResting = self:IsResting();
        local percentXP = 0;

        if ( (nextXP or 0) > 0 ) then
            percentXP = ceil((currXP * 100) / nextXP);
        end
        xpText = percentXP.."%";
        if ( timestamp and (restXP or 0) > 0 ) then
            local hours;
            if ( isResting ) then
                -- 5% of max XP is earned every 8 hours spent resting in an inn or capital city
                hours = 8;
            else
                -- 5% of max XP is earned every 32 hours spent resting outside
                hours = 32;
            end
            percentXP = (restXP * 100) / nextXP;
            restTimeLeft = ceil(((150 - percentXP) / 5) * (hours * 60 * 60) - (time() - timestamp));
            percentXP = floor(percentXP + ((time() - timestamp) / (hours * 60 * 60)) * 5);
            if ( percentXP >= 150 or restTimeLeft < 0 ) then
                percentXP = 150;
                restTimeLeft = 0;
            end

            chatText = format(ARMORY_XP_SUMMARY, level, xpText, nextXP - currXP, max(0, percentXP).."%");

            if ( percentXP > 0 ) then
                xpText = xpText.." R "..percentXP.."%";
            end

            if ( exhaustionStateID ) then
                tooltipText = format(EXHAUST_TOOLTIP1, exhaustionStateName, exhaustionStateMultiplier * 100);
                if ( not isResting and (exhaustionStateID == 4 or exhaustionStateID == 5) ) then
                    tooltipText = tooltipText..EXHAUST_TOOLTIP2;
                end
                if ( restTimeLeft > 0 ) then
                    tooltipText = tooltipText.."\n"..format(ARMORY_FULLY_RESTED, SecondsToTime(restTimeLeft, true));
                end
            end
        end
    end
    return xpText, tooltipText, chatText;
end

----------------------------------------------------------
-- General Hooks
----------------------------------------------------------

local Orig_PetAbandon = _G.PetAbandon;
function PetAbandon(...)
    local pet = UnitName("pet");
    Armory:Lock("Pets");
    Armory:DeletePet(pet, "player");
    Orig_PetAbandon(...);
    Armory:Unlock("Pets");
    Armory:PrintDebug("PetAbandon", pet);
end

local Orig_PetRename = _G.PetRename;
function PetRename(name, ...)
    local dbEntry = Armory.playerDbBaseEntry;
    local pet = UnitName("pet");
    Armory:Lock("Pets");
    if ( pet and dbEntry and dbEntry:Contains("Pets", pet) ) then
        local values = dbEntry:SelectContainer("Pets", name);
        Armory:CopyTable(dbEntry:GetValue("Pets", pet), values);
        dbEntry:SetValue(2, "Pets", pet, nil);
    end
    Orig_PetRename(name, ...);
    Armory:Unlock("Pets");
    Armory:PrintDebug("PetRename", pet, name);
end

----------------------------------------------------------
-- Find functions
----------------------------------------------------------

local searchTypes = {
    [0] = ARMORY_CMD_FIND_ALL,
    ARMORY_CMD_FIND_ITEM,
    ARMORY_CMD_FIND_QUEST,
    ARMORY_CMD_FIND_SPELL,
    ARMORY_CMD_FIND_SKILL,
    ARMORY_CMD_FIND_INVENTORY
};

local function GetSearchArgs(kind, name)
    if ( name ) then
        if ( kind == "item" ) then
            return ARMORY_CMD_FIND_ITEM, name;
        elseif ( kind == "spell" ) then
            return ARMORY_CMD_FIND_SPELL, name;
        elseif ( kind == "trade" or kind == "enchant" ) then
            return ARMORY_CMD_FIND_SKILL, name;
        elseif ( kind == "quest" ) then
            return ARMORY_CMD_FIND_QUEST, name;
        else
            return name;
        end
    end
end

do
    hooksecurefunc("ChatFrame_OnHyperlinkShow", function(self, link, text)
        if ( Armory:GetConfigAltClickSearch() and IsAltKeyDown() and link and text ) then
            local kind = link:match("^(.-):");
            local name = text:match("%[(.-)%]");
            local searchType, name = GetSearchArgs(kind, name);
            if ( searchType and name ) then
                Armory:Find(searchType, name);
            end
        end
    end);
end

function Armory:FindSearchType(searchType, loose)
    if ( type(searchType) == "number" ) then
        return searchTypes[searchType];
    end
    for index = 0, #searchTypes do
        local value = searchTypes[index];
        if ( strlower(searchType) == strlower(value) ) then
            return index;
        elseif ( loose and strlower(searchType) == strlower(value:sub(1, searchType:len())) ) then
            return index;
        end
    end
end

function Armory:ParseArgs(...)
    local arg1, arg2 = ...;
    if ( arg1 and arg1:find("|H") ) then
        local _, kind, _, name = self:GetLinkInfo(arg1);
        return GetSearchArgs(kind, name);
    elseif ( arg2 and arg2:find("|H") ) then
        return arg1, self:GetNameFromLink(arg2);
    end
    return ...;
end

local findResults = {};
function Armory:Find(...)
    local invalidCommand = false;
    local windowMode = ArmoryFindFrame:IsShown() or self:GetConfigSearchWindow();

    if ( select("#", ...) > 0 ) then
        local flags = {};
        local searchType = self:FindSearchType(select(1, ...), select("#", ...) > 1);
        local firstArg, where;
        if ( searchType ) then
            firstArg = 2;
            where = searchTypes[searchType];
        else
            firstArg = 1;
            where = self:GetConfigDefaultSearch();
        end
        flags[where] = 1;

        if ( select(firstArg, ...) ) then
            local currentProfile = self:CurrentProfile();
            local count = 0;

            table.wipe(findResults);

            if ( windowMode ) then
                ArmoryFindFrame_Initialize(where, select("#", ...) == firstArg, strtrim(self:ToString(1, select(firstArg, ...))));
                ShowUIPanel(ArmoryFindFrame);
            end

            if ( flags[ARMORY_CMD_FIND_INVENTORY] and self:HasInventory() ) then
                count = self:FindInventory(select(firstArg, ...));
            else
                for _, profile in ipairs(self:Profiles()) do
                    if ( self:GetConfigGlobalSearch() or self:IsConnectedRealm(profile.realm) ) then
                        self:SelectProfile(profile);
                        if ( (flags[ARMORY_CMD_FIND_ALL] or flags[ARMORY_CMD_FIND_ITEM]) and self:HasInventory() ) then
                            findResults[ARMORY_CMD_FIND_ITEM] = self:FindItems(select(firstArg, ...));
                        end
                        if ( (flags[ARMORY_CMD_FIND_ALL] or flags[ARMORY_CMD_FIND_QUEST]) and self:HasQuestLog() ) then
                            findResults[ARMORY_CMD_FIND_QUEST] = self:FindQuest(select(firstArg, ...));
                        end
                        if ( (flags[ARMORY_CMD_FIND_ALL] or flags[ARMORY_CMD_FIND_SPELL]) and self:HasSpellBook() ) then
                            findResults[ARMORY_CMD_FIND_SPELL] = self:FindSpells(select(firstArg, ...));
                        end
                        if ( (flags[ARMORY_CMD_FIND_ALL] or flags[ARMORY_CMD_FIND_SKILL]) and self:HasTradeSkills() ) then
                            findResults[ARMORY_CMD_FIND_SKILL] = self:FindSkill(nil, select(firstArg, ...));
                        end

                        for _, list in pairs(findResults) do
                            for _, line in ipairs(list) do
                                self:PrintSearchResult(self:GetQualifiedCharacterName(self:GetConfigGlobalSearch()), line);
                                count = count + 1;
                            end
                        end
                        table.wipe(findResults);
                     end
                end
                self:SelectProfile(currentProfile);
            end

            if ( windowMode ) then
                ArmoryFindFrame_Finalize();
            elseif ( count == 0 ) then
                self:Print(ARMORY_CMD_FIND_NOT_FOUND);
            else
                self:Print(format(ARMORY_CMD_FIND_FOUND, count));
            end
        elseif ( windowMode ) then
            ArmoryFindFrame_Initialize(where);
            ShowUIPanel(ArmoryFindFrame);
        else
            invalidCommand = true;
        end
    elseif ( windowMode ) then
         ArmoryFindFrame_Initialize();
         ShowUIPanel(ArmoryFindFrame);
    else
        invalidCommand = true;
    end

    return invalidCommand;
end

function Armory:FindTextParts(s, ...)
    local numParts = select("#", ...);
    if ( not s or numParts == 0 ) then
        return false;
    end

    s = strlower(s);
    for i = 1, numParts do
        if ( not string.find(s, strlower(select(i, ...)), 1, true) ) then
            return false;
        end
    end
    return true;
end

function Armory:FindItems(...)
    local list = {};

    self:FindInventoryItem(list, ...);

    if ( not self:GetConfigRestrictiveSearch() ) then
        self:FindQuestItem(list, ...);
        self:FindSkill(list, ...);
    end

    return list;
end

function Armory:FindSpells(...)
    local list = {};

    self:FindSpell(list, ...);

    if ( not self:GetConfigRestrictiveSearch() ) then
        self:FindQuestSpell(list, ...);
    end

    return list;
end

----------------------------------------------------------
-- Header State Methods
----------------------------------------------------------

local function GetHeaderLineStateKey(self)
    if ( not self.character ) then
        return self.playerRealm .. self.player;
    end
    return self.characterRealm .. self.character;
end

function Armory:GetHeaderLineState(container, header)
    local key = GetHeaderLineStateKey(self);
    if ( self.collapsedHeaders[key] and self.collapsedHeaders[key][container] ) then
        return self.collapsedHeaders[key][container][header];
    end
end

function Armory:SetHeaderLineState(container, header, isCollapsed)
    local key = GetHeaderLineStateKey(self);
    if ( not self.collapsedHeaders[key] ) then
        self.collapsedHeaders[key] = {};
    end
    if ( not self.collapsedHeaders[key][container] ) then
        self.collapsedHeaders[key][container] = {};
    end
    self.collapsedHeaders[key][container][header] = isCollapsed;
end

----------------------------------------------------------
-- Item String Caching
----------------------------------------------------------

function Armory:GetCachedItemString(name)
    local itemString;
    if ( self:GetConfigShowItemCount() and not self:GetConfigUseEncoding() ) then
        name = strtrim(name);
        if ( name ~= UNKNOWN ) then
            if ( ArmoryCache ) then
                itemString = ArmoryCache[name];
            end
            if ( not itemString ) then
                local _, link = _G.GetItemInfo(name);
                itemString = self:SetCachedItemString(name, link);
            end
        end
    end
    return itemString;
end

function Armory:SetCachedItemString(name, link)
    local itemString;
    if ( self:GetConfigShowItemCount() and not self:GetConfigUseEncoding() ) then
        name = strtrim(name);
        if ( name ~= UNKNOWN ) then
            if ( not ArmoryCache ) then
                ArmoryCache = {};
            end

            itemString = self:GetItemString(link);
            if ( itemString ) then
                ArmoryCache[name] = itemString;
                if ( ArmoryCache[UNKNOWN] ) then
                    ArmoryCache[UNKNOWN][name] = nil;
                end
            else
                if ( not ArmoryCache[UNKNOWN] ) then
                    ArmoryCache[UNKNOWN] = {};
                end
                ArmoryCache[UNKNOWN][name] = "";
            end
        end
    else
        ArmoryCache = nil;
    end
    return itemString;
end

function Armory:CheckUnknownCacheItems(name, itemString)
    if ( itemString and ArmoryCache and ArmoryCache[UNKNOWN] ) then
        name = strtrim(name);
        if ( ArmoryCache[UNKNOWN][name] ) then
            ArmoryCache[UNKNOWN][name] = nil;
            ArmoryCache[name] = itemString;
        end
    end
end


----------------------------------------------------------
-- Storage of shared data
----------------------------------------------------------

function Armory:SetSharedValue(...)
    local dbShared = self.sharedDbEntry;
    if ( dbShared ) then
        dbShared:SetValue(...);
    end
end

function Armory:GetSharedValue(...)
    local dbShared = self.sharedDbEntry;
    if ( dbShared ) then
        return dbShared:GetValue(...);
    end
end

function Armory:SelectSharedContainer(...)
    local dbShared = self.sharedDbEntry;
    return dbShared:SelectContainer(...);
end

function Armory:GetSharedNumValues(...)
    local dbShared = self.sharedDbEntry;
    return (dbShared and dbShared:GetNumValues(...)) or 0;
end

function Armory:SetClassValue(unit, key, ...)
    local className;
    if ( unit == nil ) then
        _, className = self:UnitClass("player");
    elseif ( strlower(unit) == "pet" ) then
        className = "PET";
    else
        _, className = _G.UnitClass("player");
    end
    if ( type(key) == "number" ) then
        self:SetSharedValue(key + 1, className, ...);
    else
        self:SetSharedValue(2, className, key, ...);
    end
end

local function GetClassName(unit)
    local className;
    if ( strlower(unit) == "pet" ) then
        className = "PET";
    else
        _, className = Armory:UnitClass("player");
    end
    return className;
end

function Armory:GetClassValue(unit, ...)
    local className = GetClassName(unit);
    return self:GetSharedValue(className, ...);
end

function Armory:GetClassNumValues(unit, ...)
    local className = GetClassName(unit);
    return self:GetSharedNumValues(className, ...);
end

function Armory:SelectClassContainer(unit, ...)
    local className = GetClassName(unit);
    return self:SelectSharedContainer(className, ...);
end
