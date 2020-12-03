script_name('Medick Helper')
script_version '2.9.2'
local dlstatus = require "moonloader".download_status
script_author('Pioner_Comedoz,Jon Ortiz')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local a = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- çàãðóæàåì áèáëèîòåêó/
local encoding = require 'encoding' -- çàãðóæàåì áèáëèîòåêó
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)
local sInputEdit = imgui.ImBuffer(128)
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- óêàçûâàåì êîäèðîâêó ïî óìîë÷àíèþ, îíà äîëæíà ñîâïàäàòü ñ êîäèðîâêîé ôàéëà. CP1251 - ýòî Windows-1251
u8 = encoding.UTF8
require 'lib.sampfuncs'
seshsps = 1
ctag = "{9966cc} Medick Helper {ffffff}|"
players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
frak = nil
rang = nil
ttt = nil
dostavka = false
rabden = false
tload = false
changetextpos = false
tLastKeys = {}
prava = 0
pilot = 0
kater = 0
gun = 0
ribolov = 0
biznes = 0
departament = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style()

	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
	style.WindowRounding = 6.0
	style.FramePadding = ImVec2(5, 5)
	style.FrameRounding = 4.0
	style.ItemSpacing = ImVec2(12, 8)
	style.ItemInnerSpacing = ImVec2(8, 6)
	style.IndentSpacing = 25.0
	style.ScrollbarSize = 15.0
	style.ScrollbarRounding = 9.0
	style.GrabMinSize = 5.0
	style.GrabRounding = 3.0

	colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
	colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
	colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
	colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
	colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
	colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
	colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
	colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
	colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
	colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
	colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
	colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
	colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
	colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
	colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
	colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
	colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
	colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
	colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
	colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
	colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
	colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
	colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
	colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
	colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
apply_custom_style()

local fileb = getWorkingDirectory() .. "\\config\\instools.bind"
local tBindList = {}
if doesFileExist(fileb) then
	local f = io.open(fileb, "r")
	if f then
		tBindList = decodeJson(f:read())
		f:close()
	end
else
	tBindList = {
        [1] = {
            text = "",
            v = {key.VK_No}
        }
	}
end

local instools =
{
  main =
  {
    posX = 1738,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = 'Èíòåðí',
	tarr = 'òýã',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0
  },
  commands =
  {
    ticket = false,
	zaderjka = 5
  },
   keys =
  {
	tload = 113,
	tazer = 113,
	fastmenu = 114
  }
}
cfg = inicfg.load(nil, 'instools/config.ini')

