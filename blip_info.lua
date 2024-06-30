local PushScaleformMovieFunctionN = PushScaleformMovieFunctionN
local PushScaleformMovieFunctionParameterInt = PushScaleformMovieFunctionParameterInt
local PushScaleformMovieFunctionParameterBool = PushScaleformMovieFunctionParameterBool
local PushScaleformMovieFunctionParameterString = PushScaleformMovieFunctionParameterString
local PopScaleformMovieFunctionVoid = PopScaleformMovieFunctionVoid

local blipInfoData = {}

--- Ensure blip info exists and is initialized with default values
-- @param blip The blip ID
-- @return The blip info data
local function ensureBlipInfo(blip)
    blip = blip or 0
    SetBlipAsMissionCreatorBlip(blip, true)
    if not blipInfoData[blip] then
        blipInfoData[blip] = {
            title = "",
            rockstarVerified = false,
            info = {},
            money = "",
            rp = "",
            dict = "",
            tex = ""
        }
    end
    return blipInfoData[blip]
end

--- Reset blip info
-- @param blip The blip ID
function ResetBlipInfo(blip)
    blipInfoData[blip] = nil
end

--- Set blip info title and rockstar verification
-- @param blip The blip ID
-- @param title The title of the blip
-- @param rockstarVerified If the blip is rockstar verified
function SetBlipInfoTitle(blip, title, rockstarVerified)
    local data = ensureBlipInfo(blip)
    data.title = title or ""
    data.rockstarVerified = rockstarVerified or false
end

--- Set blip info image
-- @param blip The blip ID
-- @param dict The dictionary of the image
-- @param tex The texture of the image
function SetBlipInfoImage(blip, dict, tex)
    local data = ensureBlipInfo(blip)
    data.dict = dict or ""
    data.tex = tex or ""
end

--- Set blip info economy details
-- @param blip The blip ID
-- @param rp The RP value
-- @param money The money value
function SetBlipInfoEconomy(blip, rp, money)
    local data = ensureBlipInfo(blip)
    data.money = tostring(money) or ""
    data.rp = tostring(rp) or ""
end

--- Set blip info data
-- @param blip The blip ID
-- @param info The info data to set
function SetBlipInfo(blip, info)
    local data = ensureBlipInfo(blip)
    data.info = info
end

