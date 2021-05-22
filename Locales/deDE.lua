--[[

    Please do NOT edit this file but go to http://wow.curseforge.com/addons/armory/localization/ instead.
    
    The contents of this file will be generated automatically.
    
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Armory", "deDE");
if ( not L ) then 
    return;
end

-- Armory
L["ARMORY_ALTS"] = "Twinks"
L["ARMORY_BAGS"] = "Taschen"
L["ARMORY_BANK_CONTAINER_NAME"] = "Bank"
L["ARMORY_BONUS_PATTERN"] = "(.+) Bonus"
L["ARMORY_BUZZ_WORDS"] = [=[der
die
des
von]=]
L["ARMORY_BY_DATE"] = "nach Datum sortieren"
L["ARMORY_BY_GROUP"] = "nach Gruppe sortieren"
L["ARMORY_CAN_LEARN"] = "Lernbar von"
L["ARMORY_CHECK_CD_NONE"] = "Keine Cooldowns gefunden"
L["ARMORY_CHECK_MAIL_DISABLED"] = "Keine automatische Überprüfung auf bald ablaufende Gegenstände."
L["ARMORY_CHECK_MAIL_MESSAGE"] = "Der Posteingang von %1$s (%2$s) enthält Gegenstand '%3$s' der in %4$s ablaufen wird!"
L["ARMORY_CHECK_MAIL_NONE"] = "Es wurden keine Gegenstände im Posteingang gefunden, die bald ablaufen werden."
L["ARMORY_CHECK_MAIL_POPUP"] = [=[In Deinem Briefkasten befinden sich Gegenstände, die bald ablaufen werden. 
Gib "/ar check" ein, um weitere Details zu sehen.]=]
L["ARMORY_CMD_CHECK"] = "check"
L["ARMORY_CMD_CHECK_INVALID"] = "Trage eine Anzahl Tage ein, nachdem geprüft werden soll. Nichts für Standardeinstellung."
L["ARMORY_CMD_CHECK_MENUTEXT"] = "Prüfe auf bald ablaufende Gegenstände"
L["ARMORY_CMD_CHECK_TEXT"] = "Post auf bald ablaufene Gegenstände prüfen"
L["ARMORY_CMD_CHECKCD"] = "cooldown|cd"
L["ARMORY_CMD_CHECKCD_TEXT"] = "Prüft Cooldowns der Handwerksfähigkeiten"
L["ARMORY_CMD_CONFIG"] = "config"
L["ARMORY_CMD_CONFIG_TEXT"] = "Konfigurationspanel öffnen"
L["ARMORY_CMD_DELETE"] = "löschen"
L["ARMORY_CMD_DELETE_ALL"] = "alle"
L["ARMORY_CMD_DELETE_ALL_MSG"] = "Armorydatenbank wurde bereinigt."
L["ARMORY_CMD_DELETE_ALL_TEXT"] = "gesamte Datenbank löschen"
L["ARMORY_CMD_DELETE_CHAR"] = "char"
L["ARMORY_CMD_DELETE_CHAR_MSG"] = "Armory-Eintrag für '%1$s' auf Realm '%2$s' wurde gelöscht."
L["ARMORY_CMD_DELETE_CHAR_NOT_FOUND"] = "Armoryeintrag für '%1$s' auf Realm '%2$s' nicht gefunden!"
L["ARMORY_CMD_DELETE_CHAR_PARAMS_TEXT"] = "[Name][Realm]"
L["ARMORY_CMD_DELETE_CHAR_TEXT"] = "Lösche einen Charakter"
L["ARMORY_CMD_DELETE_REALM"] = "realm"
L["ARMORY_CMD_DELETE_REALM_MSG"] = "Armory Realm '%s' wurde bereinigt."
L["ARMORY_CMD_DELETE_REALM_NOT_FOUND"] = "Armory Realm '%s' nicht gefunden."
L["ARMORY_CMD_DELETE_REALM_PARAMS_TEXT"] = "[name]"
L["ARMORY_CMD_DELETE_REALM_TEXT"] = "lösche alle Realmdaten"
L["ARMORY_CMD_DOWNLOAD"] = "download"
L["ARMORY_CMD_DOWNLOAD_TEXT"] = "Downloade Rezepte von Gildenmitgliedern"
L["ARMORY_CMD_FIND"] = "suche"
L["ARMORY_CMD_FIND_ALL"] = "alle"
L["ARMORY_CMD_FIND_FOUND"] = "Anzahl der Treffer:%d"
L["ARMORY_CMD_FIND_GLYPH"] = "glyphe"
L["ARMORY_CMD_FIND_GLYPH_TOOLTIP"] = "Benutze '?' oder '%s', um Glyphen zu finden, die du noch nicht gelernt hast."
L["ARMORY_CMD_FIND_INVENTORY"] = "Inventar"
L["ARMORY_CMD_FIND_ITEM"] = "Gegenstand"
L["ARMORY_CMD_FIND_MENUTEXT"] = "Durchsuche Datenbank"
L["ARMORY_CMD_FIND_NOT_FOUND"] = "nicht gefunden"
L["ARMORY_CMD_FIND_PARAMS_TEXT"] = "[namepart]"
L["ARMORY_CMD_FIND_QUEST"] = "Quest"
L["ARMORY_CMD_FIND_QUEST_REWARD"] = "Questbelohnung"
L["ARMORY_CMD_FIND_SKILL"] = "Fähigkeit"
L["ARMORY_CMD_FIND_SPELL"] = "Zauber"
L["ARMORY_CMD_FIND_TEXT"] = "Suche Information in der lokalen Datenbank"
L["ARMORY_CMD_HELP"] = "hilfe"
L["ARMORY_CMD_HELP_TEXT"] = "Zeigt diese Armory-Hilfe"
L["ARMORY_CMD_LOOKUP"] = "lookup"
L["ARMORY_CMD_LOOKUP_MENUTEXT"] = "Hole Informationen"
L["ARMORY_CMD_LOOKUP_TEXT"] = "Hole Informationen von anderen Spielern"
L["ARMORY_CMD_RESET"] = "reset"
L["ARMORY_CMD_RESET_FRAME"] = "frames"
L["ARMORY_CMD_RESET_FRAME_MENUTEXT"] = "Bildschirmpositionen zurücksetzen"
L["ARMORY_CMD_RESET_FRAME_SUCCESS"] = "UI neu laden"
L["ARMORY_CMD_RESET_FRAME_TEXT"] = "Setze die Bildschirmposition auf die Werkseinstellung zurück"
L["ARMORY_CMD_RESET_SETTINGS"] = "Einstellungen"
L["ARMORY_CMD_RESET_SETTINGS_SUCCESS"] = "Alle Einstellungen wurden erfolgreich zurückgesetzt."
L["ARMORY_CMD_RESET_SETTINGS_TEXT"] = "setzt alle Einstellungen wieder auf die Standardeinstellungen"
L["ARMORY_CMD_SET_ALTCLICKSEARCH_MENUTEXT"] = "Für Alt-geklickte Links suchen"
L["ARMORY_CMD_SET_ALTCLICKSEARCH_TEXT"] = "Suche beginnen, wenn ein Chat-Link mit gedrückter Alt-Taste geklickt wird"
L["ARMORY_CMD_SET_ALTCLICKSEARCH_TOOLTIP"] = "Wenn aktiviert, wird die Suche ausgeführt, wenn die Alt-Taste gedrückt und gleichzeitig ein durchsuchbarer Link im Chat-Fenster geklickt wird."
L["ARMORY_CMD_SET_CHECKBUTTON_MENUTEXT"] = "Armory-Button ausblenden"
L["ARMORY_CMD_SET_CHECKBUTTON_TEXT"] = "Armory-Checkbox im Charakterfenster verstecken"
L["ARMORY_CMD_SET_CHECKBUTTON_TOOLTIP"] = "Aktiv: die Armorycheckbox in der unteren linken Ecke des Charakterfensters wird nicht angezeigt."
L["ARMORY_CMD_SET_CHECKCOOLDOWNS_MENUTEXT"] = "Prüfung auf freie Cooldowns"
L["ARMORY_CMD_SET_CHECKCOOLDOWNS_TEXT"] = "beim Login auf freie Cooldowns prüfen"
L["ARMORY_CMD_SET_CHECKCOOLDOWNS_TOOLTIP"] = [=[Aktiv: Prüfung beim Login auf freie Cooldowns
Inaktiv: keine Prüfung beim Login]=]
L["ARMORY_CMD_SET_COLLAPSE_MENUTEXT"] = "Charakterfenster einklappen"
L["ARMORY_CMD_SET_COLLAPSE_TEXT"] = "Charakterfenster einklappen"
L["ARMORY_CMD_SET_COLLAPSE_TOOLTIP"] = "Wenn aktiv, wird das Charakterfenster eingeklappt wenn die Armoryvariante verwendet wird."
L["ARMORY_CMD_SET_COOLDOWNEVENTS_MENUTEXT"] = "Berufs-Cooldowns einbeziehen"
L["ARMORY_CMD_SET_COOLDOWNEVENTS_TEXT"] = "Berufs-Cooldowns in Ereignisliste aufnehmen"
L["ARMORY_CMD_SET_COOLDOWNEVENTS_TOOLTIP"] = [=[Aktiv: Berufs-Cooldowns werden in der Armory Ereignisliste aufgeführt
Inaktiv: Berufs-Cooldowns werden nicht aufgeführt]=]
L["ARMORY_CMD_SET_COUNTALL_MENUTEXT"] = "Alle Realms in Zählungen einbeziehen"
L["ARMORY_CMD_SET_COUNTALL_TEXT"] = "Gegenstandsanzahl für alle Realms einbeziehen"
L["ARMORY_CMD_SET_COUNTALL_TOOLTIP"] = [=[Aktiv: Gesamtanzahl wird über alle Realms angezeigt
Inaktiv: Gesamtanzahl wird nur für diesen Realm angezeigt]=]
L["ARMORY_CMD_SET_COUNTPERSLOT_MENUTEXT"] = "Summe pro Tasche/Bankfach"
L["ARMORY_CMD_SET_COUNTPERSLOT_TEXT"] = "Anzahl der Gegenstände pro Tasche/Bankfach anzeigen"
L["ARMORY_CMD_SET_COUNTPERSLOT_TOOLTIP"] = [=[Aktiv: Anzahl der Gegenstände pro Tasche/Bankfach werden angezeigt, wobei '0' der Rucksack oder die eigentliche Bank darstellt.
]=]
L["ARMORY_CMD_SET_COUNTXFACTION_MENUTEXT"] = "Alle Fraktionen einbeziehen"
L["ARMORY_CMD_SET_COUNTXFACTION_TEXT"] = "alle Fraktionen bei der Zählung berücksichtigen"
L["ARMORY_CMD_SET_COUNTXFACTION_TOOLTIP"] = [=[Aktiv: Gesamtanzahl wird für alle Fraktionen angezeigt
Inaktiv: nur die eigene Fraktion wird berücksichtigt (Allianz oder Horde)]=]
L["ARMORY_CMD_SET_DEFAULTSEARCH_MENUTEXT"] = "Standardgruppe für Suche"
L["ARMORY_CMD_SET_DEFAULTSEARCH_TEXT"] = "legt die Standartgruppe fest"
L["ARMORY_CMD_SET_DEFAULTSEARCH_TOOLTIP"] = "Diese Gruppe wird durchsucht, wenn keine Gruppe gewählt wurde."
L["ARMORY_CMD_SET_ENABLED_MENUTEXT"] = "Charakter aktivieren"
L["ARMORY_CMD_SET_ENABLED_TEXT"] = "Diesen Charakter in Armory berücksichtigen"
L["ARMORY_CMD_SET_ENABLED_TOOLTIP"] = [=[Wenn aktiv, wird Armory Daten für den aktuellen Charakter sammeln.
Beachte, dass das Ändern dieser Option das UI neu laden wird.]=]
L["ARMORY_CMD_SET_EVENTLOCALTIME_MENUTEXT"] = "Lokale Zeit für Ereignisse verwenden"
L["ARMORY_CMD_SET_EVENTLOCALTIME_TEXT"] = "lokale Zeit in der Ereignisliste verwenden"
L["ARMORY_CMD_SET_EVENTLOCALTIME_TOOLTIP"] = [=[Aktiv: es wird die lokale Zeit verwendet
Inaktiv: es wird die Serverzeit verwendet]=]
L["ARMORY_CMD_SET_EVENTWARNINGS_MENUTEXT"] = "Ereignisbenachrichtigung"
L["ARMORY_CMD_SET_EVENTWARNINGS_TEXT"] = "Ereignisbenachrichtigung aktivieren"
L["ARMORY_CMD_SET_EVENTWARNINGS_TOOLTIP"] = [=[Aktiv: du wirst über alle bestätigten Ereignisse informiert
Inaktiv: du erhältst keine Informationen]=]
L["ARMORY_CMD_SET_EXPDAYS_INVALID"] = "%1$s muss zwischen 0 (keine Warnung) und %2$d Tagen liegen!"
L["ARMORY_CMD_SET_EXPDAYS_PARAMS_TEXT"] = "numdays"
L["ARMORY_CMD_SET_EXPDAYS_TEXT"] = "Warnverhalten für bald ablaufende Gegenstände"
L["ARMORY_CMD_SET_EXPDAYS_TOOLTIP"] = "Der Briefkasten wird auf Gegenstände geprüft, die nach x Tagen ablaufen (0 verhindert die Warnung)"
L["ARMORY_CMD_SET_EXTENDEDSEARCH_MENUTEXT"] = "Erweitere Suche"
L["ARMORY_CMD_SET_EXTENDEDSEARCH_TEXT"] = "Überprüfung von Tooltiptexten bei Suche"
L["ARMORY_CMD_SET_EXTENDEDSEARCH_TOOLTIP"] = [=[Aktiv: Auch Tooltiptexte prüfen
Inaktiv: Nur Gegenstandsnamen prüfen]=]
L["ARMORY_CMD_SET_EXTENDEDTRADE_MENUTEXT"] = "Berufsfilter aktivieren"
L["ARMORY_CMD_SET_EXTENDEDTRADE_TEXT"] = "aktiviere Unterklassen und Slotfilter"
L["ARMORY_CMD_SET_EXTENDEDTRADE_TOOLTIP"] = [=[Aktiv: Berufe können nach Unterklasse und Charakterplätze gefiltert werden.
Falls Probleme mit anderen Addons auftreten, deaktiviere diese Funktion, um eine einfache Liste zu erhalten, die keine Events auslöst (eine katalogisierte Version ist per Shiftklick auf den Linkbutton erhältlich).]=]
L["ARMORY_CMD_SET_GLOBALSEARCH_MENUTEXT"] = "Globale Suche"
L["ARMORY_CMD_SET_GLOBALSEARCH_TEXT"] = "Bei der Suche, alle Relams durchsuchen"
L["ARMORY_CMD_SET_GLOBALSEARCH_TOOLTIP"] = [=[Aktiv: Gesamte Datenbank durchsuchen
Inaktiv: Nur diesen Realm durchsuchen]=]
L["ARMORY_CMD_SET_HIDELOGON_MENUTEXT"] = "keine Warnungen beim Login"
L["ARMORY_CMD_SET_HIDELOGON_TEXT"] = "beim Login keine Warnungen anzeigen"
L["ARMORY_CMD_SET_HIDELOGON_TOOLTIP"] = [=[Aktiv: keine Warnungen beim Login
Inaktiv: Armory warnt schon beim Betreten der Welt, damit du nichts verpasst]=]
L["ARMORY_CMD_SET_HIDEMMTOOLBAR_MENUTEXT"] = "Minikartenbutton bei aktiver Toolbar verstecken"
L["ARMORY_CMD_SET_HIDEMMTOOLBAR_TEXT"] = "Verstecke den Minikartenbutton, wenn Titan oder FuBar gestartet ist."
L["ARMORY_CMD_SET_HIDEMMTOOLBAR_TOOLTIP"] = "Falls aktiviert, wird der Minikartenbutton automatisch versteckt, wenn Titan oder FuBar geladen ist."
L["ARMORY_CMD_SET_IGNOREALTS_MENUTEXT"] = "Post von eigenen Charakteren ignorieren"
L["ARMORY_CMD_SET_IGNOREALTS_TEXT"] = "Ignoriere Warnungen für Post von Twinks"
L["ARMORY_CMD_SET_IGNOREALTS_TOOLTIP"] = "Wird diese Funktion aktiviert, erscheint das Warnungsfenster nicht für ablaufende Post, die von einem eigenen Twink abgeschickt wurde (gilt nicht für zurückgesendete Post). Achtung - die Charaktere müssen dem Addon bereits bekannt sein."
L["ARMORY_CMD_SET_LASTVIEWED_MENUTEXT"] = "Auswahl merken"
L["ARMORY_CMD_SET_LASTVIEWED_TEXT"] = "Merke den zuletzt angezeigten Charakter."
L["ARMORY_CMD_SET_LASTVIEWED_TOOLTIP"] = "Wenn aktiviert, wird der zuletzt gezeigte Charakter auch nach Abmelden aus WOW gespeichert."
L["ARMORY_CMD_SET_LDBLABEL_MENUTEXT"] = "LDB-Anzeige aktivieren"
L["ARMORY_CMD_SET_LDBLABEL_TEXT"] = "aktiviere die LibDataBroker-Labelanzeige"
L["ARMORY_CMD_SET_LDBLABEL_TOOLTIP"] = [=[Aktiv: Ein Textlabel wird in LibDataBroker-Anzeigeaddons gezeigt
Inaktiv: unterdrückt diese Funktion]=]
L["ARMORY_CMD_SET_MAILCHECKCOUNT_MENUTEXT"] = "Überprüfung auf verbleibende Post"
L["ARMORY_CMD_SET_MAILCHECKCOUNT_TEXT"] = "auf verbleibende Post im Briefkasten überprüfen"
L["ARMORY_CMD_SET_MAILCHECKCOUNT_TOOLTIP"] = [=[Aktiv: zeigt eine Warnung, wenn nicht alle Post überprüft werden konnte, weil das Anzeigelimit überschritten wurde
Inaktiv: Keine Warnung bei übervollem Briefkasten]=]
L["ARMORY_CMD_SET_MAILCHECKVISIT_MENUTEXT"] = "Warnung vor ungelesener Post"
L["ARMORY_CMD_SET_MAILCHECKVISIT_TEXT"] = "letzten Briefkastenbesuch beim Überprüfen auf Post berücksichtigen"
L["ARMORY_CMD_SET_MAILCHECKVISIT_TOOLTIP"] = [=[Aktiv: Zeigt eine Warnung, wenn ein Posteingang nicht für 30-minus-x Tage überprüft wurde, um unbemerkte Post zu verhindern.
Inaktiv: Keine Warnung vor möglicher unbemerkter Post.]=]
L["ARMORY_CMD_SET_MAILEXCLUDEVISIT_MENUTEXT"] = "Charakter von der Postfachprüfung ausnehmen"
L["ARMORY_CMD_SET_MAILEXCLUDEVISIT_TEXT"] = "Postfachbesuche für diesen Charakter nicht prüfen"
L["ARMORY_CMD_SET_MAILEXCLUDEVISIT_TOOLTIP"] = [=[Aktiv: Postbewegung dieses Charakters wird nicht verfolgt
Inaktiv: Postbewegung wird verfolgt]=]
L["ARMORY_CMD_SET_MAILHIDECOUNT_MENUTEXT"] = "Verbleibende-Post-Warnung verstecken"
L["ARMORY_CMD_SET_MAILHIDECOUNT_TEXT"] = "keine Warnung angezeigen, wenn der Briefkasten geschlossen wird"
L["ARMORY_CMD_SET_MAILHIDECOUNT_TOOLTIP"] = [=[Aktiv: es wird keine Warnung auf verbleibende Post angezeigt, wenn du den Briefkasten schließt
Inaktiv: zeigt eine Warnung wenn noch Post im Posteingang ist wenn der Briefkasten geschlossen wird]=]
L["ARMORY_CMD_SET_MMB_ANGLE_TEXT"] = "Minikartenbutton-Winkel"
L["ARMORY_CMD_SET_MMB_GLOBAL_MENUTEXT"] = "Buttons für alle Charaktere gleich positionieren"
L["ARMORY_CMD_SET_MMB_GLOBAL_TEXT"] = "Gleiche Position für alle verwenden"
L["ARMORY_CMD_SET_MMB_GLOBAL_TOOLTIP"] = "Wenn aktiv, wird der Winkel und Radius für alle Charaktere gleich sein"
L["ARMORY_CMD_SET_MMB_RADIUS_TEXT"] = "Minikartenbutton-Abstand"
L["ARMORY_CMD_SET_NOVALUE"] = "momentane Einstellung: %s"
L["ARMORY_CMD_SET_NOVALUE_TEXT"] = "momentane Einstellung anzeigen"
L["ARMORY_CMD_SET_OFF"] = "aus"
L["ARMORY_CMD_SET_ON"] = "an"
L["ARMORY_CMD_SET_PAUSEINCOMBAT_MENUTEXT"] = "Während Kämpfen unterbrechen"
L["ARMORY_CMD_SET_PAUSEINCOMBAT_TEXT"] = "während des Kampfes nicht scannen"
L["ARMORY_CMD_SET_PAUSEINCOMBAT_TOOLTIP"] = [=[Aktiv: Armory pausiert Scanvorgänge während du im Kampf bist
Inaktiv: Armory scant auch im Kampf]=]
L["ARMORY_CMD_SET_PAUSEININSTANCE_MENUTEXT"] = "Scanverhalten in Instanzen"
L["ARMORY_CMD_SET_PAUSEININSTANCE_TEXT"] = "In Instanzen nicht scannen"
L["ARMORY_CMD_SET_PAUSEININSTANCE_TOOLTIP"] = [=[Aktiv: in Instanzen dürfen KEINE Daten gesammelt werden
Inaktiv: in Instanzen dürfen Daten gesammelt werden]=]
L["ARMORY_CMD_SET_PERCHARACTER_MENUTEXT"] = "Merke pro Charakter"
L["ARMORY_CMD_SET_PERCHARACTER_TEXT"] = "Einstellungen charakterbasisiert speichern"
L["ARMORY_CMD_SET_PERCHARACTER_TOOLTIP"] = [=[Aktiv: "alle Charaktere" und "letzter Charakter" werden individuell gespeichert
Inaktiv: "alle Charaktere" und "letzter Charakter" werden global gespeichert]=]
L["ARMORY_CMD_SET_RESTRICTIVESEARCH_MENUTEXT"] = "Eingeschränkte Gegenstandssuche"
L["ARMORY_CMD_SET_RESTRICTIVESEARCH_TEXT"] = "erreichbare Gegendstände bei der Gegenstandssuche ausschließen"
L["ARMORY_CMD_SET_RESTRICTIVESEARCH_TOOLTIP"] = "Wenn aktiviert, wird \"suche\" erreichbare Gegenstände wie Questbelohnungen oder herstellbare Gegenstände ignorieren"
L["ARMORY_CMD_SET_SCALEONMOUSEWHEEL_MENUTEXT"] = "Mausrad aktivieren"
L["ARMORY_CMD_SET_SCALEONMOUSEWHEEL_TEXT"] = "Mausrad aktivieren"
L["ARMORY_CMD_SET_SCALEONMOUSEWHEEL_TOOLTIP"] = "Wenn aktiv, kann mit Hilfe des Mausrads das Armory-Fenster skaliert werden, wenn sich der Mauszeiger über dem Fenster befindet."
L["ARMORY_CMD_SET_SCANONENTER_MENUTEXT"] = "Erzwinge Scan beim Login"
L["ARMORY_CMD_SET_SCANONENTER_TEXT"] = "Erzwingt einen Scan beim nächsten Login"
L["ARMORY_CMD_SET_SCANONENTER_TOOLTIP"] = "Aktiv: führt ein Update aller erreichbaren Charakterdaten beim nächsten Login durch (einmalig)."
L["ARMORY_CMD_SET_SEARCHALL_MENUTEXT"] = "\"Alle Charaktere\" merken"
L["ARMORY_CMD_SET_SEARCHALL_TEXT"] = "Inventareinstellungen für alle Charaktere speichern"
L["ARMORY_CMD_SET_SEARCHALL_TOOLTIP"] = [=[Aktiv: die Einstellungen für "Alle Charaktere" bleibt auch nach dem Logout erhalten
Inaktiv: die Einstellungen für "Alle Charakter" wird beim Logout verworfen]=]
L["ARMORY_CMD_SET_SHAREALL_MENUTEXT"] = "Teile Informationen über alle Charaktere"
L["ARMORY_CMD_SET_SHAREALL_TEXT"] = "Informationen über alle Charaktere weitergeben"
L["ARMORY_CMD_SET_SHAREALL_TOOLTIP"] = [=[Aktiv: Informationen über alle Charaktere teilen
Inaktiv: Nur Information über diesen Charakter teilen]=]
L["ARMORY_CMD_SET_SHAREALT_MENUTEXT"] = "Rufinformation teilen"
L["ARMORY_CMD_SET_SHAREALT_TEXT"] = "Rufinformation mit anderen Spielern teilen"
L["ARMORY_CMD_SET_SHAREALT_TOOLTIP"] = [=[Aktiv: Beziehung zwischen diesem und anderen eigenen Charakteren werden sichtbar
Inaktiv: Führt diesen Charakter als wäre er allein auf diesem Realm]=]
L["ARMORY_CMD_SET_SHARECHANNEL_MENUTEXT"] = "Tauschchannel verwenden"
L["ARMORY_CMD_SET_SHARECHANNEL_TEXT"] = "eigenen Channel verwenden"
L["ARMORY_CMD_SET_SHARECHANNEL_TOOLTIP"] = [=[Aktiv: Anfragen können an den angegebenen Chatchannel gesendet werden, um Daten mit einer ausgewählten Gruppe zu teilen
Inaktiv: deaktiviert dieses Feature]=]
L["ARMORY_CMD_SET_SHARECHARACTER_MENUTEXT"] = "Charakterinformationen teilen"
L["ARMORY_CMD_SET_SHARECHARACTER_TEXT"] = "Information über diesen Charakter teilen"
L["ARMORY_CMD_SET_SHARECHARACTER_TOOLTIP"] = [=[Aktiv: Andere Armorynutzer können deine Ausrüstung und Talente live überprüfen
Inaktiv: Daten über Ausrüstung und Talente werden nicht geteilt]=]
L["ARMORY_CMD_SET_SHAREGUILD_MENUTEXT"] = "Teilen von Gildenmitgliedern"
L["ARMORY_CMD_SET_SHAREGUILD_TEXT"] = "Information über Gildenmitglieder teilen"
L["ARMORY_CMD_SET_SHAREGUILD_TOOLTIP"] = [=[Aktiv: Informationen über Charaktere in der selben Gilde dürfen geteilt werden
Inaktiv: schützt Informationen über Gildenmitglieder]=]
L["ARMORY_CMD_SET_SHAREINCOMBAT_MENUTEXT"] = "Im Kampf teilen"
L["ARMORY_CMD_SET_SHAREINCOMBAT_TEXT"] = "Information werden geteilt, während du im Kampf bist"
L["ARMORY_CMD_SET_SHAREINCOMBAT_TOOLTIP"] = [=[Aktiv: Erlaubt teilen während du kämpfst
Inaktiv: Verbietet es, erhöht möglicherweise die Performance]=]
L["ARMORY_CMD_SET_SHAREININSTANCE_MENUTEXT"] = "In Instanzen teilen"
L["ARMORY_CMD_SET_SHAREININSTANCE_TEXT"] = "teilen, während du in einer Instanz bist"
L["ARMORY_CMD_SET_SHAREININSTANCE_TOOLTIP"] = [=[Aktiv: Erlaubt Information in einer Instanz zu teilen
Inaktiv: Verbietet es, erhöht möglicherweise die Performance]=]
L["ARMORY_CMD_SET_SHAREITEMS_MENUTEXT"] = "Teile Gegenstände"
L["ARMORY_CMD_SET_SHAREITEMS_TEXT"] = "Teile Inhalt meiner Taschen mit anderen"
L["ARMORY_CMD_SET_SHAREITEMS_TOOLTIP"] = "Aktiv: andere Armorynutzer, die denselben Benutzerchannel verwenden, können deine Taschen durchsuchen"
L["ARMORY_CMD_SET_SHAREQUESTS_MENUTEXT"] = "Questdaten teilen"
L["ARMORY_CMD_SET_SHAREQUESTS_TEXT"] = "Quests teilen"
L["ARMORY_CMD_SET_SHAREQUESTS_TOOLTIP"] = [=[Aktiv: erlaubt anderen Armorynutzern deine Quests zu durchsuchen
Inaktiv: andere Armorynutzer dürfen es nicht]=]
L["ARMORY_CMD_SET_SHARESKILLS_MENUTEXT"] = "Berufsinformationen teilen"
L["ARMORY_CMD_SET_SHARESKILLS_TEXT"] = "Information über deine Rezepte teilen"
L["ARMORY_CMD_SET_SHARESKILLS_TOOLTIP"] = [=[Aktiv: erlaubt anderen Armorynutzern deine Berufe und Rezepte zu durchsuchen
Inaktiv: andere Armorynutzer dürfen es nicht]=]
L["ARMORY_CMD_SET_SHOW2NDSKILLRANK_MENUTEXT"] = "Zweitberufe mit einbeziehen"
L["ARMORY_CMD_SET_SHOW2NDSKILLRANK_TEXT"] = "Beziehe Zweitberufe mit ein"
L["ARMORY_CMD_SET_SHOW2NDSKILLRANK_TOOLTIP"] = [=[Aktiv: Berufsränge der Sekundärberufe werden bei den Tooltips angezeigt
Inaktiv: Nur die Berufsränge der Primärberufe werden angezeigt]=]
L["ARMORY_CMD_SET_SHOWACHIEVEMENTS_MENUTEXT"] = "Erfolge und Heldentaten in Link anzeigen"
L["ARMORY_CMD_SET_SHOWACHIEVEMENTS_TEXT"] = "Charaktere zu verlinkten Erfolgen anzeigen"
L["ARMORY_CMD_SET_SHOWACHIEVEMENTS_TOOLTIP"] = [=[Aktiv: Zeigt Charakter die diesen Erfolg schon haben oder ihn gerade bearbeiten an
Inaktiv: Zeigt den normalen Blizard-Tooltip]=]
L["ARMORY_CMD_SET_SHOWALTEQUIP_MENUTEXT"] = "alternative Ausrüstung anzeigen"
L["ARMORY_CMD_SET_SHOWALTEQUIP_TEXT"] = "ermöglicht es passende Ausrüstung aus dem Inventar anzuzeigen"
L["ARMORY_CMD_SET_SHOWALTEQUIP_TOOLTIP"] = [=[Aktiv: zeigt passende Ausrüstung
Inaktiv: zeigt Standardtooltip]=]
L["ARMORY_CMD_SET_SHOWCANLEARN_MENUTEXT"] = "\"Erlernbar von\" im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWCANLEARN_TEXT"] = "\"Erlernbar von\" im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWCANLEARN_TOOLTIP"] = [=[Aktiv: Zeigt an, welche Charaktere ein Rezept erlernen können (alle Voraussetzungen sind erfüllt)
Inaktiv: Keine Anzeige, ob Rezept erlernt werden kann]=]
L["ARMORY_CMD_SET_SHOWCOUNTTOTAL_MENUTEXT"] = "Gesamtanzahl anzeigen"
L["ARMORY_CMD_SET_SHOWCOUNTTOTAL_TEXT"] = "Gesamtanzahl anzeigen"
L["ARMORY_CMD_SET_SHOWCOUNTTOTAL_TOOLTIP"] = [=[Aktiv: Zeige zusätzlich Gesamtanzahl
Inaktiv: keine zusätzlich Anzeige]=]
L["ARMORY_CMD_SET_SHOWCRAFTERS_MENUTEXT"] = "Hersteller im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWCRAFTERS_TEXT"] = "Hersteller im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWCRAFTERS_TOOLTIP"] = [=[Aktiv: zeigt welche Charaktere diesen Gegenstand herstellen können
Inaktiv: keine Information zur Herstellung]=]
L["ARMORY_CMD_SET_SHOWEQCTOOLTIPS_MENUTEXT"] = "Vergleichende Tooltips"
L["ARMORY_CMD_SET_SHOWEQCTOOLTIPS_TEXT"] = "vergleichene Tooltips anzeigen"
L["ARMORY_CMD_SET_SHOWEQCTOOLTIPS_TOOLTIP"] = [=[Aktiv: Vergleichstooltips werden durch Drücken der Alt-Taste angezeigt, während ein ausrüstbarer Gegenstand angezeigt wird
Inaktiv: Vergleichstooltips werden nicht angezeigt]=]
L["ARMORY_CMD_SET_SHOWGEARSETS_MENUTEXT"] = "Setnamen im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWGEARSETS_TEXT"] = "Setnamen im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWGEARSETS_TOOLTIP"] = [=[Aktiv: bei Setgegenständen wird der Setname im Tooltip angezeigt
Inaktiv: es werden keine Setnamen im Tooltip angezeigt]=]
L["ARMORY_CMD_SET_SHOWGEMS_MENUTEXT"] = "Juwelendetails anzeigen"
L["ARMORY_CMD_SET_SHOWGEMS_TEXT"] = "Details über gesockelte Juwelen angezeigen"
L["ARMORY_CMD_SET_SHOWGEMS_TOOLTIP"] = [=[Aktiv: Farbe des Sockels und Name des Juwels werden im Tooltip angezeigt
inaktiv: keine Sockel- und Juweleninformationen im Tooltip]=]
L["ARMORY_CMD_SET_SHOWHASSKILL_MENUTEXT"] = "\"Erreichbar von\" im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWHASSKILL_TEXT"] = "\"Erreichbar von\" im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWHASSKILL_TOOLTIP"] = [=[Aktiv: Zeigt an, welche Charaktere ein Rezept durch Berufsaufstieg und/oder besseren Ruf erlernen könnten
Inaktiv: Keine Anzeige potenzieller Hersteller]=]
L["ARMORY_CMD_SET_SHOWITEMCOUNT_MENUTEXT"] = "Gegenstandsanzahl im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWITEMCOUNT_TEXT"] = "Gesamtanzahl in Tooltips anzeigen"
L["ARMORY_CMD_SET_SHOWITEMCOUNT_TOOLTIP"] = [=[Aktiv: Gegenstandsanzahl wird für jeden Charkter zusätzlich seperat angezeigt
Inaktiv: Zeigt nur die Summe über alle Charaktere]=]
L["ARMORY_CMD_SET_SHOWKNOWNBY_MENUTEXT"] = "\"Bekannt durch\" im Tooltip anzeigen"
L["ARMORY_CMD_SET_SHOWKNOWNBY_TEXT"] = " \"Bekannt durch\" in Tooltips anzeigen"
L["ARMORY_CMD_SET_SHOWKNOWNBY_TOOLTIP"] = "Aktiv: zeigt an welche Charaktere ein Rezept oder eine Gyphe bereits kennen"
L["ARMORY_CMD_SET_SHOWMINIMAP_MENUTEXT"] = "Minikartenbutton anzeigen"
L["ARMORY_CMD_SET_SHOWMINIMAP_TEXT"] = "Minikartenbutton generell anzeigen"
L["ARMORY_CMD_SET_SHOWMINIMAP_TOOLTIP"] = [=[Aktiv: Zeige Minikartenbutton
Inaktiv: Verberge Minikartenbutton]=]
L["ARMORY_CMD_SET_SHOWMMGLOBAL_MENUTEXT"] = "Minikartenbutton für alle"
L["ARMORY_CMD_SET_SHOWMMGLOBAL_TEXT"] = "Minikartenbutton für alle Charaktere anzeigen"
L["ARMORY_CMD_SET_SHOWMMGLOBAL_TOOLTIP"] = [=[Aktiv: Minikartenbutton wird für alle Charaktere angezeigt
Inaktiv: Minikartenbutton kann für jeden Charakter selbst festgelegt werden]=]
L["ARMORY_CMD_SET_SHOWQUESTALTS_MENUTEXT"] = "Verhalten bei verlinkten Quests"
L["ARMORY_CMD_SET_SHOWQUESTALTS_TEXT"] = "Charaktere in verlinkten Quests anzeigen"
L["ARMORY_CMD_SET_SHOWQUESTALTS_TOOLTIP"] = [=[Aktiv: zeigt Charktere welche sich ebenfalls auf verlinkter Quest befinden
Inaktiv: zeigt normalen Tooltip]=]
L["ARMORY_CMD_SET_SHOWSHAREMSG_MENUTEXT"] = "Teilen verfolgen"
L["ARMORY_CMD_SET_SHOWSHAREMSG_TEXT"] = "verfolgen, welche Daten geteilt werden"
L["ARMORY_CMD_SET_SHOWSHAREMSG_TOOLTIP"] = [=[Aktiv: Zeigt eine Meldung wenn Daten geteilt werden
Inaktiv: Zeigt keine Meldung wenn Daten geteilt werden]=]
L["ARMORY_CMD_SET_SHOWSKILLRANK_MENUTEXT"] = "Berufsränge in Tooltips anzeigen"
L["ARMORY_CMD_SET_SHOWSKILLRANK_TEXT"] = "Zeige Berufsränge in Tooltips"
L["ARMORY_CMD_SET_SHOWSKILLRANK_TOOLTIP"] = "Aktiv: Berufsränge werden bei den Tooltips der Berufsbuttons angezeigt"
L["ARMORY_CMD_SET_SHOWSUMMARY_MENUTEXT"] = "Charakterübersicht"
L["ARMORY_CMD_SET_SHOWSUMMARY_TEXT"] = "Charakterübersicht anzeigen"
L["ARMORY_CMD_SET_SHOWSUMMARY_TOOLTIP"] = [=[Aktiv: Übersicht wird bei Mausover angezeigt
Inaktiv: keine Anzeige der Übersicht]=]
L["ARMORY_CMD_SET_SHOWUNEQUIP_MENUTEXT"] = "Nicht anlegbare Ausrüstung anzeigen"
L["ARMORY_CMD_SET_SHOWUNEQUIP_TEXT"] = "nicht anlegbare Ausrüstung anzeigen"
L["ARMORY_CMD_SET_SHOWUNEQUIP_TOOLTIP"] = [=[Aktiv: Ignoriert, ob ein Ausrüstungsgegenstand getragen werden kann
Inaktiv: normales Verhalten]=]
L["ARMORY_CMD_SET_SUCCESS"] = "%1$s auf %2$s gesetzt"
L["ARMORY_CMD_SET_SUMMARYDELAY_TEXT"] = "Übersicht Verzögerung"
L["ARMORY_CMD_SET_SUMMARYDELAY_TOOLTIP"] = "Lege die Verzögerung fest, mit der die Übersicht angezeigt werden soll."
L["ARMORY_CMD_SET_SYSTEMWARNINGS_MENUTEXT"] = "Systemwarnungen aktivieren"
L["ARMORY_CMD_SET_SYSTEMWARNINGS_TEXT"] = "Nachrichten aus Systemwarnungen aktivieren"
L["ARMORY_CMD_SET_SYSTEMWARNINGS_TOOLTIP"] = [=[Wenn aktiv, werden Warnnachrichten angezeigt, wenn etwas schief läuft (z.B. wenn der Server keine Daten zurückgibt).

Es wird dringend empfohlen, diese Einstellung zu aktivieren. Es ist grundsätzlich besser, die Ursache für eine solche Meldung herauszufinden und das Problem zu lösen. So kann zum Beispiel das Deaktivieren der Unterklassen- und Bankfach-Filter als Workaround für einige Meldung im Zusammenhang mit der Berufsaktualisierung verwendet werden. Im Gegenzug gehen dadurch aber einige Funktionalitäten verloren.]=]
L["ARMORY_CMD_SET_USECLASSCOLORS_MENUTEXT"] = "Klassenfarben verwenden"
L["ARMORY_CMD_SET_USECLASSCOLORS_TEXT"] = "Klassenfarben für Charakternamen verwenden"
L["ARMORY_CMD_SET_USECLASSCOLORS_TOOLTIP"] = "Wenn aktiviert, werden Charakternamen in Klassenfarben dargestellt."
L["ARMORY_CMD_SET_USEENCODING_MENUTEXT"] = "Speicher dem Prozessor vorziehen"
L["ARMORY_CMD_SET_USEENCODING_TEXT"] = "Speicherausnutzung gegenüber Arbeitsgeschwindigkeit bevorzugen"
L["ARMORY_CMD_SET_USEENCODING_TOOLTIP"] = [=[Aktiv: Daten werden binärcodiert gespeichert (braucht weniger Speicher jedoch mehr Rechenleistung; Standard)
Inaktiv: Daten werden normal gespeichert (braucht mehr Speicher aber weniger Rechleistung)]=]
L["ARMORY_CMD_SET_USEFACTIONFILTER_MENUTEXT"] = "Realm- & Fraktionsfilter"
L["ARMORY_CMD_SET_USEFACTIONFILTER_TEXT"] = "aktiviere Realm- und Fraktionsfilter"
L["ARMORY_CMD_SET_USEFACTIONFILTER_TOOLTIP"] = [=[Wenn aktiviert, werden nur Charaktere auf demselben Realm und mit derselben Fraktion angezeigt. Dies beeinflusst auch Tooltips.
Wichtig, für Gegenstandzähler existieren seperate Realm- und Fraktionseinstellungen.]=]
L["ARMORY_CMD_SET_USEINPROGRESSCOLOR_MENUTEXT"] = "andere Einfärbung für \"in Bearbeitung\""
L["ARMORY_CMD_SET_USEINPROGRESSCOLOR_TEXT"] = "andere Einfärbung für \"in Bearbeitung\""
L["ARMORY_CMD_SET_USEINPROGRESSCOLOR_TOOLTIP"] = [=[Aktiv: für Erfolge in Bearbeitung von einem Charakter wird eine andere Farbe verwendet als für Abgeschloßene
Inaktiv: keine Farbunterscheidung für nicht abgeschloßene Erfolge]=]
L["ARMORY_CMD_SET_USEMAZIEL_MENUTEXT"] = "Verwende zwei Werte-Panels"
L["ARMORY_CMD_SET_USEMAZIEL_TEXT"] = "Talente und Berufe verstecken"
L["ARMORY_CMD_SET_USEMAZIEL_TOOLTIP"] = [=[Aktiv: versteckt Talente und Berufe zugunsten eines zusätzlichen Werte-Panels
Inaktiv: normale Anzeige]=]
L["ARMORY_CMD_SET_USEOVERLAY_MENUTEXT"] = "Charaktermodell-Overlay aktivieren"
L["ARMORY_CMD_SET_USEOVERLAY_TEXT"] = "Charaktermodel durch Armoryanzeige ersetzen"
L["ARMORY_CMD_SET_USEOVERLAY_TOOLTIP"] = [=[Aktiv: das Armory-Layout ersetzt das Charaktermodell wenn das Charakterfenster verkleinert wurde.
Inaktiv: das Standard-Layout wird verwendet
]=]
L["ARMORY_CMD_SET_WARNINGSOUND_MENUTEXT"] = "Warn-Sound"
L["ARMORY_CMD_SET_WARNINGSOUND_TEXT"] = "Warnnachrichtensound"
L["ARMORY_CMD_SET_WARNINGSOUND_TOOLTIP"] = "Wähle einen Sound, der abgespielt wird, wenn eine automatische Warnung oder Fehlernachricht im Chatfenster angezeigt wird."
L["ARMORY_CMD_SET_WEEKLYRESET_MENUTEXT"] = "Wöchentlicher Reset"
L["ARMORY_CMD_SET_WEEKLYRESET_TEXT"] = "Wöchentlicher Server-Reset"
L["ARMORY_CMD_SET_WEEKLYRESET_TOOLTIP"] = "Tag auswählen, an dem der wöchentliche Server-Reset durchgeführt wird (Dienstags für US- und Mittwochs für EU-Server)."
L["ARMORY_CMD_SET_WINDOWSEARCH_MENUTEXT"] = "Suchergebnisse im Fenster anzeigen"
L["ARMORY_CMD_SET_WINDOWSEARCH_TEXT"] = "Suchergebnisse in einem Extrafenster anzeigen"
L["ARMORY_CMD_SET_WINDOWSEARCH_TOOLTIP"] = [=[Aktiv: Suchergebnisse werden in einem Extrafenster angezeigt
Inaktiv: Suchergebnisse werden im Chatfenster angezeigt]=]
L["ARMORY_CMD_TOGGLE"] = "Armory ein- oder ausschalten"
L["ARMORY_CMD_USAGE"] = "Hilfe:"
L["ARMORY_COOLDOWN_AVAILABLE"] = "Der Cooldown auf \"%1$s\" von %2$s ist wieder verfügbar (%3$s)."
L["ARMORY_COOLDOWN_WARNING"] = "%s in %d |4minute:minutes;"
L["ARMORY_CRAFTABLE_BY"] = "Herstellbar von"
L["ARMORY_DB_INCOMPATIBLE"] = [=[Die Datenbank ist nicht mehr mit dieser Version von Armory kompatibel und wird gelöscht.
Du musst dich mit allen Charakteren einlogen um die Datenbank zu erneuern.
Hinweis: Vergiss nicht, auch alle Berufe einzuscannen!]=]
L["ARMORY_DELETE_UNIT"] = "Willst du %s aus der Datenbank löschen?"
L["ARMORY_DELETE_UNIT_HINT"] = "Rechtsklick, um zu löschen."
L["ARMORY_EQUIPMENT"] = "Ausrüstung"
L["ARMORY_EQUIPPED"] = "Ausgerüstet"
L["ARMORY_ERROR"] = "FEHLER"
L["ARMORY_EVENT_WARNING"] = "%s startet in %d |4minute:minutes;"
L["ARMORY_EXPIRATION_LABEL"] = "Ablaufende Post"
L["ARMORY_EXPIRATION_SUBTEXT"] = "Diese Optionen erlauben es dir, das Verhalten des Postablaufchecks zu verändern."
L["ARMORY_EXPIRATION_TITLE"] = "Postablauf"
L["ARMORY_EXTENDED"] = "Erweiterte Suche"
L["ARMORY_FILTER_ALL"] = "Alle auswählen"
L["ARMORY_FILTER_CLEAR"] = "Auswahl aufheben"
L["ARMORY_FILTER_DISABLE"] = "Filter ausschalten"
L["ARMORY_FILTER_ENABLE"] = "Filter einschalten"
L["ARMORY_FILTER_LABEL"] = "Filter: %s"
L["ARMORY_FILTER_TOOLTIP"] = "Klicken, um globalen Gegenstandsfilter auszuwählen."
L["ARMORY_FIND_BUTTON"] = "Suche"
L["ARMORY_FIND_LABEL"] = "Sucheinstellungen"
L["ARMORY_FIND_SUBTEXT"] = "Diese Optionen erlauben es dir, das Verhalten der Suche zu verändern"
L["ARMORY_FIND_TITLE"] = "Datenbank durchsuchen"
L["ARMORY_FONT_COLOR"] = "Schriftfarbe"
L["ARMORY_FULLY_RESTED"] = "Vollständig ausgeruht in: %s"
L["ARMORY_GLOBAL"] = "Globale Suche"
L["ARMORY_GLYPH"] = "Glyphe"
L["ARMORY_IGNORE_REASON_COMBAT"] = "Teilen ist im Kampf deaktiviert."
L["ARMORY_IGNORE_REASON_INSTANCE"] = "Teilen ist in Instanzen deaktiviert."
L["ARMORY_IGNORE_REASON_SHARING"] = "Alle Funktionen zum Teilen wurden deaktiviert."
L["ARMORY_IGNORE_REASON_VERSION"] = "Protokollversion wird nicht unterstützt."
L["ARMORY_INFO"] = "INFORMATION"
L["ARMORY_INVALID_ITEM"] = "Ungültiger Gegenstand. Bitte nochmal scannen."
L["ARMORY_INVENTORY_BAGLAYOUT"] = "Taschenlayout"
L["ARMORY_INVENTORY_BAGLAYOUT_TOOLTIP"] = "Zeigt Taschen entsprechend ihrem aktuellem Layout."
L["ARMORY_INVENTORY_ICONVIEW"] = "Iconansicht"
L["ARMORY_INVENTORY_ICONVIEW_TOOLTIP"] = "Normale Ansicht, wie sie auch von Blizzard verwendet wird."
L["ARMORY_INVENTORY_LISTVIEW"] = "Listenansicht"
L["ARMORY_INVENTORY_LISTVIEW_TOOLTIP"] = "Optimierte Ansicht als Gegenstandliste mit Name"
L["ARMORY_INVENTORY_SEARCH_ALL"] = "Alle Charaktere"
L["ARMORY_INVENTORY_SEARCH_ALL_TOOLTIP"] = "Wählt alle Inventargegenstände aller Charaktere in der Datenbank."
L["ARMORY_INVENTORY_SEARCH_TEXT_TOOLTIP"] = [=[Filterkriterium festlegen.

Hinweis: Du kannst Gegenstände nach ihrer Qualität filtern durch Eingabe von "=" gefolgt durch %s, %s, %s, %s, %s, %s, %s, %s oder ihrem numerischem Wert 0-7 (z.B.: "=4" für epische Gegenstände).]=]
L["ARMORY_KNOWN_BY"] = "Bereits bekannt von"
L["ARMORY_LINK_HINT"] = "Shift-Klicken, um zu verlinken"
L["ARMORY_LINK_TRADESKILL_TOOLTIP"] = "Shift-Klicken öffnet deinen Beruf."
L["ARMORY_LOOKUP_BUTTON"] = "Inspizieren"
L["ARMORY_LOOKUP_CHARACTER"] = "Charakter inspizieren"
L["ARMORY_LOOKUP_CHARACTER_SEARCH_TOOLTIP"] = [=[Filterkriterium eingeben.

Merke, dass dies auch der Name eines Twinks jemandes sein kann.]=]
L["ARMORY_LOOKUP_DETAIL"] = "Klicken, um Details anzuzeigen."
L["ARMORY_LOOKUP_DISABLED"] = "Die Funktion zum Teilen ist deaktiviert."
L["ARMORY_LOOKUP_IGNORED"] = "Anfrage abgelehnt (Begründung: %s)"
L["ARMORY_LOOKUP_ITEM"] = "Suche Gegenstand"
L["ARMORY_LOOKUP_NODETAIL"] = "Keine Details verfügbar"
L["ARMORY_LOOKUP_NOT_CACHED"] = "Gegenstandsinformationen fehlen; bitte erneut versuchen"
L["ARMORY_LOOKUP_PLAYER_HINT"] = [=[Shift-Klick, um Spielerinfo aufzurufen
Rechtsklick, um zu flüstern]=]
L["ARMORY_LOOKUP_QUEST"] = "Quests inspizieren"
L["ARMORY_LOOKUP_QUEST_AREA"] = "Questgebiet"
L["ARMORY_LOOKUP_QUEST_NAME"] = "Questname"
L["ARMORY_LOOKUP_QUEST_SEARCH_TOOLTIP"] = [=[Filterkriterium eingeben.

Merke, dass du auch nach bestimmten Questgebieten fragen kannst, wenn du im Dropdownmenu die passende Option auswählst.]=]
L["ARMORY_LOOKUP_REALM_ALIAS"] = "Inspiziert"
L["ARMORY_LOOKUP_REQUEST_DETAIL"] = "Angefragte Daten: %s"
L["ARMORY_LOOKUP_REQUEST_RECEIVED"] = "Anfrage zum Teilen von %s empfangen"
L["ARMORY_LOOKUP_REQUEST_SENT"] = "Anfrage an %s versendet"
L["ARMORY_LOOKUP_RESPONSE_RECEIVED"] = "Angefragte Daten von %s empfangen"
L["ARMORY_LOOKUP_RESPONSE_SENT"] = "Antwort an %s gesendet"
L["ARMORY_LOOKUP_SEARCH_EXACT"] = "Genaue Übereinstimmung"
L["ARMORY_LOOKUP_SKILL"] = "Rezepte inspizieren"
L["ARMORY_LOOKUP_SKILL_SEARCH_TOOLTIP"] = [=[Gib dein Fiterkriterium ein.

Zurückgegebene Charakternamen können angeklickt werden, um ihr Berufsfenster einzusehen.
Du kannst ein Sternchen (*) benutzen, um eine komplette Rezeptliste anzufordern.]=]
L["ARMORY_MAIL_COUNT_WARNING1"] = "Dein Posteingang enthält noch immer %d |4mail:mails; welche nicht gescannt werden konnten. Bitte leere deinen Posteingang."
L["ARMORY_MAIL_COUNT_WARNING2"] = "%1$s (%2$s) hat %d |4mail:mails; welche nicht überprüft werden konnten."
L["ARMORY_MAIL_COUNT_WARNING3"] = "Unbekannter Absender entdeckt! Bitte öffne deinen Briefkasten erneut, um einen erneuten Scan zu erzwingen."
L["ARMORY_MAIL_ITEM_COUNT"] = "Anzahl an Gegenständen:"
L["ARMORY_MAIL_LAST_VISIT"] = "Letzter Besuch:"
L["ARMORY_MAIL_REMAINING"] = "Verbleibende Post:"
L["ARMORY_MAIL_VISIT_WARNING"] = "%1$s (%2$s) hat den Briefkasten seit %3$s nicht mehr überprüft. Bitte log dich ein um deinen Posteingang zu überprüfen."
L["ARMORY_MINIMAP_LABEL"] = "Minikarte"
L["ARMORY_MINIMAP_SUBTEXT"] = "Diese Optionen kontrollieren die Anzeige des Minikartenbuttons."
L["ARMORY_MINIMAP_TITLE"] = "Armory-Minikartenbutton"
L["ARMORY_MISC_LABEL"] = "Verschiedenes"
L["ARMORY_MISC_SUBTEXT"] = "Diese Optionen erlauben es dir, weitere Einstellungen zu verändern."
L["ARMORY_MISC_TITLE"] = "Verschiedene Optionen"
L["ARMORY_MODULES_LABEL"] = "Module"
L["ARMORY_MODULES_SUBTEXT"] = "Diese Optionen erlauben es dir auszuwählen, welche Module aktiv sein sollen."
L["ARMORY_MODULES_TITLE"] = "Armory-Module"
L["ARMORY_MONEY_TOTAL"] = "%1$s %2$s ingesamt:"
L["ARMORY_NO_DATA"] = "Keine Daten verfügbar"
L["ARMORY_OPEN_HINT"] = "Klicken, um zu öffnen"
L["ARMORY_PANDARIA_GEM_RESEARCH"] = "Juwelenschleifen-Forschung von Pandaria"
L["ARMORY_QUEST_TOOLTIP_LABEL"] = "Charaktere auf dieser Quest:"
L["ARMORY_RECIPE"] = "Rezept"
L["ARMORY_RECIPE_WARNING"] = [=[Rezept %s wurde in LibRecipes nicht gefunden. Angabe im Tooltip ist eine Vermutung.
Bitte mit  '/ar suche Fähigkeit ...' prüfen, um sicherzugehen.]=]
L["ARMORY_REPUTATION_SUMMARY"] = "%1$s - %2$s (%3$d/%4$d,%5$d verbleibend)"
L["ARMORY_SEARCHING"] = "Suche ..."
L["ARMORY_SELECT_UNIT_HINT"] = "Linksklick, um diesen Charakter auszuwählen."
L["ARMORY_SHARE_DOWNLOAD_LOADERROR"] = "%1$s konnte nicht geladen werden;Begründung: %2$s"
L["ARMORY_SHARE_LABEL"] = "Daten Teilen"
L["ARMORY_SHARE_SUBTEXT1"] = [=[Diese Optionen definieren wie Daten mit anderen Armorynutzern geteilt werden.
Achtung: Diese Einstellungen werden für jeden Charakter separat gespeichert.]=]
L["ARMORY_SHARE_SUBTEXT2"] = "Die folgenden Optionen werden global gesetzt."
L["ARMORY_SHARE_TITLE"] = "Daten Teilen"
L["ARMORY_SHORTDATE_FORMAT"] = "ARMORY_SHORTDATE_FORMAT"
L["ARMORY_SLASH_ALTERNATIVES"] = "/ar"
L["ARMORY_SOCIAL_ADD_TOOLTIP"] = "Shift-Klick, um dies deiner aktuellen Liste hinzuzufügen."
L["ARMORY_SUBTEXT"] = "Diese Optionen erlauben es dir, das Verhalten von Armory zu beeinflussen."
L["ARMORY_SUMMARY_LABEL"] = "Charakterübersicht"
L["ARMORY_SUMMARY_SUBTEXT1"] = "Diese Optionen erlauben dir, die Charakterübersicht zu beeinflussen."
L["ARMORY_SUMMARY_SUBTEXT2"] = "Wähle die Informationen, die angezeigt werden solllen."
L["ARMORY_SUMMARY_TITLE"] = "Optionen der Charakterübersicht"
L["ARMORY_TALENTS"] = "Talentspezialisierung:"
L["ARMORY_TOOLTIP_HINT1"] = "Klicken schaltet Armory um"
L["ARMORY_TOOLTIP_HINT2"] = "Rechtsklicken für Optionen"
L["ARMORY_TOOLTIP_LABEL"] = "Tooltip"
L["ARMORY_TOOLTIP_SUBTEXT"] = "Diese Optionen erlauben es, den Tooltips weitere Informationen hinzuzufügen"
L["ARMORY_TOOLTIP_TITLE"] = "Verbesserung der Tooltips"
L["ARMORY_TOOLTIP1"] = "Charakter:"
L["ARMORY_TOOLTIP2"] = "Realm:"
L["ARMORY_TOTAL"] = "Gesamt: %d"
L["ARMORY_TRADE_ALCHEMY"] = "Alchemie"
L["ARMORY_TRADE_BLACKSMITHING"] = "Schmiedekunst"
L["ARMORY_TRADE_COOKING"] = "Kochkunst"
L["ARMORY_TRADE_ENCHANTING"] = "Verzauberkunst"
L["ARMORY_TRADE_ENGINEERING"] = "Ingenieurskunst"
L["ARMORY_TRADE_FIRST_AID"] = "Erste Hilfe"
L["ARMORY_TRADE_FISHING"] = "Angeln"
L["ARMORY_TRADE_HERBALISM"] = "Kräuterkunde"
L["ARMORY_TRADE_INSCRIPTION"] = "Inschriftenkunde"
L["ARMORY_TRADE_JEWELCRAFTING"] = "Juwelenschleifen"
L["ARMORY_TRADE_LEATHERWORKING"] = "Lederverarbeitung"
L["ARMORY_TRADE_MINING"] = "Bergbau"
L["ARMORY_TRADE_POISONS"] = "Gifte"
L["ARMORY_TRADE_SKILLS"] = "Hauptberufe:"
L["ARMORY_TRADE_SKINNING"] = "Kürschnerei"
L["ARMORY_TRADE_TAILORING"] = "Schneiderei"
L["ARMORY_TRADE_UPDATE_FAILED"] = "Berufsdaten unvollständig. Bitte öffne und schließe das Berufsfenster erneut."
L["ARMORY_TRADE_UPDATE_WARNING"] = "Berufsdaten konnten nicht gespeichert werden. Bitte verwende den Verlassen-Knopf, um eine Aktualisierung auszulösen."
L["ARMORY_TRADESKILL_SEARCH_TEXT_TOOLTIP"] = [=[Filterkriterum eingeben.

Merke, du kannst auch nach Itemlevel filtern, zum Beispiel "10", "~10" oder "10-20".]=]
L["ARMORY_TRANSMUTE"] = "Transmutieren"
L["ARMORY_UPDATE_SUSPENDED"] = "unterbrochen"
L["ARMORY_VOID_STORAGE_ABBR"] = "Leerenlager"
L["ARMORY_WARNING"] = "WARNUNG"
L["ARMORY_WHAT"] = "Was"
L["ARMORY_WHERE"] = "Wo"
L["ARMORY_WHO"] = "Wer"
L["ARMORY_WILL_LEARN"] = "Erreichbar von"
L["ARMORY_XP_SUMMARY"] = "Stufe %1$d (%2$s) %3$d EP verbleibend, %4$s ausgeruht"
L["BINDING_NAME_ARMORY_ACHIEVEMENT"] = "Erfolgsfenster öffnen"
L["BINDING_NAME_ARMORY_CHARACTER"] = "Charakterfenster öffnen"
L["BINDING_NAME_ARMORY_CURRENCY"] = "Währungsfenster öffnen"
L["BINDING_NAME_ARMORY_INVENTORY"] = "Inventar öffnen"
L["BINDING_NAME_ARMORY_PET"] = "Begleiterfenster öffnen"
L["BINDING_NAME_ARMORY_PVP"] = "PVP-Fenster öffnen"
L["BINDING_NAME_ARMORY_QUEST"] = "Questlog öffnen"
L["BINDING_NAME_ARMORY_RAID"] = "Schlachtzug-Fenster öffnen"
L["BINDING_NAME_ARMORY_REPUTATION"] = "Ruffenster öffnen"
L["BINDING_NAME_ARMORY_SOCIAL"] = "Geselligkeitsfenster öffnen"
L["BINDING_NAME_ARMORY_SPELLBOOK"] = "Zauberbuch öffnen"
L["BINDING_NAME_ARMORY_TALENT"] = "Talentfenster öffnen"
L["BINDING_NAME_ARMORY_TOGGLE"] = "Armory umschalten"
L["BINDING_NAME_ARMORY_TRADESKILL1"] = "Fenster mit erstem Hauptberuf öffnen"
L["BINDING_NAME_ARMORY_TRADESKILL2"] = "Fenster mit zweitem Hauptberuf öffnen"
L["BINDING_NAME_CURRENT_CHARACTER"] = "Diesen Charakte auswählen"
L["BINDING_NAME_FIND"] = "Datenbanksuche umschalten"
L["BINDING_NAME_LOOKUP"] = "Inspektion umschalten"
L["BINDING_NAME_NEXT_CHARACTER"] = "Wähle nächsten Charakter"
L["BINDING_NAME_PREVIOUS_CHARACTER"] = "Wähle vorherigen Charakter"