local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
	ftext('Medick Helper óñïåøíî çàãðóæåí.',-1)
	ftext('Ãëàâ.Âðà÷: Rodrigo_Quintana.',-1)
	ftext('Ñêðèïò ðåäàêòèðîâàë: Doni Baerra, Makar Sheludkov',-1)
	ftext('Ôóíêöèè ñêðèïòà êîìàíäà è êíîïêà: {ff0000} /Ih è F3 èëè ÏÊÌ+Z',-1)
	ftext('Ïåðåçàãðóçèòü ñêðèïò åñëè îòêëþ÷èòñÿ, îäíîâðåìåííî íàæàòü {ff0000}Ctrl+R.',-1)
    ftext('Ñêðèïò âçÿò ïîä îñíîâó ñ {ff0066}Instructors Helps.',-1)
  end
  if not doesDirectoryExist('moonloader/config/instools/') then createDirectory('moonloader/config/instools/') end
  if cfg == nil then
    sampAddChatMessage("{9966cc}Medick Help {ffffff}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
    if inicfg.save(instools, 'medick/config.ini') then
      sampAddChatMessage("{9966cc}Medick Help {ffffff}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
      cfg = inicfg.load(nil, 'medick/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Çàãðóæàåòñÿ áèáëèîòåêà '..v)
        end
    end
	if not doesFileExist("moonloader/config/instools/keys.json") then
        local fa = io.open("moonloader/config/instools/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/instools/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/instools') then createDirectory('moonloader/instools') end
  hk = require 'lib.imcustom.hotkey'
  imgui.HotKey = require('imgui_addons').HotKey
  rkeys = require 'rkeys'
  imgui.ToggleButton = require('imgui_addons').ToggleButton
  while not sampIsLocalPlayerSpawned() do wait(0) end
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name, surname = string.match(sampGetPlayerNickname(myid), '(.+)_(.+)')
  sip, sport = sampGetCurrentServerAddress()
  sampSendChat('/stats')
  while not sampIsDialogActive() do wait(0) end
  proverkk = sampGetDialogText()
  local frakc = proverkk:match('.+Îðãàíèçàöèÿ%s+(.+)%s+Äîëæíîñòü')
  local rang = proverkk:match('.+Äîëæíîñòü%s+%d+ %((.+)%)%s+Ðàáîòà')
  local telephone = proverkk:match('.+Òåëåôîí%s+(.+)%s+Çàêîíîïîñëóøíîñòü')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}None', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
  sampCreate3dTextEx(642, '{ffffff}None', 4294927974, 2337.5002,1657.4896,3040.9524, 3, true, -1, -1)
  sampCreate3dTextEx(643, '{ffffff}None.{ff0000}óãó!', 4294927974, 2337.8091,1669.0276,3040.9524, 3, true, -1, -1)
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  fastsmskey = rkeys.registerHotKey(config_keys.fastsms.v, true, fastsmsk)
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('dcol', cmd_color)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('smsjob', smsjob)
  sampRegisterChatCommand('where', where)
  sampRegisterChatCommand('ih', ih)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('ivig',ivig)
  sampRegisterChatCommand('unvig',unvig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('blg', blg)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('zinv', zinv)
  sampRegisterChatCommand('ginv', ginv)
  sampRegisterChatCommand('uninvite', uninvite)
  sampRegisterChatCommand('z', zheal)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('Ïî çàâåðøåíèþ ââåäèòå êîìàíäó åùå ðàç.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medick/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
            end
        else
            ftext('Äëÿ íà÷àëà âêëþ÷èòå èíôî-áàð.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
     datetime = os.date("!*t",os.time()) 
if datetime.min == 00 and datetime.sec == 10 then 
sampAddChatMessage("{F80505}Íå çàáóäü îñòàâèòü {0CF513}TimeCard {F80505}íà ôîðóìå", -1) 
wait(1000)
end
    if #departament > 25 then table.remove(departament, 1) end
    if cfg == nil then
      sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
      if inicfg.save(instools, 'instools/config.ini') then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
        cfg = inicfg.load(nil, 'medick/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Áûñòðîå ìåíþ")
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Ñèñòåìà ïîâûøåíèé")
    end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
            end
        end
	if cfg.main.givra == true then
      infbar.v = true
      imgui.ShowCursor = false
    end
    if cfg.main.givra == false then
      infbar.v = false
      imgui.ShowCursor = false
    end
		if changetextpos then
            sampToggleCursor(true)
            local CPX, CPY = getCursorPos()
            cfg.main.posX = CPX
            cfg.main.posY = CPY
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end

local fpt = [[
Ãëàâà ¹1. Îáùåå ïîëîæåíèå
1.01 Óñòàâ ÿâëÿåòñÿ îáÿçàòåëüíûì ê èñïîëíåíèþ âñåìè ñîòðóäíèêàìè îðãàíèçàöèè. 
1.02 Óñòàâ Ìèíèñòåðñòâà Çäðàâîîõðàíåíèÿ ÿâëÿåòñÿ äîêóìåíòîì, ðåãóëèðóþùåì âçàèìîîòíîøåíèÿ ðóêîâîäñòâà Ministry Of Health ñ ñîòðóäíèêàìè îðãàíèçàöèè, à èìóùåñòâî áîëüíèö ÿâëÿåòñÿ ãîñóäàðñòâåííîé ñîáñòâåííîñòüþ. 
1.03 Íåçíàíèå óñòàâà íå îñâîáîæäàåò âàñ îò îòâåòñòâåííîñòè.
1.04 Çà íàðóøåíèå óñòàâà ê ñîòðóäíèêó îðãàíèçàöèè ìîãóò ïðèìåíÿòüñÿ ðàçëè÷íûå ñàíêöèè, íà÷èíàÿ îò óñòíîãî ïðåäóïðåæäåíèÿ è çàêàí÷èâàÿ óâîëüíåíèåì èç ðÿäîâ îðãàíèçàöèè Ministry of Health ñ çàíåñåíèåì â ÷åðíûé ñïèñîê.
1.05 Ðåøåíèå ãëàâíîãî âðà÷à ÿâëÿåòñÿ îêîí÷àòåëüíûì è îáæàëîâàíèþ íå ïîäëåæèò.
1.06 Ðàáîòà ìåäèöèíñêîãî ðàáîòíèêà îñíîâûâàåòñÿ òàê æå íà ïðèíöèïàõ ìèëîñåðäèÿ, äîáðîòû.
1.07 Óñòàâ ìîæåò èñïðàâëÿòüñÿ èëè äîïîëíÿòüñÿ Ãëàâíûì Âðà÷îì.
1.08 Íàðóøèòü óñòàâ èëè ïðèêàçàòü åãî íàðóøèòü â ðàçóìíûõ öåëÿõ ìîæåò òîëüêî Ãëàâ. Âðà÷. à òàê æå ñîòðóäíèêè ïî ïðèêàçó âûøåñòîÿùåãî ðóêîâîäñòâà MOH.
1.09 Îáëàäàíèå íàèâûñøèì äîñòèæèìûì óðîâíåì çäîðîâüÿ ÿâëÿåòñÿ îäíèì èç îñíîâíûõ ïðàâ êàæäîãî ÷åëîâåêà áåç ðàçëè÷èÿ ðàñû, ðåëèãèè, ïîëèòè÷åñêèõ óáåæäåíèé, ýêîíîìè÷åñêîãî èëè ñîöèàëüíîãî ïîëîæåíèÿ.
1.10 Ëþáîé ãðàæäàíèí øòàòà èìååò ïðàâî íà ïîëó÷åíèå óñëóã Ministry Of Health áåç ðàçëè÷èÿ ðàñû, ðåëèãèè, ïîëèòè÷åñêèõ
óáåæäåíèé, ýêîíîìè÷åñêîãî èëè ñîöèàëüíîãî ïîëîæåíèÿ.

Ãëàâà ¹2. Ðåæèì ðàáîòû
2.01 Ðåæèì ðàáîòû â áóäíèå äíè (Ïîíåäåëüíèê  Ïÿòíèöà) íà÷èíàåòñÿ ñ 8:00 è çàêàí÷èâàåòñÿ â 21:00.
2.02 Ðåæèì ðàáîòû â âûõîäíûå äíè (Ñóááîòà  Âîñêðåñåíüå) íà÷èíàåòñÿ ñ 9:00 è çàêàí÷èâàåòñÿ â 20:00.
2.03 Êàæäûé ñîòðóäíèê ïî ïðèáûòèþ â øòàò îáÿçàí ÿâèòüñÿ íà ðàáîòó â òå÷åíèå 15 ìèíóò.
2.04 Îáåäåííûé ïåðåðûâ íà÷èíàåòñÿ â 14:00 äî 15:00 åæåäíåâíî.
2.05 Ãëàâíûé Âðà÷ âïðàâå èçìåíèòü ãðàôèê ðåæèìà ðàáîòû ïî ñâîåìó óñìîòðåíèþ.
2.06 ÐÏ ñîí ðàçðåøàåòñÿ òîëüêî âî âðåìÿ îáåäåííîãî ïåðåðûâà, ñ 14:00 äî 15:00.
2.07 Âûåçä â çàêóñî÷íûå âíå îáåäåííîãî ïåðåðûâà âîçìîæíû òîëüêî ñ ðàçðåøåíèÿ ðóêîâîäñòâà MOH. 

Ãëàâà ¹3. Îáÿçàííîñòè ñîòðóäíèêîâ
3.01 Ìåäèöèíñêèé ðàáîòíèê îáÿçàí îêàçàòü ìåäèöèíñêóþ ïîìîùü íóæäàþùåìóñÿ, áåç ðàçëè÷èÿ ðàñû, ðåëèãèè, ïîëèòè÷åñêèõ óáåæäåíèé, ýêîíîìè÷åñêîãî èëè ñîöèàëüíîãî ïîëîæåíèÿ.
3.02 Ñîòðóäíèêè MOH îáÿçàòåëüíî äîëæíû áûòü âåæëèâûìè è îáðàùàòüñÿ ê ëþäÿì è ê êîëëåãàì, ñòðîãî íà "Âû". (çà íåöåíçóðíóþ ëåêñèêó â /b òàêæå ïîñëåäóåò íàêàçàíèå âïëîòü äî óâîëüíåíèÿ)
3.03 Ñîòðóäíèê MOH îáÿçàí äîñòàâèòü ïîñòðàäàâøåãî äî ïðèåìíîãî ïîêîÿ áîëüíèöû, åñëè åñòü òàêàÿ íåîáõîäèìîñòü.
3.04 Ñîòðóäíèê îáÿçàí îêàçûâàòü ìåäèöèíñêóþ ïîìîùü, ïðèëàãàÿ âñå óñèëèÿ è íàâûêè (RP-îòûãðîâêà), Íàðóøåíèå âëå÷åò çà ñîáîé ( Ïîíèæåíèå, Óâîëüíåíèå)
3.05 Ñîòðóäíèê MOH îáÿçàí ïàðêîâàòü ëè÷íûé òðàíñïîðò èñêëþ÷èòåëüíî íà ñòîÿíêå ðàçðåøåííîé äåïàðòàìåíòîì ãîðîäà.
3.06 Îòäûõàòü, (AFK) ðàçðåøàåòñÿ òîëüêî â îðäèíàòîðñêîé áîëüíèöû.
3.07 Çà ñîí ( AFK ) íà ïîñòó áîëåå 100 ñåêóíä êàðàåòñÿ (Âûãîâîðîì, ïîíèæåíèåì, óâîëüíåíèåì.)
3.07 Â ðàáî÷åå âðåìÿ, ñîòðóäíèê MOH îáÿçàí íàõîäèòüñÿ íà íàçíà÷åííîì åìó ïîñòó è èñïîëíÿòü ñâîè äîëæíîñòíûå îáÿçàííîñòè. 
3.08 Ïî ïðèíÿòèþ âûçîâà, ìåäèöèíñêèé ñîòðóäíèê îáÿçàí äåëàòü äîêëàä â ðàöèþ î ïðèíÿòèè âûçîâà îò äèñïåò÷åðà. 
3.09 Ðóêîâîäèòåëü à òàê æå Çàìåñòèòåëü Ðóêîâîäèòåëÿ îòäåëà, îáÿçàí íàó÷èòü ñîòðóäíèêîâ ñâîåãî îòäåëà âñåìó, ÷òî çíàåò ñàì  â ïîëíîé ìåðå.
3.10 Âîçäóøíûé ïàòðóëü øòàòà ðàçðåø¸í ñ äîëæíîñòè "Ïñèõîëîã".
3.11 Íàçåìíûé ïàòðóëü ãîðîäà ðàçðåøåí ñ äîëæíîñòè "Ìåä.Áðàòà" îò äâóõ ÷åëîâåê, â òîì ñëó÷àå, åñëè âñå ïîñòû çàíÿòû.
3.12 Íàçåìíûé ïàòðóëü øòàòà ðàçðåø¸í äëÿ ñîòðóäíèêîâ îòäåëà SOMM 
3.13 Íîøåíèå è ïðèìåíåíèå îãíåñòðåëüíîãî îðóæèÿ ðàçðåøåíî ñ äîëæíîñòè "Ïñèõîëîã" è âûøå, èñêëþ÷åíèå ïðè âûåçäîâ íà ×Ñ. Â ñëó÷àå íàðóøåíèå (Âûãîâîð)
3.14 Ïåðåâîä ìåæäó îòäåëàìè îñóùåñòâëÿåòñÿ ñ äîëæíîñòè "Íàðêîëîã" ñ ðàçðåøåíèÿ âàøåãî Íà÷àëüíèêà îòäåëà.
3.15 SOMM îáÿçàí ìèíèìóì 1 ðàç â íåäåëþ ïðîâîäèòü âíåïëàíîâûå îñìîòðû ãîñóäàðñòâåííî ñëóæàùèé
3.16 Ñîòðóäíèê îòäåëà SOMM îáÿçàí ïðîâîäèòü Âîåííî-âðà÷åáíûå ýêñïåðòèçû äëÿ ñîòðóäíèêîâ ãîñóäàðñòâåííîé îðãàíèçàöèè

Ãëàâà ¹4. Çàïðåòû ñîòðóäíèêà
4.01 Îòêàç îò âûõîäà íà ðàáîòó, à òàê æå ñàìîâîëüíîå çàâåðøåíèå ðàáî÷åãî äíÿ. (Ïîíèæåíèå, Óâîëüíåíèå)
4.02 Íàõîæäåíèå â êàçèíî â ðàáî÷åå èëè íå ðàáî÷åå âðåìÿ â ôîðìå (Ïîíèæåíèå, Óâîëüíåíèå)
4.03 Âõîäèòü â ÐÏ ñîí âî âðåìÿ ðàáî÷åãî äíÿ è âíå ðàáî÷åãî âðåìåíè â ôîðìå (Ñîòðóäíèê îáÿçàí ñíÿòü ðàáî÷óþ ôîðìó ïîñëå çàâåðøåíèÿ ðàáî÷åãî äíÿ, äëÿ ÐÏ ñíà). 
4.04 Çà íåïîä÷èíåíèå ðóêîâîäÿùåìó ñîñòàâó (Ïñèõîëîã è âûøå, â íåêîòîðûõ ñëó÷àÿõ Ãëàâû èëè Çàìåñòèòåëè îòäåëîâ) êàðàåòñÿ (Ïîíèæåíèåì, Óâîëüíåíèåì)
4.05 Ââåäåíèå â çàáëóæäåíèå ðóêîâîäñòâî è èõ îáìàí, à òàê æå Ãëàâ.îòäåëîâ è èõ çàìåñòèòåëåé, êàðàåòñÿ (óâîëüíåíèåì ñ äàëüíåéøèì çàíåñåíèåì â ×åðíûé Ñïèñîê MOH.)
4.06 Çà ëå÷åíèå âèòàìèíàìè, àñêîðáèíêàìè è ïðî÷èì, ñîòðóäíèê áóäåò êàðàòüñÿ (Âûãîâîðîì, Ïîíèæåíèåì.)
4.07 Íå âûïîëíåíèå ñëóæåáíûõ îáÿçàííîñòåé äëÿ ðóêîâîäñòâà êàðàåòñÿ (Ñíÿòèåì ñ äîëæíîñòè)
4.08 Ëþáîé ïðèçíàê íåóâàæåíèÿ, ïîïûòêà óíèçèòü äîñòîèíñòâî ÷åëîâåêà êàðàåòñÿ (âûãîâîðîì, ïîíèæåíèåì, óâîëüíåíèåì ñ äàëüíåéøèì çàíåñåíèåì â ×åðíûé Ñïèñîê.)
4.09 Êóðåíèå âíóòðè çäàíèÿ çàïðåùåíî (Âûãîâîð, Ïîíèæåíèå) 
4.10 Ëå÷åíèå ëþáûõ áîëåçíåé ïðîèçâîäèòñÿ èñêëþ÷èòåëüíî â ïàëàòå, îïåðàöèîííîé èëè â êàðòå ñêîðîé ïîìîùè. Çà íàðóøåíèå äàííîãî ïóíêòà (Âûãîâîð, Ïîíèæåíèå)
4.11 Èñïîëüçîâàòü ñëóæåáíûå àâòîìîáèëè è âåðòîë¸òû â ëè÷íûõ öåëÿõ êàðàåòñÿ (Âûãîâîðîì)
4.12 Èñïîëüçîâàíèå ñïåö.ñèãíàëîâ â ëè÷íûõ öåëÿõ çàïðåùåíî, êàðàåòñÿ (Âûãîâîðîì)
4.13 Íåêîððåêòíîå èñïîëüçîâàíèå âîëíû äåïàðòàìåíòà êàðàåòñÿ (Âûãîâîðîì, Óâîëüíåíèåì)
4.14 Èñïîëüçîâàíèå âîëíû äåïàðòàìåíòà ñîòðóäíèêàì íèæå äîëæíîñòè "Ìåä.Áðàò" [3 ðàíã] êàðàåòñÿ (Âûãîâîðîì, Óâîëüíåíèåì)
4.15 Ñîòðóäíèêàì çàïðåùåíî ïðåðåêàòüñÿ ñ íà÷àëüñòâîì ïî ðàöèè êàðàåòñÿ (Âûãîâîðîì)
4.16 Âûÿñíÿòü îòíîøåíèÿ, îñêîðáëåíèÿ íà ëþáîé âîëíå êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)
4.17 Ëþáàÿ ðåêëàìà â ðàöèè îðãàíèçàöèè èëè äåïàðòàìåíòà êàðàåòñÿ (Ïîíèæåíèåì, Óâîëüíåíèåì)
4.18 Ïîëüçîâàòüñÿ ðàöèåé äåïàðòàìåíòà åñëè îíà çàêðûòà íà ×Ñ. (Âûãîâîð)
4.19 Çàïðåùåíî âûïðàøèâàòü ïîâûøåíèå, êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)
4.20 Çà íîøåíèå ôîðìû íå ïî äîëæíîñòè, êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)
4.21 Çàïðåùàåòñÿ íîøåíèå ëèøíèõ àêñåññóàðîâ, ïåðåèçáûòîê èõ, êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)

Ãëàâà ¹6. Èñïîëüçîâàíèå ðàöèè
6.01 Àáñîëþòíî âñå ñîòðóäíèêè îáÿçàíû ñòðîãî ñîáëþäàòü ïðàâèëà ïîëüçîâàíèÿ ðàöèåé. 
6.02 Ïðè âûçîâå êàðåòû ïî âîëíå äåïàðòàìåíòà, ñîòðóäíèê, êîòîðûé âûåçæàåò íà âûçîâ, îáÿçàí ñîîáùèòü ïî âîëíå Ìèíçäðàâà î ñâîåì âûåçäå íà âûçîâ. À ðóêîâîäèòåëè â äàííîì ñëó÷àå îáÿçàíû ñîîáùèòü ïî âîëíå äåïàðòàìåíòà î âûåçäå êàðåòû.
6.03 Ñîòðóäíèê îáÿçàí ñîîáùàòü â ðàöèþ äîêëàäû î çàñòóïëåíèè íà ïîñò èëè ïàòðóëü, î ñîñòîÿíèè ïîñòà èëè ïàòðóëÿ, îá óåçäå ñ ïîñòà ñ óêàçàíèåì ïðè÷èíû.
6.04 Ñîòðóäíèê îáÿçàí íàõîäÿñü íà ïîñòó, äîêëàäûâàòü â ðàöèþ êàæäûå 5 ìèíóò ÷àñà. (Ïðèìåð: 12:05, 12:10 è ò.ä)
6.05 Ïðè çàïðîñå îò ñòàðøåãî ñîñòàâà èëè Ãëàâ îòäåëîâ è èõ çàìåñòèòåëåé, ñ ïðîñüáîé ñîîáùåíèè ñòàòóñà ïîñòîâ, ñîòðóäíèê - îáÿçàí íåçàìåäëèòåëüíî ñîîáùèòü.

Ãëàâà¹7. Ïîâûøåíèÿ / ïîíèæåíèÿ / âûãîâîðû / óâîëüíåíèÿ
7.01 Ñèñòåìà ïîâûøåíèÿ åäèíà äëÿ âñåõ ñîòðóäíèêîâ MOH. 
7.02 Âñå ïîâûøåíèÿ, ïîíèæåíèÿ, âûãîâîðû è óâîëüíåíèÿ ôèêñèðóþòñÿ â ñîîòâåòñòâóþùèõ ðååñòðàõ. 
7.03 Âûãîâîð ÿâëÿåòñÿ ïðåäóïðåæäåíèåì. Äâà âûãîâîðà  ïîíèæåíèåì â äîëæíîñòè. Òðè âûãîâîðà  óâîëüíåíèå. 
7.04 Â ñëó÷àå íåñîãëàñèÿ ñ ðåøåíèåì ñòàðøåãî ñîñòàâà êàñàòåëüíî âûãîâîðà, ïîíèæåíèÿ èëè óâîëüíåíèÿ ñîòðóäíèê âïðàâå ïîäàòü æàëîáó Ãëàâíîìó Âðà÷ó â ñîîòâåòñòâóþùåì ðàçäåëå. 
7.05 Ñîòðóäíèêó ìîæåò áûòü îòêàçàíî â ïîâûøåíèè â ñâÿçè ñ ìàëîé àêòèâíîñòüþ. 

Ãëàâà¹8. Ïðàâèëà îòïóñêà è íåàêòèâà.
8.01 Ñîòðóäíèê èìååò ïðàâî âçÿòü îòïóñê ñ äîëæíîñòè "Äîêòîð" [6 ðàíã]
8.02 Äëèòåëüíîñòü îòïóñêà ñîñòàâëÿåò íå áîëåå 14 äíåé ðàç â äâà ìåñÿöà. 
8.03 Íåàêòèâ áåð¸òñÿ ñðîêîì äî 14 äíåé, ïðè íàëè÷èè óâàæèòåëüíîé ïðè÷èíû. 
8.04 Â ñëó÷àå, åñëè ðàáîòíèê âîçâðàùàåòñÿ â óêàçàííûé ñðîê, åãî âîññòàíàâëèâàþò â äîëæíîñòè.
8.05 Â ñëó÷àå, åñëè ñîòðóäíèê íå âîçâðàùàåòñÿ â óêàçàííûé ñðîê, îí (Óâîëüíÿåòñÿ)
8.06 Ïðè ñëóæåáíîé íåîáõîäèìîñòè, ñîòðóäíèê ìîæåò áûòü âûçâàí ñ îòïóñêà. 
8.07 Âî âðåìÿ îòïóñêà èëè íåàêòèâà ñòðîãî çàïðåùàåòñÿ íàõîäèòñÿ â êðèìèíàëüíûõ ãðóïïèðîâêàõ, êàðàåòñÿ (Óâîëüíåíèåì)
8.08 Âî âðåìÿ íàõîæäåíèÿ â îòïóñêå èëè íåàêòèâå, çàïðåùåíî íàðóøàòü çàêîíû Øòàòà, ÅÊÃÑ. (Ïîíèæåíèå, Óâîëüíåíèå)
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end

function blg(pam)
    local id, frack, pric = pam:match('(%d+) (%a+) (.+)')
    if id and frack and pric and sampIsPlayerConnected(id) then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/d %s, áëàãîäàðþ %s çà %s. Öåíèòå!", frack, rpname, pric))
    else
        ftext("Ââåäèòå: /blg [id] [Ôðàêöèÿ] [Ïðè÷èíà]", -1)
		ftext("Ïðèìåð: òðàíñïîðòèðîâêó, ñïàñåíèå æèçíè, è ò.ä. ", -1)
    end
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{9966cc}Medick Helper {ffffff}| {ae433d}Âíå îôèñà {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{9966cc}Instructors Help{ffffff} | Ëîã ñîîáùåíèé äåïàðòàìåíòà', table.concat(departament, '\n'), '»', 'x', 0)
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == '' or rank == 'Çàìåñòèòåëü Ãëàâíîãî Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Äîêòîð' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /vig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /vig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end
function ivig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Äîêòîð' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /ivig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /ivig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò ñòðîãèé âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò ñòðîãèé âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function unvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Äîêòîð' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /unvig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /unvig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò cíÿòèå âûãîâîðà ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò cíÿòèå âûãîâîðà ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- çàïðîñ ìåñòîïîëîæåíèÿ
   if rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", name))
			end
			else
			ftext('{FFFFFF} Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Èñïîëüçóéòå: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Äàííàÿ êîìàíäà äîñòóïíà ñ 6 ðàíãà.', 0x046D63)
	end
end

function getrang(rangg)
local ranks =
        {
		['1'] = 'Èíòåðíà',
		['2'] = 'Ñàíèòàðà',
		['3'] = 'Ìåä.Áðàòà',
		['4'] = 'Ñïàñàòåëÿ',
		['5'] = 'Íàðêîëîãà',
		['6'] = 'Äîêòîðà',
		['7'] = 'Ïñèõîëîãà',
		['8'] = 'Õèðóðãà',
		['9'] = 'Çàì.Ãëàâ.Âðà÷à'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me ñíÿë ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(2000)
				sampSendChat('/me óáðàë ñòàðûé áåéäæèê â êàðìàí')
				wait(2000)
                sampSendChat(string.format('/me äîñòàë íîâûé áåéäæèê %s', ranks))
				wait(2000)
				sampSendChat('/me çàêðåïèë íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(2000)
				else
				sampSendChat('/me ñíÿëà ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(2000)
				sampSendChat('/me óáðàëà ñòàðûé áåéäæèê â êàðìàí')
				wait(2000)
                sampSendChat(string.format('/me äîñòàëà íîâûé áåéäæèê %s', ranks))
				wait(2000)
				sampSendChat('/me çàêðåïèëà íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(2000)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(2000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', cfg.main.tarr, plus == '+' and 'Ïîâûøåí' or 'Ïîíèæåí(à)', ranks, plus == '+' and ', Ïîçäðàâëÿåì!' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', plus == '+' and 'Ïîâûøåí' or 'Ïîíèæåí', ranks, plus == '+' and ', Ïîçäðàâëÿåì!' or ''))
				wait(2000)
				sampSendChat('/b /time+F8 äåëàé.Îáÿçàòåëüíî')
            end
			else
			ftext('Âû ââåëè íåâåðíûé òèï [+/-]')
		end
		else
			ftext('Ââåäèòå: /giverank [id] [ðàíã] [+/-]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 7 ðàíãà')
	  end
	  else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
	  end
   end)
 end

function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Ïñèõîëîã' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me äîñòàë(à) áåéäæèê è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(4000)
				sampSendChat(string.format('/invite %s', id))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
		end
		else
			ftext('Ââåäèòå: /invite [id]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 7 ðàíãà.')
	  end
   end)
 end
function zheal(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
				wait(1500)
				sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
				wait(1500)
				sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1100)
				sampSendChat(string.format('/heal %s', id))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
		end
		else
			ftext('Ââåäèòå: /z [id]')
		end
   end)
end
 function ginv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(ginvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	end
	  else
			ftext('Ââåäèòå: /ginv [id]')
	end
	  end)
   end

 function zinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(zinvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	end
	  else
			ftext('Ââåäèòå: /zinv [id]')
	end
	  end)
   end

 function oinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(oinvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî ÷åëîâåêà')
	end
	  else
			ftext('Ââåäèòå: /oinv [id]')
	end
	  end)
   end

 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or rank == 'Ïñèõîëîã' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me çàáðàë(à) ôîðìó è áåéäæèê ó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(2000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID')
		end
		else
			ftext('Ââåäèòå: /uninvite [id] [ïðè÷èíà]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 8 ðàíãà')
	  end
   end)
 end

 function zinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë Î.Ê",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Çàìåñòèòåëÿ Ãëàâû Î.Ê è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(2000)
	sampSendChat('/b /clist 5')
	wait(2000)
	sampSendChat('/b òåã â /r [Çàì.Ãëàâû Î.Ê]')
	wait(2000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Çàìåñòèòåëü Technical Department.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë D.D",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Çàìåñòèòåëÿ Ãëàâû Îòäåë D.D è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(2000)
	sampSendChat('/b /clist 24')
	wait(2000)
	sampSendChat('/b òåã â /r [Çàì.Ãëàâû D.D]')
	wait(2000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Çàìåñòèòåëü Inspection Department.', cfg.main.tarr))
	end
   },
 }
end
function oinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë MICC",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà(öû) Îòäåëà MISS è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(2000)
	sampSendChat('/b /clist 29')
	wait(2000)
	sampSendChat('/b òåã â /r [Employee of MICC]')
	wait(2000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  ñîòðóäíèê  Îòäåëà MICC.', cfg.main.tarr))
	end
   },

   {
   title = "{80a4bf}» {FFFFFF}Îòäåë SHI",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà(öû) Îòäåëà SHI è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(2000)
	sampSendChat('/b /clist 12')
	wait(2000)
	sampSendChat('/b òåã â /r [Ñîòðóäíèê SHI]')
	wait(2000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  Ñîòðóäíèê Îòäåëà SHI.', cfg.main.tarr))
	end
   },
 }
end
function ginvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë  Î.Ê ÃËÀÂÀ.",
    onclick = function()
	if rank == 'Çàìåñòèòåëü Ãëàâíîãî Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Ïñèõîëîã' then
	sampSendChat('/me äîñòàë(à) áåéäæèê Ãëàâû  Î.Ê è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(2000)
	sampSendChat('/b /clist 8')
	wait(2000)
	sampSendChat('/b òåã â /r [Ãëàâà Î.Ê]')
	wait(2000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ãëàâà Î.Ê ', cfg.main.tarr))
	else
	ftext('Âû íå ìîæåòå íàçíà÷èòü Ãëàâó äàííîãî îòäåëà.')
	end
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë Delivery Departament ÃËÀÂÀ.",
    onclick = function()
	if rank == 'Çàìåñòèòåëü Ãëàâíîãî Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Ïñèõîëîã' then
	sampSendChat('/me äîñòàë(à) áåéäæèê Ãëàâû  Delivery Departament è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(2000)
	sampSendChat('/b /clist 8')
	wait(2000)
	sampSendChat('/b òåã â /r [Ãëàâà D.D]')
	wait(2000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ãëàâà  Delivery Departament', cfg.main.tarr))
	else
	ftext('Âû íå ìîæåòå íàçíà÷èòü Ãëàâó äàííîãî îòäåëà.')
	end
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}ëåêöèé",
    onclick = function()
	submenus_show(fthmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ ëåêöèé")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Cîáåñåäîâàíèå",
    onclick = function()
	submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ Ñîáåñåäîâàíèÿ")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Îñíîâíîå ìåíþ",
    onclick = function()
	submenus_show(osmrmenu(id), "{9966cc}Medick Helper {0033cc}| Îñíîâíîå ìåíþ")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Äîïîëíèòåëüíî",
    onclick = function()
	submenus_show(osmrmenu1(id), "{9966cc}Medick Helper {0033cc}| Ìåä.îñìîòð")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ñåàíñ îò íàðêîçàâèñèìîñòè",
    onclick = function()
	submenus_show(osmrmenu2(id), "{9966cc}Medick Helper{0033cc}| Ñåàíñ îò íàðêîçàâèñèìîñòè")
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}ãîñ.íîâîñòåé {ff0000}(Ñò.Ñîñòàâ)",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.âðà÷' then
	submenus_show(govmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ ãîñ.íîâîñòåé")
	else
	ftext('Âû íå íàõîäèòåñü â Ñò.Ñîñòàâå')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}îòäåëîâ",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.âðà÷' or rank == 'Äîêòîð' or rank == 'Íàðêîëîã' or rank == 'Ñïàñàòåëü' or rank == 'Ìåä.áðàò' then
	submenus_show(otmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ îòäåëîâ")
	else
	ftext('Âàø ðàíã íåäîñòàòî÷íî âûñîê')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Âûçâàòü ñîòðóäíèêà ïîëèöèè â Áîëüíèöó {ffffff}â /d {ff0000}(3+ ðàíãè)",
    onclick = function()
	if rank == 'Ìåä.áðàò' or rank =='Ñïàñàòåëü' or rank =='Íàðêîëîã' or rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
	sampSendChat(string.format('/d LSPD, Âûøëèòå ñîòðóäíèêà â Áîëüíèöó. Áëàãîäàðþ!'))
	else
	ftext('Âàø ðàíã íåäîñòàòî÷íî âûñîê')
	end
	end
   },
}
end

function otmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Ïèàð îòäåëà â ðàöèþ {ff00ff}MICC{ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(3000)
    sampSendChat(string.format('/r [%s]: Â Îòäåë MICC ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(3000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Ñïàñàòåëü".', cfg.main.tarr))
    wait(3000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	end
   },
{
   title = "{80a4bf}»{FFFFFF} Ïèàð îòäåëà â ðàöèþ {0000ff}SHI{ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(3000)
    sampSendChat(string.format('/r [%s]: Â SHI ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(3000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Èíòåðí".', cfg.main.tarr))
    wait(3000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	end
   },
}
end

function sobesedmenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë ñîáåñåäîâàíèå »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Çäðàâñòâóéòå. ß ñîòðóäíèê áîëüíèöû "..myname:gsub('_', ' ')..", âû íà ñîáåñåäîâàíèå?")
		wait(2000)
		sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
		end
      },
      {
        title = '{80a4bf}» {ffffff}Äîêóìåíòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Âàø ïàñïîðò è äèïëîì,ïîæàëóéñòà.")
		wait(2000)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Çàÿâêà íà îôô.ïîðòàë íà Íàðêîëîãà{ff0000}ÅÑËÈ 8 ëåò â øòàòå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Âû ìîæåòå îñòàâèòü çàÿâëåíèå íà îôô.ïîðòàëå, íà äîëæíîñòü Íàðêîëîã, à ìîæåòå ñåé÷àñ íà èíòåðíà.")
		wait(2000)
		sampSendChat("/b evolve-rp.su -> 03 server -> ãîñ. ñëóæáû -> ìèíèñòåðñòâî çäðàâîõðàíåíèÿ -> Çàÿâëåíèå íà äîëæíîñòü íàðêîëîãà.")
		wait(2000)
		sampSendChat("Îñòàâèòå çàÿâëåíèå èëè ñåé÷àñ íà èíòåðíà?")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Çàïèñàë äàííûå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat("/me âçÿë äîêóìåíòû ó ÷åëîâåêà íàïðîòèâ")
		wait(3000)
        sampSendChat("/do Äîêóìåíòû  â ðóêàõ ðàáîòíèêà áîëüíèöû")
		wait(3000)
		sampSendChat("/me çàïèñàë äàííûå äîêóìåíòîâ â áëàíê çàÿâëåíèÿ")
        wait(3000)
        sampSendChat("/me ïåðåäàë äîêóìåíòû îáðàòíî")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ðàññêàæèòå íåìíîãî î ñåáå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat("Õîðîøî, ðàññêàæèòå íåìíîãî î ñåáå.")
		wait(3000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Îïûò â äàííîé ñôåðå.',
        onclick = function()
        sampSendChat("Èìåëè ðàíüøå îïûò â äàííîé ñôåðå?")
		wait(3000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}ÐÏ òåðìèíû.',
        onclick = function()
        sampSendChat("×òî ïî âàøåìó îçíà÷àåò òàêîâî ïîíÿòèå êàê ÐÏ è ÄÌ?")
		wait(3000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}×òî íàä ãîëîâîé.',
        onclick = function()
        sampSendChat("×òî ó ìåíÿ íàä ãîëîâîé?")
		wait(3000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}ÐÏ òåðìèíû â /b.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("/b ÐÏ è ÏÃ â /sms "..myid.."")
		wait(3000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Âû ïðèíÿòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Ïîçäðàâëÿþ, âû íàì ïîäõîäèòå.")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Âû íå ïðèíÿòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Ïðîøó ïðîùåíèÿ, íî âû íàì íå ïîäõîäèòå.")
        end
	  },
    }
end

function govmenu(id)
 return
{
   {
   title = "{80a4bf}»{FFFFFF} Íà÷àëî ñîáåñåäîâàíèÿ:",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,âåùàþ")
        wait(3000)
		sampSendChat("/me äîñòàë ÊÏÊ, ïîñëå ÷åãî ïîäêëþ÷èëñÿ ê ãîñ. âîëíå íîâîñòåé")
		wait(3000)
        sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ! ")
        wait(3000)
        sampSendChat('/gov [MOH]: Ñîîáùàþ, ÷òî ñîáåñåäîâàíèå â Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ íà äîëæíîñòü "Èíòåðí" íà÷àëîñü.')
        wait(3000)
		sampSendChat('/gov [MOH]: Òðåáîâàíèÿ: ïðîæèâàòü îò 3-õ ëåò â øòàòå è íàëè÷èå äèïëîìà î ìåä.îáðàçîâàíèè. ')
		wait(3000)
                sampSendChat('/gov [MOH]: Ïðè óñïåøíîì ïðîõîæäåíèè èíòåðíàòóðû - ïðåìèÿ 150.000$  ')
		wait(3000)
		sampSendChat('/gov [MOH]: Ñ Óâàæåíèåì, '..rank..' Áîëüíèöû ã. Los-Santos - '..myname:gsub('_', ' ')..'.')
		wait(3000)
        sampSendChat("/d OG,îñâîáîäèë ãîñ.âîëíó.")
		wait(1200)
        end
   },
    {
   title = "{80a4bf}»{FFFFFF} Ñåðåäèíà ñîáåñåäîâàíèÿ:",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,âåùàþ")
        wait(3000)
		sampSendChat("/me äîñòàë ÊÏÊ, ïîñëå ÷åãî ïîäêëþ÷èëñÿ ê ãîñ. âîëíå íîâîñòåé")
		wait(3000)
        sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ! ")
        wait(3000)
        sampSendChat('/gov [MOH]: Ñîîáùàþ, ÷òî ñîáåñåäîâàíèå â áîëüíèöó ã. Ëîñ-Ñàíòîñ ïðîäîëæàåòñÿ.')
        wait(3000)
		sampSendChat('/gov [MOH]: Òðåáîâàíèÿ: ïðîæèâàòü îò 3-õ ëåò â øòàòå è íàëè÷èå äèïëîìà î ìåä.îáðàçîâàíèè. ')
		wait(3000)
        sampSendChat('/gov [MOH]: Ïðè äîñòèæåíèè äîëæíîñòè "Ìåä.Áðàò" ñîòðóäíèê ïîëó÷èò ïðåìèþ â ðàçìåðå - 100.000$  ')
		wait(3000)
        sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, '..rank..' Áîëüíèöû ã. Los-Santos- '..myname:gsub('_', ' ')..'.')
		wait(3000)
        sampSendChat("/d OG,îñâîáîäèë ãîñ.âîëíó.")
		wait(1200)
		end
   },
     {
   title = "{80a4bf}»{FFFFFF} Êîíåö ñîáåñåäîâàíèÿ:",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG,âåùàþ")
        wait(3000)
		sampSendChat("/me äîñòàë ÊÏÊ, ïîñëå ÷åãî ïîäêëþ÷èëñÿ ê ãîñ. âîëíå íîâîñòåé")
		wait(3000)
        sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ! ")
        wait(3000)
        sampSendChat('/gov [MOH]: Ñîáåñåäîâàíèå â Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ íà äîëæíîñòü "Èíòåðí" îêîí÷åíî.')
        wait(3000)
		sampSendChat('/gov [MOH]: Ñîîáùàþ, ÷òî íà îô.ïîðòàëå ìèíèñòåðñòâà çäðàâîîõðàíåíèÿ îòêðûòû çàÿâëåíèå íà äîëæíîñòü "Íàðêîëîã" ')
		wait(3000)
        sampSendChat('/gov [MOH]: Ïðè äîñòèæåíèè äîëæíîñòè "Äîêòîð" ñîòðóäíèê ïîëó÷èò ïðåìèþ â ðàçìåðå - 250.000$  ')
		wait(3000)
        sampSendChat('/gov [MOH]:Ñ Óâàæåíèåì, '..rank..' Áîëüíèöû ãîðîäà Los-Santos - '..myname:gsub('_', ' ')..'. ')
		wait(3000)
        sampSendChat("/d OG,îñâîáîäèë ãîñ.âîëíó.")
		wait(1200)
		end
   },
}
end

function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("Âû ðàíåå íå ïîëó÷àëè âõîäÿùèõ ñîîáùåíèé.", 0x046D63)
	end
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ëå÷åíèå ïàöèåíòà",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
        wait(1500)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
        wait(1500)
        sampSendChat("/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû ïàöèåíòó")
        wait(1500)
        sampSendChat("/heal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñåàíñ",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1500)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ïðåïàðàò")
        wait(1500)
		sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
		wait(1500)
		sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
		wait(1500)
		sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
		wait(1500)
		sampSendChat("/do Øïðèö è ïðåïàðàò â ïðàâîé ðóêå.")
                wait(1500)
		sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó ïàöèåíòà")
                wait(1500)
		sampSendChat("/todo Íó âîò è âñ¸*âûòàùèâ øïðèö èç âåíû è ïðèëîæèâ âàòó ê ìåñòó óêîëà.")
                wait(1500)
		sampSendChat("/healaddict")





    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà 1",
    onclick = function()
	    sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
        wait(1500)
        sampSendChat(" Èìååòå ëè Âû æàëîáû íà çäîðîâüå?")
        wait(5000)
        sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
        wait(1500)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1500)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(1500)
        sampSendChat("Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(1500)
        sampSendChat("/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè ïàöèåíòà")
        wait(1500)
        sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
        wait(1500)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1500)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ïðàâîìó êîëåíó ïàöèåíòà")
        wait(1500)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà 2",
    onclick = function()
	    sampSendChat(" Çäåñü òîæå âñå âïîðÿäêå. Òåïåðü ïðîâåðèì Âàøó êðîâü.")
        wait(1500)
        sampSendChat("/do Íà ïîëó ñòîèò ìèíè-ëàáîðàòîðèÿ.")
        wait(1500)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1500)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(1500)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(1500)
        sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
        wait(1500)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(1500)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1500)
        sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}»{FFFFFF} Ëå÷åíèå ïàöèåíòà",
    onclick = function()
		sampSendChat(" Çäðàâñòâóéòå, ÷òî Âàñ áåñïîêîèò?")
		wait(1500)
		sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
		wait(1500)
		sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
		wait(1500)
		sampSendChat("/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû ïàöèåíòó")
		wait(1500)
		sampSendChat("/heal")
    end
  },
}
end

function osmrmenu2(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ñåàíñ.",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1500)
        sampSendChat("/me âíèìàòåëüíî îñìîòðåâ ìîòîöèêë, îñìîòðåë ñî âñåõ ñòîðîí, âïèñàë ÷òî-òî â áëîêíîò")
		wait(1500)
		sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ïðåïàðàò")
		wait(1500)
		sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
		wait(1500)
		sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
		wait(1500)
		sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
		wait(1500)
		sampSendChat("/do Øïðèö è ïðåïàðàò â ïðàâîé ðóêå.")
		wait(1500)
		sampSendChat("/me íàáðàë â øïðèö ïðåïàðàò")
		wait(1500)
		sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó ïàöèåíòà")
		wait(1500)
		sampSendChat("/healaddict")
    end
  },
}
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ëå÷åíèå ïàöèåíòà",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
            wait(1500)
            sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
            wait(1500)
           sampSendChat("/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû ïàöèåíòó")
           wait(1500)
           sampSendChat("/heal") 
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà 1",
    onclick = function()
	     sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
        wait(1500)
        sampSendChat(" Èìååòå ëè Âû æàëîáû íà çäîðîâüå?")
        wait(5000)
        sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
        wait(1500)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1500)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(1500)
        sampSendChat("Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(1500)
        sampSendChat("/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè ïàöèåíòà")
        wait(1500)
        sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
        wait(1500)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1500)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ïðàâîìó êîëåíó ïàöèåíòà")
        wait(1500)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà 2",
    onclick = function()
	    sampSendChat(" Çäåñü òîæå âñå âïîðÿäêå. Òåïåðü ïðîâåðèì Âàøó êðîâü.")
        wait(1500)
        sampSendChat("/do Íà ïîëó ñòîèò ìèíè-ëàáîðàòîðèÿ.")
        wait(1500)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1500)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(1500)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(1500)
        sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
        wait(1500)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(1500)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(1500)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1500)
        sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Çàïîëíåíèå ñïðàâêè",
    onclick = function()
	    sampSendChat("/do Øêàô÷èê îòêðûò.")
        wait(1500)
        sampSendChat("/do Â øêàô÷èêå ñòîÿò áëàíêè ñïðàâîê.")
        wait(1500)
        sampSendChat("/me äîñòàë èç øêàô÷èêà áëàíê ñïðàâêè")
        wait(1500)
        sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò íå èìååò íàðêîçàâèñèìîñòè è ãîäåí ê ñëóæáå")
        wait(1500)
        sampSendChat("/me ïåðåäàë ñïðàâêó ïàöèåíòó â ðóêè")
        wait(1500)
        sampSendChat("/do Ïðîòÿíóòà ïðàâàÿ ðóêà ñî ñïðàâêîé.")
        wait(1500)
		sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}»{FFFFFF} Äåëàåì ñåàíñ,åñëè îí çàâèñèì",
    onclick = function()
		sampSendChat("/do Íà ýêðàíå ïîêàçàí ïîëîæèòåëüíûé ðåçóëüòàò òåñòà êðîâè ïàöèåíòà.")
		wait(1500)
		sampSendChat("/me äîñòàë èç øêàô÷èêà áëàíê ñïðàâêè.")
		wait(1500)
		sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò âûëå÷åí ãîäåí ê ñëóæáå.")
		wait(1500)
		sampSendChat("/healaddict")
    end
  },
}
end