--- Add text info to blip
-- @param blip The blip ID
-- @param leftText The left text
-- @param rightText The right text
function AddBlipInfoText(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    if rightText then
        data.info[#data.info+1] = {1, leftText or "", rightText or ""}
    else
        data.info[#data.info+1] = {5, leftText or "", ""}
    end
end

--- Add name info to blip
-- @param blip The blip ID
-- @param leftText The left text
-- @param rightText The right text
function AddBlipInfoName(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    data.info[#data.info+1] = {3, leftText or "", rightText or ""}
end

--- Add header info to blip
-- @param blip The blip ID
-- @param leftText The left text
-- @param rightText The right text
function AddBlipInfoHeader(blip, leftText, rightText)
    local data = ensureBlipInfo(blip)
    data.info[#data.info+1] = {4, leftText or "", rightText or ""}
end

--- Add icon info to blip
-- @param blip The blip ID
-- @param leftText The left text
-- @param rightText The right text
-- @param iconId The icon ID
-- @param iconColor The icon color
-- @param checked If the icon is checked
function AddBlipInfoIcon(blip, leftText, rightText, iconId, iconColor, checked)
    local data = ensureBlipInfo(blip)
    data.info[#data.info+1] = {2, leftText or "", rightText or "", iconId or 0, iconColor or 0, checked or false}
end

-- Update display
local displayIndex <const> = 1
--- Update the display
local function updateDisplay()
    if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(displayIndex)
        PopScaleformMovieFunctionVoid()
    end
end

--- Set column state
-- @param column The column index
-- @param state The state to set
local function setColumnState(column, state)
    if PushScaleformMovieFunctionN("SHOW_COLUMN") then
        PushScaleformMovieFunctionParameterInt(column)
        PushScaleformMovieFunctionParameterBool(state)
        PopScaleformMovieFunctionVoid()
    end
end

--- Show or hide display
-- @param show If the display should be shown
local function showDisplay(show)
    setColumnState(displayIndex, show)
end

--- Helper function for text command
-- @param text The text to display
local function beginTextCommand(text)
    BeginTextCommandScaleformString(text)
    EndTextCommandScaleformString()
end

--- Set icon in the display
-- @param index The index of the icon
-- @param title The title of the icon
-- @param text The text of the icon
-- @param icon The icon ID
-- @param iconColor The icon color
-- @param completed If the icon is completed
local function setIcon(index, title, text, icon, iconColor, completed)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(displayIndex)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(1)
        beginTextCommand(title)
        beginTextCommand(text)
        PushScaleformMovieFunctionParameterInt(icon)
        PushScaleformMovieFunctionParameterInt(iconColor)
        PushScaleformMovieFunctionParameterBool(completed)
        PopScaleformMovieFunctionVoid()
    end
end

--- Set text in the display
-- @param index The index of the text
-- @param title The title of the text
-- @param text The text content
-- @param textType The type of the text
local function setText(index, title, text, textType)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(displayIndex)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(textType or 0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        beginTextCommand(title)
        beginTextCommand(text)
        PopScaleformMovieFunctionVoid()
    end
end

-- Clear display
local labelsCount = 0
local entriesCount = 0
--- Clear the display
local function clearDisplay()
    if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
        PushScaleformMovieFunctionParameterInt(displayIndex)
        PopScaleformMovieFunctionVoid()
    end
    labelsCount = 0
    entriesCount = 0
end

--- Generate label
-- @param text The text for the label
-- @return The generated label
local function generateLabel(text)
    local label <const> = "LBL" .. labelsCount
    AddTextEntry(label, text)
    labelsCount += 1
    return label
end

--- Set display title
-- @param title The title of the display
-- @param rockstarVerified If the display is rockstar verified
-- @param rp The RP value
-- @param money The money value
-- @param dict The dictionary for the image
-- @param tex The texture for the image
local function setDisplayTitle(title, rockstarVerified, rp, money, dict, tex)
    if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
        PushScaleformMovieFunctionParameterInt(displayIndex)
        beginTextCommand("")
        beginTextCommand(generateLabel(title))
        PushScaleformMovieFunctionParameterInt(rockstarVerified)
        PushScaleformMovieFunctionParameterString(dict)
        PushScaleformMovieFunctionParameterString(tex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        if rp == "" then
            PushScaleformMovieFunctionParameterBool(false)
        else
            beginTextCommand(generateLabel(rp))
        end
        if money == "" then
            PushScaleformMovieFunctionParameterBool(false)
        else
            beginTextCommand(generateLabel(money))
        end
        PopScaleformMovieFunctionVoid()
    end
end

--- Add text to display
-- @param title The title of the text
-- @param desc The description of the text
-- @param style The style of the text
local function addTextToDisplay(title, desc, style)
    setText(entriesCount, generateLabel(title), generateLabel(desc), style or 1)
    entriesCount += 1
end

--- Add icon to display
-- @param title The title of the icon
-- @param desc The description of the icon
-- @param icon The icon ID
-- @param color The color of the icon
-- @param checked If the icon is checked
local function addIconToDisplay(title, desc, icon, color, checked)
    setIcon(entriesCount, generateLabel(title), generateLabel(desc), icon, color, checked)
    entriesCount += 1
end

--- Main thread to update blip info display
Citizen.CreateThread(function()
    local currentBlip, blip, data
    while true do
        Wait(0)
        if IsFrontendReadyForControl() then
            blip = DisableBlipNameForVar()
            if IsHoveringOverMissionCreatorBlip() then
                if DoesBlipExist(blip) then
                    if currentBlip ~= blip then
                        currentBlip = blip
                        if blipInfoData[blip] then
                            data = ensureBlipInfo(blip)
                            TakeControlOfFrontend()
                            clearDisplay()
                            setDisplayTitle(data.title, data.rockstarVerified, data.rp, data.money, data.dict, data.tex)
                            for _, info in ipairs(data.info) do
                                if info[1] == 2 then
                                    addIconToDisplay(info[2], info[3], info[4], info[5], info[6])
                                else
                                    addTextToDisplay(info[2], info[3], info[1])
                                end
                            end
                            showDisplay(true)
                            updateDisplay()
                            ReleaseControlOfFrontend()
                        else
                            showDisplay(false)
                        end
                    end
                end
            else
                if currentBlip then
                    currentBlip = nil
                    showDisplay(false)
                end
            end
        end
    end
end)