function remont(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Îòêðûâàåì ìåøîê ñ ïåñêîì",
    onclick = function()
	    sampSendChat("/do Íà ïîëó ìåøîê ñ ïåñêîì.")
        wait(10000)
        sampSendChat("/me îòêðûë ìåøîê ñ ïåñêîì")
		wait(10000)
		sampSendChat("/do Ìåøîê ñ ïåñêîì îòêðûò.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Áåðåì ëîïàòó",
    onclick = function()
	    sampSendChat("/do Îêîëî ìåøêà ëåæèò ëîïàòà, ìàñòåðîê è âåäðî. ")
        wait(10000)
        sampSendChat("/me âçÿë ëîïàòó, ìàñòåðîê è âåäðî")
		wait(10000)
		sampSendChat("/me ïîñòàâèë âåäðî ïåðåä ìåøêîì")
		wait(10000)
		sampSendChat("/do Âåäðî ïåðåä ìåøêîì.")
		wait(10000)
		sampSendChat("/do Ïðîöåññ..")
		wait(10000)
		sampSendChat("/me çàêîí÷èë íàêëàäûâàòü ïåñîê â âåäðî")
		wait(10000)
		sampSendChat("/do Âåäðî ïîëíîå.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Èäåì ê ÿìå",
    onclick = function()
	    sampSendChat("/me ïîäíÿë âåäðî è ïîøåë ê ÿìå")
        wait(10000)
        sampSendChat("/do Â àñôàëüòå ãëóáîêàÿ ÿìà.")
		wait(10000)
		sampSendChat("/me âûñûïàë ïåñîê â ÿìó")
		wait(10000)
		sampSendChat("/do Ïåñîê â ÿìå.")
		wait(10000)
		sampSendChat("/me óáðàë âåäðî è äîñòàë ìàñòåðîê")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ìàñòåðîê â ðóêå.",
    onclick = function()
	    sampSendChat("/do Ìàñòåðîê â ðóêå.")
        wait(10000)
        sampSendChat("/me ðàçðàâíèâàåò ïåñîê ìàñòåðêîì")
		wait(10000)
		sampSendChat("/do Ïðîöåññ.")
		wait(10000)
		sampSendChat("/me çàêîí÷èë ðàâíÿòü ïåñîê")
		wait(10000)
		sampSendChat("/do Ïåñîê ëåæèò ðîâíî")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Âîçâðàùàåòåñü â ìåñòî ãäå áðàëè ïåñîê è ïðîäîëæàåòå îòûãðûâàòü ÐÏ",
    onclick = function()
	    sampSendChat("/do Íà ïîëó ëåæèò àñôàëüò.")
        wait(10000)
        sampSendChat("/me ëîïàòîé íàêëàäûâàåò àñôàëüò â âåäðî")
		wait(10000)
		sampSendChat("/do Ïðîöåññ.")
		wait(10000)
		sampSendChat("/me çàêîí÷èë íàêëàäûâàòü àñôàëüò â âåäðî")
		wait(10000)
		sampSendChat("/do Âåäðî ïîëíîñòüþ çàáèòî àñôàëüòîì.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Âîçâðàùàåòåñü ê ìåñòó êóäà âûñûïàëè ïåñîê è ïðîäîëæàåòå îòûãðûâàòü ÐÏ",
    onclick = function()
	    sampSendChat("/me ïîñòàâèë âåäðî îêîëî ÿìû ")
        wait(10000)
        sampSendChat("/do Âåäðî îêîëî ÿìû")
		wait(10000)
		sampSendChat("/me ëîïàòîé âûêëàäûâàåò àñôàëüò íà ïåñîê")
		wait(10000)
		sampSendChat("/do Ïðîöåññ..")
		wait(10000)
		sampSendChat("/me âûëîæèë àñôàëüò íà ïåñîê")
		wait(10000)
		sampSendChat("/do Àñôàëüò ëåæèò íà ïåñêå.")
		wait(10000)
		sampSendChat("/me äîñòàë ìàñòåðîê è íà÷àë ðàçðàâíèâàòü àñôàëüò")
		wait(10000)
		sampSendChat("/me ðàçðàâíÿë ìàñòåðêîì àñôàëüò")
		wait(10000)
		sampSendChat("/do Çàëàòàë ÿìó")
    end
  },
}
end

function osmrmenu1(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ìåä.îñìîòð íà ïðèçûâå",
    onclick = function()
	    sampSendChat("- Õîðîøî. Ñåé÷àñ ìû ïðîâåðèì Âàñ íà íàëè÷èå íàðêîçàâèñèìîñòè.")
        wait(1300)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1300)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó")
        wait(1300)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(1300)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(1300)
         sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
        wait(1300)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(1300)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(1300)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(1300)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(1300)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Èññëåäîâàíèå óðîâíÿ ãëþêîçû â êðîâè",
    onclick = function()
		sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì ")
		wait(1300)
		sampSendChat("/me äîñòàë èç ÿùèêà ìåä.êàðòó íà èìÿ ïàöèåíòà.")
		wait(1300)
		sampSendChat(" Èìååòå ëè Âû æàëîáû íà çäîðîâüå?")
		wait(2500)
		sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
		wait(1300)
		sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
		wait(1300)
		sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
		wait(1300)
		sampSendChat(" Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
		wait(3000)
		sampSendChat("/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè ïàöèåíòà")
		wait(1300)
		sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
		wait(1300)
		sampSendChat(" Õîðîøî. Ðåôëåêñû çðåíèÿ â íîðìå.")
		wait(1300)
		sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
		wait(1300)
		sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó ïàöèåíòà")
		wait(1300)
		sampSendChat(" Çäåñü òîæå âñå âïîðÿäêå. Ïðîâåðèì Âàøó êðîâü.")
		wait(1300)
		sampSendChat("Èññëåäóåì âàø óðîâåíü ãëþêîçû â êðîâè")
		wait(1300)
		sampSendChat("/me äîñòàë èç ìåä. ñóìêè è íàäåë ñòåðèëüíûå ïåð÷àòêè")
		wait(1300)
		sampSendChat("/do Ïåð÷àòêè íàäåòû.")
        wait(1300)
        sampSendChat("/me âçÿë ñêàðèôèêàòîð ñî ñòîëà è ïðîêîëîë ïàëåö ïàöèåíòà")
		wait(1300)
		sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1300)
		sampSendChat("/me âçÿë ïðîáèðêó ñî ñòîëà è íàáðàë â íå¸ êðîâü èç ïàëüöà, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
		wait(1300)
		sampSendChat("/do Íà ýêðàíå ïîêàçàí ðåçóëüòàò òåñòà êðîâè: 4,5 ììîëü/ë")
		wait(1300)
		sampSendChat("/checkheal")
    end
  },
}
end

function fthmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ëåêöèÿ äëÿ {139BEC}Èíòåðíà",
    onclick = function()
	    sampSendChat("Ïðèâåòñòâóþ Âàñ â Ìèíèñòåðñòâå Çäðàâîîõðàíåíèÿ ")
        wait(2000)
        sampSendChat(" Ïîïàäàÿ â MOH, âû àâòîìàòè÷åñêè îïðåäåëÿåòåñü â îòäåë MA.  ")
        wait(4000)
        sampSendChat("Çàäà÷à-îêàçàíèå âðà÷åáíîé ïîìîùè ïàöèåíòàì, ðàáîòà íà ïîñòàõ è ïàòðóëÿõ.  ")
        wait(2000)
        sampSendChat("Âî âðåìÿ íàõîæäåíèè íà ðàáîòå íîñèì ñâîè áåéäæèêè.  ")
        wait(2000)
        sampSendChat("/b /clist 13  ")
        wait(2000)
        sampSendChat("Âàì âûäàëè ðàöèþ, êîòîðóþ âû äîëæíû íàñòðîèòü íà âîëíó ÌÇ.  ")
        wait(2000)
        sampSendChat("/b /r [MA] - âàø ÒÝÃ. Äîêëàäû î ïðîäåëàííîé ðàáîòå äåëàþòñÿ ïî çàïðîñó â ðàöèþ. ")
        wait(2000)
        sampSendChat("Îñíîâíàÿ ñóòü: Âû áåðåòå êàðåòó ñêîðîé ïîìîùè è âûåçæàåòå íà ïîñò.  ")
         wait(2000)
        sampSendChat("Ïîñòû ñëåäóþùèå: Ðàáîòà ãðóç÷èêîâ, ìîñò ÑÔ-ËÑ ")
        wait(2000)
        sampSendChat("Êàæäîå Âàøå äåéñòâèå äîëæíî ñîïðîâîæäàòüñÿ äîêëàäîì â ðàöèþ.  ")
         wait(2000)
        sampSendChat("Âû äîëæíû ñîîáùàòü â ðàöèþ î âûåçäå íà ïîñò. ")
        wait(2000)
        sampSendChat("Î ñâîåì ìåñòîíàõîæäåíèè è îá ïðåêðàùåíèè äåæóðñòâà íà ïîñòó. ")
        wait(2000)
        sampSendChat("Ïðè âûåçäå íà íàçåìíûé ïàòðóëü Âû ìîæåòå âçÿòü ñ ñîáîé îäíîãî íàïàðíèêà.  ")
        wait(2000)
        sampSendChat('Âûåçæàÿ â íàçåìíûé ïàòðóëü Âû îáÿçàíû ïðèíèìàòü âñå âõîäÿùèå âûçîâû. ')
        wait(2000)
        sampSendChat("×òî êàñàòåëüíî äåæóðñòâà íà ðåãèñòðàòóðå. ")
        wait(2000)
        sampSendChat("Ëå÷åíèå â Ìèíèñòåðñòâå ïðîèçâîäèòñÿ òîëüêî ñåðòèôèöèðîâàííûìè ïðåïàðàòàìè. ")
        wait(2000)
        sampSendChat("/b çà ëå÷åíèå áåç ÐÏ îòûãðîâêè - âûãîâîð èëè óâîëüíåíèå. ")
        wait(2000)
        sampSendChat("Òàê æå ìû, î÷åâèäíî, íå ëå÷èì âèòàìèíêàìè è ãåìîòîãåíîì. ")
        wait(2000)
        sampSendChat("Ñî ñïèñêîì ïðåïàðàòîâ îçíàêîìüòåñü íà îôô. ïîðòàëå Ìèí.Çäðàâà ")
        wait(2000)
        sampSendChat("Ïðîâîäèòü ñåàíñû îò íàðêîçàâèñèìîñòè, ðàçðåøåíî ñ äîëæíîñòè íàðêîëîãà. ")
        wait(2000)
        sampSendChat("Íåëüçÿ íîñèòü ñ ñîáîé çàïðåù¸ííûå çàêîíîäàòåëüñòâîì ïðåäìåòû. ")
        wait(2000)
        sampSendChat("Ãðàôèê ðàáîòû ïî áóäíÿì: 09:00-21:00, âûõîäíûå äî 20:00. ")
        wait(2000)
        sampSendChat("Îáåäåííûé ïåðåðûâ êàæäûé äåíü ñ 14:00 äî 15:00. ")
        wait(2000)
        sampSendChat("/b Êîãäà Âû çàøëè â èãðó, ó Âàñ åñòü 15 ìèíóò, ÷òîáû äîáðàòüñÿ äî ðàáîòû. ")
        wait(2000)
        sampSendChat("Òåïåðü î ñèñòåìå ïîâûøåíèé. Ïîäðîáíî âû ìîæåòå óçíàòü íà îô.ïîðòàëå Ìèí.Çäðàâà.")
        wait(2000)
        sampSendChat("Íà ýêçàìåíå ó Âàñ ïðîâåðÿåòñÿ çíàíèå óñòàâà è ïðàêòèêà. ")
        wait(2000)
        sampSendChat("Íà ýòîì ëåêöèÿ çàêîí÷åíà ")
        wait(2000)
        sampSendChat("Åñëè ó âàñ èìåþòñÿ âîïðîñû, çàäàâàéòå. ")
		wait(1500)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = "{80a4bf}»{FFFFFF} Ëåêöèÿ äëÿ {139BEC}Íàðêîëîãà",
    onclick = function()
	sampSendChat("Ïðèâåòñòâóþ Âàñ â Ìèíèñòåðñòâå Çäðàâîîõðàíåíèÿ.")
        wait(2000)
        sampSendChat("Ïîïàäàÿ â MOH, âû àâòîìàòè÷åñêè îïðåäåëÿåòåñü â îòäåë MICC. ")
        wait(2000)
        sampSendChat('Íî íà ñòàäèè ïåðâè÷íîé ëåêöèè ìîæåòå âûáðàòü îäèí èç îòäåëîâ ')
        wait(2000)
        sampSendChat('À èìåííî MICC, î ðàáîòå èõ Âû ïîçíàêîìèòåñü íà îô ïîðòàëå. ')
        wait(2000)
        sampSendChat('Çàäà÷à-îêàçàíèå âðà÷åáíîé ïîìîùè ïàöèåíòàì, ðàáîòà íà ïîñòàõ è ïàòðóëÿõ. ')
        wait(2000)
        sampSendChat("Âî âðåìÿ íàõîæäåíèè íà ðàáîòå íîñèì ñâîé áåéäæèêè 21. ")
        wait(2000)
        sampSendChat("/b /clist 21 - âàø áåéäæèê, áåéäæèêè íàäåâàåì ñòðîãî ïî ÐÏ! Âàì âûäàëè ðàöèþ, êîòîðóþ âû äîëæíû íàñòðîèòü íà âîëíó ÌÇ.")
        wait(2000)
        sampSendChat("/b /r [MICC] - âàø ÒÝÃ. ")
        wait(2000)
        sampSendChat("Äîêëàäû î ïðîäåëàííîé ðàáîòå äåëàþòñÿ ïî çàïðîñó â ðàöèþ. ")
        wait(2000)
        sampSendChat("Îñíîâíàÿ ñóòü: Âû áåðåòå êàðåòó ñêîðîé ïîìîùè è âûåçæàåòå íà ïîñò. ")
        wait(2000)
        sampSendChat("Ïîñòû ñëåäóþùèå: Ðàáîòà ãðóç÷èêîâ, ìîñò ÑÔ-ËÑ, Ïåðåêð¸ñòîê ËÂ-ËÑ è ò.ä ")
        wait(2000)
        sampSendChat("Êàæäîå Âàøå äåéñòâèå äîëæíî ñîïðîâîæäàòüñÿ äîêëàäîì â ðàöèþ. ")
        wait(2000)
        sampSendChat("Âû äîëæíû ñîîáùàòü â ðàöèþ î âûåçäå íà ïîñò.")
        wait(2000)
        sampSendChat("/b î ñâîåì ìåñòîíàõîæäåíèè è îá ïðåêðàùåíèè äåæóðñòâà íà ïîñòó. ")
        wait(2000)
        sampSendChat("/b Äåæóðèòü íà Ðåãèñòðàòóðå ðàçðåøåíî äâóì íàðêîëîãàì îäíîâðåìåííî. ")
        wait(2000)
        sampSendChat("Ðàáîòàþùèå Ðåãèñòðàòóðû - Áîëüíèöà ËÑ. ")
        wait(2000)
        sampSendChat("Ðàáîòàÿ â Ìèíèñòåðñòâå, âû ìîæåòå ïîëüçîâàòüñÿ ìåäèöèíñêèìè êàðåòàìè. ")
        wait(2000)
        sampSendChat("Òàê æå ìîæåòå ïîëüçîâàòüñÿ àâòîìîáèëÿìè ìàðêè - Ñòðàòóì.Ñïåöèàëèçèðîâàííûìè âåðòîë¸òàìè ìîæíî ïîëüçîâàòüñÿ ñ äîëæíîñòè Ïñèõîëîã.  ")
        wait(2000)
        sampSendChat("Ëå÷åíèå â Ìèíèñòåðñòâå ïðîèçâîäèòñÿ òîëüêî ñåðòèôèöèðîâàííûìè ïðåïàðàòàìè.  ")
        wait(2000)
        sampSendChat("/b çà ëå÷åíèå áåç ÐÏ îòûãðîâêè - âûãîâîð èëè óâîëüíåíèå.  ")
        wait(2000)
        sampSendChat("Ñî ñïèñêîì ïðåïàðàòîâ îçíàêîìüòåñü íà îôô. ïîðòàëå Ìèí.Çäðàâà  ")
        wait(2000)
        sampSendChat("Áóäó÷è íàðêîëîãîì, Âû ìîæåòå ïðîâîäèòü ñåàíñû îò íàðêîçàâèñèìîñòè   ")
        wait(2000)
        sampSendChat("È ïðîâîäèòü ïðîâåðêè ãðàæäàí íà ãîäíîñòü ñëóæáû, à òàê æå âûïèñûâàòü ñïðàâêè.   ")
        wait(2000)
        sampSendChat("Îáðàùåíèÿ ê êîëëåãàì èä¸ò ïî ôîðìå - Äîêòîð Ôàìèëèÿ.    ")
        wait(2000)
        sampSendChat("Íåëüçÿ íîñèòü ñ ñîáîé çàïðåù¸ííûå çàêîíîäàòåëüñòâîì ïðåäìåòû.    ")
        wait(2000)
        sampSendChat("Ãðàôèê ðàáîòû ïî áóäíÿì: 09:00-21:00, âûõîäíûå äî 20:00.   ")
        wait(2000)
        sampSendChat("Îáåäåííûé ïåðåðûâ êàæäûé äåíü ñ 14:00 äî 15:00.    ")
        wait(2000)
        sampSendChat("/b Êîãäà Âû çàøëè â èãðó, ó Âàñ åñòü 15 ìèíóò, ÷òîáû äîáðàòüñÿ äî ðàáîòû.   ")
        wait(2000)
        sampSendChat("Òåïåðü î ñèñòåìå ïîâûøåíèé. Ïîäðîáíî âû ìîæåòå óçíàòü íà îô.ïîðòàëå Ìèí.Çäðàâà.    ")
        wait(2000)
        sampSendChat("Íà ýêçàìåíå ó Âàñ ïðîâåðÿåòñÿ çíàíèå óñòàâà è ïðàêòèêà.     ")
        wait(2000)
        sampSendChat("Íà ýòîì ëåêöèÿ çàêîí÷åíà. Âû ìîæåòå çàäàòü ñâîè âîïðîñû.    ")
		wait(2000)
		if cfg.main.hud then
        sampSendChat("/time")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   }
}
end

do

function imgui.OnDrawFrame()
   if first_window.v then
	local tagfr = imgui.ImBuffer(u8(cfg.main.tarr), 256)
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local hudik = imgui.ImBool(cfg.main.givra)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(u8'Íàñòðîéêè##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Èñïîëüçîâàòü àâòîòåã"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîòåã', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Ââåäèòå âàø Òåã.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	imgui.Text(u8("Èíôî-áàð ïðîäàæ ëèöåíçèé"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Âêëþ÷èòü/Âûêëþ÷èòü èíôî-áàð', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Èíôî-áàð âêëþ÷åí, óñòàíîâèòü ïîëîæåíèå /sethud' or 'Èíôî-áàð âûêëþ÷åí')
    end
	end
	imgui.Text(u8("Áûñòðûé îòâåò íà ïîñëåäíåå ñìñ"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Áûñòðûé îòâåò ñìñ', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Êëàâèøà óñïåøíî èçìåíåíà. Ñòàðîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Íîâîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/instools/keys.json')
	end
	imgui.Text(u8("Èñïîëüçîâàòü àâòîêëèñò"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîêëèñò', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Âûáåðèòå çíà÷åíèå êëèñòà", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Ìóæñêèå îòûãðîâêè"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Ìóæñêèå îòûãðîâêè', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'Çàäåðæêà â ëåêöèÿõ è îòûãðîâêàõ(ñåê)', waitbuffer, 5, 40) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Àâòîñêðèí ëåêöèé/ãîñ.íîâîñòåé"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Àâòîñêðèí ëåêöèé', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Ñîõðàíèòü íàñòðîéêè'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Íàñòðîéêè óñïåøíî ñîõðàíåíû.', -1)
    inicfg.save(cfg, 'instools/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medick Tools | Óñòàâ Áîëüíèöû'), ystwindow)
                for line in io.lines('moonloader\\instools\\ystav.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local iScreenWidth, iScreenHeight = getScreenResolution()
    local btn_size1 = imgui.ImVec2(70, 0)
	local btn_size = imgui.ImVec2(130, 0)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 5))
    imgui.Begin('Medick Helpers | Main Menu | Version: '..thisScript().version, second_window, mainw,  imgui.WindowFlags.NoResize)
	local text = 'Ðàçðàáîòàëè:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Makar_Sheludkov, Doni_Baerra')
    imgui.Separator()
	if imgui.Button(u8'Áèíäåð', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(u8'Íàñòðîéêè ñêðèïòà', imgui.ImVec2(120, 30)) then
      first_window.v = not first_window.v
    end
    imgui.SameLine()
    if imgui.Button(u8 'Ñîîáùèòü îá îøèáêå/áàãå', imgui.ImVec2(165, 30)) then os.execute('explorer "https://vk.com/mark_kaufmann"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(u8'Ïåðåçàãðóçèòü ñêðèïò', imgui.ImVec2(140, 30)) then
      showCursor(false)
      thisScript():reload()
    end
    if imgui.Button(u8 'Îòêëþ÷èòü ñêðèïò', imgui.ImVec2(120, 30), btn_size) then
      showCursor(false)
      thisScript():unload()
    end
	imgui.SameLine()
    if imgui.Button(u8'Ïîìîùü', imgui.ImVec2(55, 30)) then
      helps.v = not helps.v
    end
	imgui.SameLine()
    if imgui.Button(u8 'Îñòàíîâèòü ëåêöèþ', imgui.ImVec2(125, 30)) then
	showCursor(false)
	thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(u8 'Ñèñòåìà ïîâûøåíèé', imgui.ImVec2(135, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-sistema-povyshenija-upd-14-03-20.133094/-Ñèñòåìà-ïîâûøåíèÿ-ñîòðóäíèêîâ-Áîëüíèöû.71029/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(u8 'Óñòàâ', imgui.ImVec2(50, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-ustav-ministerstva-i-sistema-nakazanij.132703/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(u8 'Ïîìîùü äëÿ íîâè÷êîâ [FAQ]', imgui.ImVec2(175, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-f-a-q-informacija-dlja-novichkov.111667//"')
    btn_size = not btn_size
    end
	imgui.Separator()
	imgui.BeginChild("Èíôîðìàöèÿ", imgui.ImVec2(410, 150), true)
	imgui.Text(u8 'Èìÿ è Ôàìèëèÿ:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Äîëæíîñòü:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Íîìåð òåëåôîíà:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Òåã â ðàöèþ:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Íîìåð áåéäæèêà:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Òåêóùàÿ äàòà: %s")).x)/1.5)
	imgui.Text(u8(string.format("Òåêóùàÿ äàòà: %s", os.date())))
    imgui.End()
  end
  	if infbar.v then
                _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
                local myping = sampGetPlayerPing(myid)
                imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 200), imgui.Cond.FirstUseEver)
                imgui.Begin('Inst Tools', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
                imgui.CentrText('Inst Tools')
                imgui.Separator()
                imgui.Text((u8"Èíôîðìàöèÿ: %s [%s] | Ïèíã: %s"):format(myname, myid, myping))
                imgui.End()
    end
    if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(u8 'Ïîìîùü ïî ñêðèïòó', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Ñïèñîê êîìàíä", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/ih - Îòêðûòü ìåíþ ñêðèïòà')
                imgui.Separator()
				imgui.BulletText(u8 '/z [id] - Âûëå÷èòü ïàöèåíòà â àâòî')
				imgui.BulletText(u8 '/vig [id] [Ïðè÷èíà] - Âûäàòü âûãîâîð ïî ðàöèè')
				imgui.BulletText(u8 '/ivig [id] [Ïðè÷èíà] - Âûäàòü ñòðîãèé âûãîâîð ïî ðàöèè')
				imgui.BulletText(u8 '/unvig [id] [Ïðè÷èíà] - Ñíÿòü âûãîâîð ïî ðàöèè')
                imgui.BulletText(u8 '/dmb - Îòêðûòü /members â äèàëîãå')
				imgui.BulletText(u8 '/blg [id] [Ôðàêöèÿ] [Ïðè÷èíà] - Âûðàçèòü èãðîêó áëàãîäàðíîñòü â /d')
				imgui.BulletText(u8 '/oinv[id] - Ïðèíÿòü ÷åëîâåêà â îòäåë')
				imgui.BulletText(u8 '/zinv[id] - Íàçíà÷èòü ÷åëîâåêà Çàìåñòèòåëåì îòäåëà')
				imgui.BulletText(u8 '/ginv[id] - Íàçíà÷èòü ÷åëîâåêà Ãëàâîé îòäåëà')
                imgui.BulletText(u8 '/where [id] - Çàïðîñèòü ìåñòîïîëîæåíèå ïî ðàöèè')
                imgui.BulletText(u8 '/yst - Îòêðûòü óñòàâ Áîëüíèöû')
				imgui.BulletText(u8 '/smsjob - Âûçâàòü íà ðàáîòó âåñü ìë.ñîñòàâ ïî ñìñ')
                imgui.BulletText(u8 '/dlog - Îòêðûòü ëîã 25 ïîñëåäíèõ ñîîáùåíèé â äåïàðòàìåíò')
				imgui.BulletText(u8 '/sethud - Óñòàíîâèòü ïîçèöèþ èíôî-áàðà')
				imgui.Separator()
                imgui.BulletText(u8 'Êëàâèøè: ')
                imgui.BulletText(u8 'ÏÊÌ+Z íà èãðîêà - Ìåíþ âçàèìîäåéñòâèÿ')
                imgui.BulletText(u8 'F3 - "Áûñòðîå ìåíþ"')
				imgui.EndChild()
                imgui.End()
    end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}

   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("Medick Help | Áèíäåð##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	imgui.BeginChild("##bindlist", imgui.ImVec2(795, 442))
	for k, v in ipairs(tBindList) do
		if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
			if not rkeys.isHotKeyDefined(v.v) then
				if rkeys.isHotKeyDefined(tLastKeys.v) then
					rkeys.unRegisterHotKey(tLastKeys.v)
				end
				rkeys.registerHotKey(v.v, true, onHotKey)
			end
		end
		imgui.SameLine()
		if tEditData.id ~= k then
			local sText = v.text:gsub("%[enter%]$", "")
			imgui.BeginChild("##cliclzone" .. k, imgui.ImVec2(500, 21))
			imgui.AlignTextToFramePadding()
			if sText:len() > 0 then
				imgui.Text(u8(sText))
			else
				imgui.TextDisabled(u8("Ïóñòîå ñîîáùåíèå ..."))
			end
			imgui.EndChild()
			if imgui.IsItemClicked() then
				sInputEdit.v = sText:len() > 0 and u8(sText) or ""
				bIsEnterEdit.v = string.match(v.text, "(.)%[enter%]$") ~= nil
				tEditData.id = k
				tEditData.inputActve = true
			end
		else
			imgui.PushAllowKeyboardFocus(false)
			imgui.PushItemWidth(500)
			local save = imgui.InputText("##Edit" .. k, sInputEdit, imgui.InputTextFlags.EnterReturnsTrue)
			imgui.PopItemWidth()
			imgui.PopAllowKeyboardFocus()
			imgui.SameLine()
			imgui.Checkbox(u8("Ââîä") .. "##editCH" .. k, bIsEnterEdit)
			if save then
				tBindList[tEditData.id].text = u8:decode(sInputEdit.v) .. (bIsEnterEdit.v and "[enter]" or "")
				tEditData.id = -1
			end
			if tEditData.inputActve then
				tEditData.inputActve = false
				imgui.SetKeyboardFocusHere(-1)
			end
		end
	end
	imgui.EndChild()

	imgui.Separator()

	if imgui.Button(u8"Äîáàâèòü êëàâèøó") then
		tBindList[#tBindList + 1] = {text = "", v = {}}
	end

   imgui.End()
  end
  end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if tostring(v.text):len() > 0 then
				local bIsEnter = string.match(v.text, "(.)%[enter%]$") ~= nil
				if bIsEnter then
					sampProcessChatInput(v.text:gsub("%[enter%]$", ""))
				else
					sampSetChatInputText(v.text)
					sampSetChatInputEnabled(true)
				end
			end
		end
	end
end

function showHelp(param) -- "âîïðîñèê" äëÿ ñêðèïòà
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onScriptTerminate(scr)
	if scr == script.this then
		if doesFileExist(fileb) then
			os.remove(fileb)
		end
		local f = io.open(fileb, "w")
		if f then
			f:write(encodeJson(tBindList))
			f:close()
		end
		local fa = io.open("moonloader/config/instools/keys.json", "w")
        if fa then
            fa:write(encodeJson(config_keys))
            fa:close()
        end
	end
end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
	if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
		if tEditData.id > -1 then
			if wparam == key.VK_ESCAPE then
				tEditData.id = -1
				consumeWindowMessage(true, true)
			elseif wparam == key.VK_TAB then
				bIsEnterEdit.v = not bIsEnterEdit.v
				consumeWindowMessage(true, true)
			end
		end
	end
end)

function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '»', close_button or 'x', back_button or '«'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' »' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

function r(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/r [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/r %s', pam))
        end
    else
        ftext('Ââåäèòå /r [òåêñò]')
    end
end
function f(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/f [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/f %s', pam))
        end
    else
        ftext('Ââåäèòå /f [òåêñò]')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function ih()
  second_window.v = not second_window.v
end

function tloadtk()
    if tload == true then
     sampSendChat('/tload'..u8(cfg.main.norma))
    else if tload == false then
     sampSendChat("/tunload")
    end
  end
end
function imgui.CentrText(text)
            local width = imgui.GetWindowWidth()
            local calc = imgui.CalcTextSize(text)
            imgui.SetCursorPosX( width / 2 - calc.x / 2 )
            imgui.Text(text)
        end
        function imgui.CustomButton(name, color, colorHovered, colorActive, size)
            local clr = imgui.Col
            imgui.PushStyleColor(clr.Button, color)
            imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
            imgui.PushStyleColor(clr.ButtonActive, colorActive)
            if not size then size = imgui.ImVec2(0, 0) end
            local result = imgui.Button(name, size)
            imgui.PopStyleColor(3)
            return result
        end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{80a4bf}»{ffffff} Ìåíþ Âðà÷à",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{80a4bf}» {ffffff}Ðàçäåë Ëå÷åíèÿ",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Ïðèçûâ ìåíþ",
        onclick = function()
        pID = tonumber(args)
        submenus_show(priziv(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      }
    }
end
function saveData(table, path)
	if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end
function ystf()
    if not doesFileExist('moonloader/instools/ystav.txt') then
        local file = io.open("moonloader/instools/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function instmenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë Âðà÷à »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Çäðàâñòâóéòå. ß ñîòðóäíèê áîëüíèöû "..myname:gsub('_', ' ')..", ÷åì ìîãó ïîìî÷ü?")
		end
      },
      {
        title = '{80a4bf}» {ffffff}Ïàñïîðò',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Âàø ïàñïîðò, ïîæàëóéñòà.")
		wait(5000)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïîïðîùàòüñÿ ñ êëèåíòîì',
        onclick = function()
        sampSendChat("Âñåãî âàì äîáðîãî.")
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/instools/ystav.txt') then
        local file = io.open("moonloader/instools/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function oformenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë Ëå÷åíèÿ »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ëå÷åíèå.',
        onclick = function()
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
		  wait(1500)
          sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
          wait(1500)
		  sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1100)
		  sampSendChat("/heal "..id)
		  end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñïðàâêà',
        onclick = function()
		sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
        wait(1500)
        sampSendChat(" Èìååòå ëè Âû æàëîáû íà çäîðîâüå?")
        wait(5000)
        sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
        wait(1500)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1500)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(1500)
        sampSendChat("Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(1500)
        sampSendChat('/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1500)
        sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
        wait(1500)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(1500)
        sampSendChat('/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1500)
        sampSendChat('/me óäàðèë ìîëîòî÷êîì ïî ïðàâîìó êîëåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1500)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ëå÷åíèå îò íàðêîçàâèñèìîñòè',
        onclick = function()
		sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1500)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ïðåïàðàò")
        wait(1500)
		sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
		wait(1500)
		sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
		wait(1500)
		sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		wait(1500)
		sampSendChat("/do Øïðèö è ïðåïàðàò â ïðàâîé ðóêå.")
        wait(1500)
		sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1500)
		sampSendChat("/todo Íó âîò è âñ¸*âûòàùèâ øïðèö èç âåíû è ïðèëîæèâ âàòó ê ìåñòó óêîëà.")
        wait(1500)
        sampSendChat("/healaddict")
		end
      }
    }
end
function priziv(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Ïàñïîðò',
        onclick = function()
		sampSendChat("Äîáðûé äåíü, âàø ïàñïîðò ïîæàëóéñòà")
        wait(1300)
		sampSendChat("/me ïðîòÿíóë ëåâóþ ðóêó è âçÿë ïàñïîðò ó ÷åëîâåêà íà ïðîòèâ.")
        wait(1300)
		sampSendChat("/do Ïàñïîðò â ëåâîé ðóêå.")
        wait(1300)
		sampSendChat("/me îòêðûë ïàñïîðò íà íóæíîé ñòðàíèöå è çàïîìíèë äàííûå ÷åëîâåêà.")
        wait(1300)
		sampSendChat("/me çàêðûë ïàñïîðò.")
        wait(1300)
		sampSendChat("/do Ïàñïîðò çàêðûò.")
        wait(1300)
		sampSendChat("/me âåðíóë ïàñïîðò ÷åëîâåêó íà ïðîòèâ.")
        wait(1300)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà íà ïðèçûâå',
        onclick = function()
		sampSendChat("- Õîðîøî. Ñåé÷àñ ìû ïðîâåðèì Âàñ íà íàëè÷èå íàðêîçàâèñèìîñòè.")
        wait(1300)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(1300)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó")
        wait(1300)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(1300)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(1300)
        sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1300)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(1300)
        sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1300)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(1300)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(1300)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Ãîäåí',
        onclick = function()
		sampSendChat('/do Íà ýêðàíå ïîêàçàí îòðèöàòåëüíûé ðåçóëüòàò òåñòà êðîâè'..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1500)
        sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò íå èìååò íàðêîçàâèñèìîñòè è ãîäåí ê ñëóæáå.")
        wait(1500)
		sampSendChat("/me ïåðåäàë ñïðàâêó ïàöèåíòó â ðóêè")
		wait(1500)
		sampSendChat("/do Ïðîòÿíóòà ïðàâàÿ ðóêà ñî ñïðàâêîé.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Íå Ãîäåí',
        onclick = function()
		sampSendChat('/do Íà ýêðàíå ïîêàçàí ïîëîæèòåëüíûé ðåçóëüòàò òåñòà êðîâè'..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(1500)
        sampSendChat("Âû èìååòå íàðêîçàâèñèìîñòü.Ïðîéäèòå ñåàíñ îò çàâèñèìîñòè ó íàðêîëîãà.")
        wait(1500)
		sampSendChat("/me ïîñòàâèë ïå÷àòü 'Íå ãîäåí' íà ìåä.êàðòó ïðèçûâíèêà")
		end
      }
    }
end
function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Ãðàæäàíñêèé',
        [1] = 'Ãðàæäàíñêèé',
        [2] = 'Ãðàæäàíñêèé',
        [3] = 'Ãðàæäàíñêèé',
        [4] = 'Ãðàæäàíñêèé',
        [5] = 'Ãðàæäàíñêèé',
        [6] = 'Ãðàæäàíñêèé',
        [7] = 'Ãðàæäàíñêèé',
        [8] = 'Ãðàæäàíñêèé',
        [9] = 'Ãðàæäàíñêèé',
        [10] = 'Ãðàæäàíñêèé',
        [11] = 'Ãðàæäàíñêèé',
        [12] = 'Ãðàæäàíñêèé',
        [13] = 'Ãðàæäàíñêèé',
        [14] = 'Ãðàæäàíñêèé',
        [15] = 'Ãðàæäàíñêèé',
        [16] = 'Ãðàæäàíñêèé',
        [17] = 'Ãðàæäàíñêèé',
        [18] = 'Ãðàæäàíñêèé',
        [19] = 'Ãðàæäàíñêèé',
        [20] = 'Ãðàæäàíñêèé',
        [21] = 'Ballas',
        [22] = 'Ãðàæäàíñêèé',
        [23] = 'Ãðàæäàíñêèé',
        [24] = 'Ãðàæäàíñêèé',
        [25] = 'Ãðàæäàíñêèé',
        [26] = 'Ãðàæäàíñêèé',
        [27] = 'Ãðàæäàíñêèé',
        [28] = 'Ãðàæäàíñêèé',
        [29] = 'Ãðàæäàíñêèé',
        [30] = 'Rifa',
        [31] = 'Ãðàæäàíñêèé',
        [32] = 'Ãðàæäàíñêèé',
        [33] = 'Ãðàæäàíñêèé',
        [34] = 'Ãðàæäàíñêèé',
        [35] = 'Ãðàæäàíñêèé',
        [36] = 'Ãðàæäàíñêèé',
        [37] = 'Ãðàæäàíñêèé',
        [38] = 'Ãðàæäàíñêèé',
        [39] = 'Ãðàæäàíñêèé',
        [40] = 'Ãðàæäàíñêèé',
        [41] = 'Aztec',
        [42] = 'Ãðàæäàíñêèé',
        [43] = 'Ãðàæäàíñêèé',
        [44] = 'Aztec',
        [45] = 'Ãðàæäàíñêèé',
        [46] = 'Ãðàæäàíñêèé',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Ãðàæäàíñêèé',
        [50] = 'Ãðàæäàíñêèé',
        [51] = 'Ãðàæäàíñêèé',
        [52] = 'Ãðàæäàíñêèé',
        [53] = 'Ãðàæäàíñêèé',
        [54] = 'Ãðàæäàíñêèé',
        [55] = 'Ãðàæäàíñêèé',
        [56] = 'Grove',
        [57] = 'Ìýðèÿ',
        [58] = 'Ãðàæäàíñêèé',
        [59] = 'Àâòîøêîëà',
        [60] = 'Ãðàæäàíñêèé',
        [61] = 'Àðìèÿ',
        [62] = 'Ãðàæäàíñêèé',
        [63] = 'Ãðàæäàíñêèé',
        [64] = 'Ãðàæäàíñêèé',
        [65] = 'Ãðàæäàíñêèé', -- íàä ïîäóìàòü
        [66] = 'Ãðàæäàíñêèé',
        [67] = 'Ãðàæäàíñêèé',
        [68] = 'Ãðàæäàíñêèé',
        [69] = 'Ãðàæäàíñêèé',
        [70] = 'ÌÎÍ',
        [71] = 'Ãðàæäàíñêèé',
        [72] = 'Ãðàæäàíñêèé',
        [73] = 'Army',
        [74] = 'Ãðàæäàíñêèé',
        [75] = 'Ãðàæäàíñêèé',
        [76] = 'Ãðàæäàíñêèé',
        [77] = 'Ãðàæäàíñêèé',
        [78] = 'Ãðàæäàíñêèé',
        [79] = 'Ãðàæäàíñêèé',
        [80] = 'Ãðàæäàíñêèé',
        [81] = 'Ãðàæäàíñêèé',
        [82] = 'Ãðàæäàíñêèé',
        [83] = 'Ãðàæäàíñêèé',
        [84] = 'Ãðàæäàíñêèé',
        [85] = 'Ãðàæäàíñêèé',
        [86] = 'Grove',
        [87] = 'Ãðàæäàíñêèé',
        [88] = 'Ãðàæäàíñêèé',
        [89] = 'Ãðàæäàíñêèé',
        [90] = 'Ãðàæäàíñêèé',
        [91] = 'Ãðàæäàíñêèé', -- ïîä âîïðîñîì
        [92] = 'Ãðàæäàíñêèé',
        [93] = 'Ãðàæäàíñêèé',
        [94] = 'Ãðàæäàíñêèé',
        [95] = 'Ãðàæäàíñêèé',
        [96] = 'Ãðàæäàíñêèé',
        [97] = 'Ãðàæäàíñêèé',
        [98] = 'Ìýðèÿ',
        [99] = 'Ãðàæäàíñêèé',
        [100] = 'Áàéêåð',
        [101] = 'Ãðàæäàíñêèé',
        [102] = 'Ballas',
        [103] = 'Ballas',
        [104] = 'Ballas',
        [105] = 'Grove',
        [106] = 'Grove',
        [107] = 'Grove',
        [108] = 'Vagos',
        [109] = 'Vagos',
        [110] = 'Vagos',
        [111] = 'RM',
        [112] = 'RM',
        [113] = 'LCN',
        [114] = 'Aztec',
        [115] = 'Aztec',
        [116] = 'Aztec',
        [117] = 'Yakuza',
        [118] = 'Yakuza',
        [119] = 'Rifa',
        [120] = 'Yakuza',
        [121] = 'Ãðàæäàíñêèé',
        [122] = 'Ãðàæäàíñêèé',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Ãðàæäàíñêèé',
        [129] = 'Ãðàæäàíñêèé',
        [130] = 'Ãðàæäàíñêèé',
        [131] = 'Ãðàæäàíñêèé',
        [132] = 'Ãðàæäàíñêèé',
        [133] = 'Ãðàæäàíñêèé',
        [134] = 'Ãðàæäàíñêèé',
        [135] = 'Ãðàæäàíñêèé',
        [136] = 'Ãðàæäàíñêèé',
        [137] = 'Ãðàæäàíñêèé',
        [138] = 'Ãðàæäàíñêèé',
        [139] = 'Ãðàæäàíñêèé',
        [140] = 'Ãðàæäàíñêèé',
        [141] = 'FBI',
        [142] = 'Ãðàæäàíñêèé',
        [143] = 'Ãðàæäàíñêèé',
        [144] = 'Ãðàæäàíñêèé',
        [145] = 'Ãðàæäàíñêèé',
        [146] = 'Ãðàæäàíñêèé',
        [147] = 'Ìýðèÿ',
        [148] = 'Ãðàæäàíñêèé',
        [149] = 'Grove',
        [150] = 'Ìýðèÿ',
        [151] = 'Ãðàæäàíñêèé',
        [152] = 'Ãðàæäàíñêèé',
        [153] = 'Ãðàæäàíñêèé',
        [154] = 'Ãðàæäàíñêèé',
        [155] = 'Ãðàæäàíñêèé',
        [156] = 'Ãðàæäàíñêèé',
        [157] = 'Ãðàæäàíñêèé',
        [158] = 'Ãðàæäàíñêèé',
        [159] = 'Ãðàæäàíñêèé',
        [160] = 'Ãðàæäàíñêèé',
        [161] = 'Ãðàæäàíñêèé',
        [162] = 'Ãðàæäàíñêèé',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Ãðàæäàíñêèé',
        [168] = 'Ãðàæäàíñêèé',
        [169] = 'Yakuza',
        [170] = 'Ãðàæäàíñêèé',
        [171] = 'Ãðàæäàíñêèé',
        [172] = 'Ãðàæäàíñêèé',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Ãðàæäàíñêèé',
        [177] = 'Ãðàæäàíñêèé',
        [178] = 'Ãðàæäàíñêèé',
        [179] = 'Army',
        [180] = 'Ãðàæäàíñêèé',
        [181] = 'Áàéêåð',
        [182] = 'Ãðàæäàíñêèé',
        [183] = 'Ãðàæäàíñêèé',
        [184] = 'Ãðàæäàíñêèé',
        [185] = 'Ãðàæäàíñêèé',
        [186] = 'Yakuza',
        [187] = 'Ìýðèÿ',
        [188] = 'ÑÌÈ',
        [189] = 'Ãðàæäàíñêèé',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Ãðàæäàíñêèé',
        [193] = 'Aztec',
        [194] = 'Ãðàæäàíñêèé',
        [195] = 'Ballas',
        [196] = 'Ãðàæäàíñêèé',
        [197] = 'Ãðàæäàíñêèé',
        [198] = 'Ãðàæäàíñêèé',
        [199] = 'Ãðàæäàíñêèé',
        [200] = 'Ãðàæäàíñêèé',
        [201] = 'Ãðàæäàíñêèé',
        [202] = 'Ãðàæäàíñêèé',
        [203] = 'Ãðàæäàíñêèé',
        [204] = 'Ãðàæäàíñêèé',
        [205] = 'Ãðàæäàíñêèé',
        [206] = 'Ãðàæäàíñêèé',
        [207] = 'Ãðàæäàíñêèé',
        [208] = 'Yakuza',
        [209] = 'Ãðàæäàíñêèé',
        [210] = 'Ãðàæäàíñêèé',
        [211] = 'ÑÌÈ',
        [212] = 'Ãðàæäàíñêèé',
        [213] = 'Ãðàæäàíñêèé',
        [214] = 'LCN',
        [215] = 'Ãðàæäàíñêèé',
        [216] = 'Ãðàæäàíñêèé',
        [217] = 'ÑÌÈ',
        [218] = 'Ãðàæäàíñêèé',
        [219] = 'ÌÎÍ',
        [220] = 'Ãðàæäàíñêèé',
        [221] = 'Ãðàæäàíñêèé',
        [222] = 'Ãðàæäàíñêèé',
        [223] = 'LCN',
        [224] = 'Ãðàæäàíñêèé',
        [225] = 'Ãðàæäàíñêèé',
        [226] = 'Rifa',
        [227] = 'Ìýðèÿ',
        [228] = 'Ãðàæäàíñêèé',
        [229] = 'Ãðàæäàíñêèé',
        [230] = 'Ãðàæäàíñêèé',
        [231] = 'Ãðàæäàíñêèé',
        [232] = 'Ãðàæäàíñêèé',
        [233] = 'Ãðàæäàíñêèé',
        [234] = 'Ãðàæäàíñêèé',
        [235] = 'Ãðàæäàíñêèé',
        [236] = 'Ãðàæäàíñêèé',
        [237] = 'Ãðàæäàíñêèé',
        [238] = 'Ãðàæäàíñêèé',
        [239] = 'Ãðàæäàíñêèé',
        [240] = 'Àâòîøêîëà',
        [241] = 'Ãðàæäàíñêèé',
        [242] = 'Ãðàæäàíñêèé',
        [243] = 'Ãðàæäàíñêèé',
        [244] = 'Ãðàæäàíñêèé',
        [245] = 'Ãðàæäàíñêèé',
        [246] = 'Áàéêåð',
        [247] = 'Áàéêåð',
        [248] = 'Áàéêåð',
        [249] = 'Ãðàæäàíñêèé',
        [250] = 'ÑÌÈ',
        [251] = 'Ãðàæäàíñêèé',
        [252] = 'Army',
        [253] = 'Ãðàæäàíñêèé',
        [254] = 'Áàéêåð',
        [255] = 'Army',
        [256] = 'Ãðàæäàíñêèé',
        [257] = 'Ãðàæäàíñêèé',
        [258] = 'Ãðàæäàíñêèé',
        [259] = 'Ãðàæäàíñêèé',
        [260] = 'Ãðàæäàíñêèé',
        [261] = 'ÑÌÈ',
        [262] = 'Ãðàæäàíñêèé',
        [263] = 'Ãðàæäàíñêèé',
        [264] = 'Ãðàæäàíñêèé',
        [265] = 'Ïîëèöèÿ',
        [266] = 'Ïîëèöèÿ',
        [267] = 'Ïîëèöèÿ',
        [268] = 'Ãðàæäàíñêèé',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Ãðàæäàíñêèé', -- íàäî ïîäóìàòü
        [274] = 'ÌÎÍ',
        [275] = 'ÌÎÍ',
        [276] = 'ÌÎÍ',
        [277] = 'Ãðàæäàíñêèé',
        [278] = 'Ãðàæäàíñêèé',
        [279] = 'Ãðàæäàíñêèé',
        [280] = 'Ïîëèöèÿ',
        [281] = 'Ïîëèöèÿ',
        [282] = 'Ïîëèöèÿ',
        [283] = 'Ïîëèöèÿ',
        [284] = 'Ïîëèöèÿ',
        [285] = 'Ïîëèöèÿ',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Ïîëèöèÿ',
        [289] = 'Ãðàæäàíñêèé',
        [290] = 'Ãðàæäàíñêèé',
        [291] = 'Ãðàæäàíñêèé',
        [292] = 'Aztec',
        [293] = 'Ãðàæäàíñêèé',
        [294] = 'Ãðàæäàíñêèé',
        [295] = 'Ãðàæäàíñêèé',
        [296] = 'Ãðàæäàíñêèé',
        [297] = 'Grove',
        [298] = 'Ãðàæäàíñêèé',
        [299] = 'Ãðàæäàíñêèé',
        [300] = 'Ïîëèöèÿ',
        [301] = 'Ïîëèöèÿ',
        [302] = 'Ïîëèöèÿ',
        [303] = 'Ïîëèöèÿ',
        [304] = 'Ïîëèöèÿ',
        [305] = 'Ïîëèöèÿ',
        [306] = 'Ïîëèöèÿ',
        [307] = 'Ïîëèöèÿ',
        [308] = 'ÌÎÍ',
        [309] = 'Ïîëèöèÿ',
        [310] = 'Ïîëèöèÿ',
        [311] = 'Ïîëèöèÿ'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function a.onSendClickPlayer(id)
	if rank == 'Ñòàæåð' or rank == 'Êîíñóëüòàíò' or rank == 'Ìë.Èíñòðóêòîð' or rank == 'Èíñòðóêòîð' or rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàìåñòèòåëü Ãëàâíîãî Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' then
    setClipboardText(sampGetPlayerNickname(id))
	ftext('Íèê ñêîïèðîâàí â áóôåð îáìåí.')
	else
	end
end

function smsjob()
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàìåñòèòåëü Ãëàâíîãî Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' Ïðèâåòñòâóþ, íà ðàáîòó, ó âàñ 15 ìèíóò')
            wait(1200)
        end
        players2 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else
	ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ 7 ðàíãà')
	end
end

function update()
    local updatePath = os.getenv('TEMP')..'\\Update.json'
    -- Ïðîâåðêà íîâîé âåðñèè
    downloadUrlToFile("https://raw.githubusercontent.com/TheChamtih/helpers/main/Update.json", updatePath, function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local file = io.open(updatePath, 'r')
            if file and doesFileExist(updatePath) then
                local info = decodeJson(file:read("*a"))
                file:close(); os.remove(updatePath)
                if info.version ~= thisScript().version then
                    lua_thread.create(function()
                        wait(2000)
                        -- Çàãðóçêà ñêðèïòà, åñëè âåðñèÿ èçìåíèëàñü
                        downloadUrlToFile("https://raw.githubusercontent.com/TheChamtih/helpers/main/Medick_Helper_Anastasia_Ellison.lua", thisScript().path, function(id, status, p1, p2)
                            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                ftext('Îáíîâëåíèå äî àêòóàëüíîé âåðñèè '..info.version..' îáíàðóæåíî.')
                                thisScript():reload()
                            end
                        end)
                    end)
                else
                    ftext('Îáíîâëåíèå íå îáíàðóæåíî. Àêòóàëüíàÿ âåðñèÿ '..info.version..'.', -1)
                end
            end
        end
    end)
end

function cmd_color() -- ôóíêöèÿ ïîëó÷åíèÿ öâåòà ñòðîêè, õç çà÷åì îíà ìíå, íî êîãäà òî þçàë
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Öâåò ïîñëåäíåé ñòðîêè ÷àòà - {934054}[%d] (ñêîïèðîâàí â áóôåð îáìåíà)",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors =
        {
		[1] = 'Çåë¸íûé',
		[2] = 'Ñâåòëî-çåë¸íûé',
		[3] = 'ßðêî-çåë¸íûé',
		[4] = 'Áèðþçîâûé',
		[5] = 'Æ¸ëòî-çåë¸íûé',
		[6] = 'Òåìíî-çåë¸íûé',
		[7] = 'Ñåðî-çåë¸íûé',
		[8] = 'Êðàñíûé',
		[9] = 'ßðêî-êðàñíûé',
		[10] = 'Îðàíæåâûé',
		[11] = 'Êîðè÷íåâûé',
		[12] = 'Ò¸ìíî-êðàñíûé',
		[13] = 'Ñåðî-êðàñíûé',
		[14] = 'Æ¸ëòî-îðàíæåâûé',
		[15] = 'Ìàëèíîâûé',
		[16] = 'Ðîçîâûé',
		[17] = 'Ñèíèé',
		[18] = 'Ãîëóáîé',
		[19] = 'Ñèíÿÿ ñòàëü',
		[20] = 'Ñèíå-çåë¸íûé',
		[21] = 'Ò¸ìíî-ñèíèé',
		[22] = 'Ôèîëåòîâûé',
		[23] = 'Èíäèãî',
		[24] = 'Ñåðî-ñèíèé',
		[25] = 'Æ¸ëòûé',
		[26] = 'Êóêóðóçíûé',
		[27] = 'Çîëîòîé',
		[28] = 'Ñòàðîå çîëîòî',
		[29] = 'Îëèâêîâûé',
		[30] = 'Ñåðûé',
		[31] = 'Ñåðåáðî',
		[32] = '×åðíûé',
		[33] = 'Áåëûé',
		}
	return colors[id]
end
function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
			colors = getcolor(cfg.main.clist)
            ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end

function sampev.onServerMessage(color, text)
        if text:find('Ðàáî÷èé äåíü íà÷àò') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me îòêðûë øêàô÷èê")
                wait(3000)
                sampSendChat("/me ñíÿë ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèë åå â øêàô")
                wait(3000)
                sampSendChat("/me âçÿë ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëñÿ â íåå")
                wait(3000)
                sampSendChat("/me íàöåïèë áåéäæèê íà ðóáàøêó")
                wait(3000)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
				if cfg.main.male == false then
				sampSendChat("/me îòêðûëà øêàô÷èê")
                wait(3000)
                sampSendChat("/me ñíÿëà ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèëà åå â øêàô")
                wait(3000)
                sampSendChat("/me âçÿëà ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëàñü â íåå")
                wait(3000)
                sampSendChat("/me íàöåïèëà áåéäæèê íà ðóáàøêó")
                wait(3000)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Îòïðàâèòåëü:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Îòïðàâèòåëü: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Ðàáî÷èé äåíü îêîí÷åí') and color ~= -1 then
        rabden = false
    end
	if text:find('ïðèîáðåë ëèöåíçèþ íà âîçäóøíûé òðàíñïîðò') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà âîçäóøíûé òðàíñïîðò. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		pilot = pilot + 1
   end
   	if text:find('ïðèîáðåë âîäèòåëüñêèå ïðàâà') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë âîäèòåëüñêèå ïðàâà. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		prava = prava + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà ðûáîëîâñòâî') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà ðûáîëîâñòâî. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		ribolov = ribolov + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà ìîðñêîé òðàíñïîðò') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà ìîðñêîé òðàíñïîðò. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		kater = kater + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà îðóæèå') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà îðóæèå. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		gun = gun + 1
   end
   	if text:find('ïðèîáðåë ëèöåíçèþ íà áèçíåñ') then
        local Nicks = text:match('Èãðîê (.+) ïðèîáðåë ëèöåíçèþ íà îòêðûòèå áèçíåñà. Ñóììà äîáàâëåíà ê çàðïëàòå.')
		biznes = biznes + 1
   end
	if text:find('Âû âûãíàëè (.+) èç îðãàíèçàöèè. Ïðè÷èíà: (.+)') then
        local un1, un2 = text:match('Âû âûãíàëè (.+) èç îðãàíèçàöèè. Ïðè÷èíà: (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - Óâîëåí ïî ïðè÷èíå "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - Óâîëåí ïî ïðè÷èíå "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('ïåðåäàë(- à) óäîñòîâåðåíèå (.+)') then
        local inv1 = text:match('ïåðåäàë(- à) óäîñòîâåðåíèå (.+)')
		lua_thread.create(function()
		wait(5000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s íîâûé ñîòðóäíèê êîëëåêòèâà àâòîøêîëû. Ïðèâåòñòâóåì! %s%s', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r %s - íîâûé ñîòðóäíèê êîëëåêòèâà àâòîøêîëû. Ïðèâåòñòâóåì! %s%s', inv1:gsub('_', ' ')))
		end
		end)
    end
	if color == -8224086 then
        local colors = ("{%06X}"):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors.."[%H:%M:%S] ") .. text)
    end
	if statusc then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
		    src_good = ""
            src_bad = ""
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			local _, handle = sampGetCharHandleBySampPlayerId(id)
			local myname = sampGetPlayerNickname(myid)
				if doesCharExist(handle) then
					local x, y, z = getCharCoordinates(handle)
					local mx, my, mz = getCharCoordinates(PLAYER_PED)
					local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)

					if dist <= 50 then
						src_good = src_good ..sampGetPlayerNickname(id).. ""
					end
					else
						src_bad = src_bad ..sampGetPlayerNickname(id).. ""
			if src_bad ~= myname then
			table.insert(players3, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', src_bad, id, rang, stat))
			return false
		end
		end
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
	if status then
		if text:match('ID: .+ | .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			local nmrang = rang:match('.+%[(%d+)%]')
            if stat:find('Âûõîäíîé') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
end
