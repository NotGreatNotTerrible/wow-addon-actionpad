local ACTIONPAD_KEYBOARD_LAYOUTS = {
    QWERTY = {
        { "F1", "F2", "F3", "F4", "F5" },
        { "1", "2", "3", "4", "5", "6" },
        { "Q", "W", "E", "R", "T", "Y" },
        { "A", "S", "D", "F", "G", "H", "J" },
        { "Z", "X", "C", "V", "B", "N", "M" }
    }
};

local ACTIONPAD_IS_DEBUG_ENABLED = false;
local ACTIONPAD_LIST_OF_KEYS_WE_CANT_TOUCH = {};
local ACTIONPAD_PRIORITY_STANCE_KEYS = { "1", "2", "3", "4", "Q", "E", "R", "F", "Z", "X", "C", "V" };
local ACTIONPAD_TOTAL_BUTTON_COUNT = 0;
local ACTIONPAD_BUTTON_SIZE = 48;

local ActionPad_HiderFrame = CreateFrame("Frame", "ActionPad_HiderFrame", UIParent);

-- Assemble pool of donor action buttons that we can use
-- Reference: https://wowwiki-archive.fandom.com/wiki/ActionSlot
local ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS = {};
for i = 1, 12 do
    table.insert(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
end
-- 13-24 are on 2nd page of ActiobBar (they're not visible to us)
-- Bottom Left ActionBar
for i = 61, 72 do
    table.insert(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
end
-- Bottom Right ActionBar
for i = 49, 60 do
    table.insert(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
end
-- for i=73,96 do
--     table.insert(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
-- end
-- for i=97,120 do
--     table.insert(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
-- end

local function ActionPad_PrintMessage(message)
    (SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME):AddMessage(message);
end

local function ActionPad_PrintDebugMessage(debugMessage)
    if ACTIONPAD_IS_DEBUG_ENABLED then
        ActionPad_PrintMessage("[ActionPad Debug Message]: " .. debugMessage);
    end
end

local function table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true;
        end
    end

    return false;
end

local function table_length(table)
    local count = 0;

    for _ in pairs(table) do
        count = count + 1;
    end

    return count;
end

function ActionPad_OnLoad(self)
    ActionPad_SetupUI();

    self:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function ActionPad_HideFrame(targetFrame)
    targetFrame.ignoreFramePositionManager = true;
    targetFrame:SetParent(ActionPad_HiderFrame);
    targetFrame:UnregisterAllEvents();
end

function ActionPad_SetupUI()
    ActionPad_PrintDebugMessage("ActionPad_SetupUI() called");

    -- Make sure we are on the first page
    ChangeActionBarPage(1);

    -- Hide frames we won't need...
    ActionPad_HiderFrame:Hide();

    -- Have to be careful hiding this one, as it can break the mechanics of ActionButtons1..12
    ActionPad_HideFrame(StanceBarFrame);

    MainMenuBarArtFrame.LeftEndCap:Hide();
    MainMenuBarArtFrame.PageNumber:Hide();
    MainMenuBarArtFrame.RightEndCap:Hide();
    MainMenuBarArtFrameBackground:Hide();
    ActionPad_HideFrame(ActionBarUpButton);
    ActionPad_HideFrame(ActionBarDownButton);

    MultiBarBottomLeft:ClearAllPoints();
    MultiBarBottomLeft:SetPoint("LEFT", ActionPad_MainFrame);

    MultiBarBottomRight:ClearAllPoints();
    MultiBarBottomRight:SetPoint("LEFT", ActionPad_MainFrame);

    -- Ensure donor action bars are set to visible
    if not MultiBarBottomLeft:IsVisible() then
        ActionPad_PrintDebugMessage("MultiBarBottomLeft is hidden, toggling it on");
        InterfaceOptionsActionBarsPanelBottomLeft:Click();
    end
    if not MultiBarBottomRight:IsVisible() then
        ActionPad_PrintDebugMessage("MultiBarBottomRight is hidden, toggling it on");
        InterfaceOptionsActionBarsPanelBottomRight:Click();
    end
end

function ActionPad_DetermineWhatKeysWeCantTouch()
    -- Movement buttons are ought to be left alone
    local cantTouchTheseActions = { "MOVEFORWARD", "MOVEBACKWARD", "TURNLEFT", "TURNRIGHT", "STRAFELEFT", "STRAFERIGHT" };

    for _, action in ipairs(cantTouchTheseActions) do
        key1, key2 = GetBindingKey(action);
        if key1 then
            table.insert(ACTIONPAD_LIST_OF_KEYS_WE_CANT_TOUCH, key1);
        end
        if key2 then
            table.insert(ACTIONPAD_LIST_OF_KEYS_WE_CANT_TOUCH, key2);
        end
    end

    ActionPad_PrintDebugMessage("Number of keys we can't unbind: " .. table_length(ACTIONPAD_LIST_OF_KEYS_WE_CANT_TOUCH));
end

function ActionPad_UpdateKeyBindings()
    -- Since StanceBarFrame is no longer visible, it's wise to unbind SHAPESHIFTBUTTON1..10
    for i = 1, 10 do
        key1, key2 = GetBindingKey("SHAPESHIFTBUTTON" .. i);
        if key1 then
            SetBinding(key1, nil);
        end
        if key2 then
            SetBinding(key2, nil);
        end
    end
end

function ActionPad_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        ActionPad_PrintDebugMessage(event .. " event caught");

        ActionPad_DetermineWhatKeysWeCantTouch();

        ActionPad_RenderKeyboardLayout("QWERTY");

        -- Hide all unused leftover action buttons
        ActionPad_HideUnusedActionButtons();

        ActionPad_UpdateKeyBindings();

        local actionBarsLocked = LOCK_ACTIONBAR == '1';
        ActionPad_MainFrame:EnableMouse(not actionBarsLocked);
        InterfaceOptionsActionBarsPanelLockActionBars:HookScript("OnClick", function ()
            actionBarsLocked = LOCK_ACTIONBAR == '1';
            ActionPad_MainFrame:EnableMouse(not actionBarsLocked);
        end);
    end
end

function ActionPad_GetFrameNameFromActionButtonSlotNumber(slotNumber)
    if slotNumber >= 1 and slotNumber <= 12 then
        return "ActionButton" .. slotNumber;
    elseif slotNumber >= 49 and slotNumber <= 60 then
        return "MultiBarBottomRightButton" .. (slotNumber - 48);
    elseif slotNumber >= 61 and slotNumber <= 72 then
        return "MultiBarBottomLeftButton" .. (slotNumber - 60);
    end
end

function ActionPad_IsPriorityStanceActionButton(keyName)
    return table_contains(ACTIONPAD_PRIORITY_STANCE_KEYS, keyName);
end

function ActionPad_IsAvailableButton(keyName)
    return not table_contains(ACTIONPAD_LIST_OF_KEYS_WE_CANT_TOUCH, keyName);
end

function ActionPad_GetNextAvailableDonorActionButtonSlotNumber(preferablyStanceButton)
    local count = table_length(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS);

    if count > 1 then
        if preferablyStanceButton then
            -- Look for stance action button slots
            for i, slot in ipairs(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS) do
                if slot >= 1 and slot <= 12 then
                    return table.remove(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
                end
            end
        else
            -- Look for non-stance action button slots
            for i, slot in ipairs(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS) do
                if slot > 12 then
                    return table.remove(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
                end
            end
        end

        -- Just take whatever's available
        for i, slot in ipairs(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS) do
            return table.remove(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, i);
        end
    elseif count == 1 then
        return table.remove(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS, 1);
    end

    return nil;
end

function ActionPad_RenderKeyboardLayout(layoutName)
    local maxX = 0;
    local maxY = 0;

    for ri, row in ipairs(ACTIONPAD_KEYBOARD_LAYOUTS[layoutName]) do
        for ki, keyName in ipairs(row) do
            if ActionPad_IsAvailableButton(keyName) then
                local preferablyStanceButton = ActionPad_IsPriorityStanceActionButton(keyName);
                local actionButtonSlotNumber = ActionPad_GetNextAvailableDonorActionButtonSlotNumber(preferablyStanceButton);

                if actionButtonSlotNumber ~= nil then
                    local actionButtonframeName = ActionPad_GetFrameNameFromActionButtonSlotNumber(actionButtonSlotNumber);

                    local buttonFrame = _G[actionButtonframeName];
                    buttonFrame:ClearAllPoints();

                    local x = (ki - 1) * ACTIONPAD_BUTTON_SIZE;
                    local y = (ri - 1) * -ACTIONPAD_BUTTON_SIZE;

                    -- Mimic physical keyboard's key positions
                    if ri == 1 then
                        x = x + ACTIONPAD_BUTTON_SIZE * 1;
                    elseif ri == 3 then
                        x = x + ACTIONPAD_BUTTON_SIZE * 0.5;
                    elseif ri == 4 then
                        x = x + ACTIONPAD_BUTTON_SIZE * 0.75;
                    elseif ri == 5 then
                        x = x + ACTIONPAD_BUTTON_SIZE * 1;
                    end
                    if ri == 1 then
                        if ki > 4 then
                            x = x + ACTIONPAD_BUTTON_SIZE * 0.5;
                        end
                        if ki > 8 then
                            x = x + ACTIONPAD_BUTTON_SIZE * 0.5;
                        end
                    else
                        y = y - 10;
                    end

                    buttonFrame:SetPoint("TOP", ActionPad_MainFrame, "TOP", x, y);
                    buttonFrame:SetPoint("LEFT", ActionPad_MainFrame, "LEFT", x, y);

                    if x > maxX then
                        maxX = x;
                    end
                    if y < maxY then
                        maxY = -y;
                    end
                else
                    -- Ran out of donor buttons, no point in continuing
                    return;
                end
            end
        end
    end

    ActionPad_MainFrame:SetSize(
        maxX + ACTIONPAD_BUTTON_SIZE - (ACTIONPAD_BUTTON_SIZE - 36),
        maxY + ACTIONPAD_BUTTON_SIZE - (ACTIONPAD_BUTTON_SIZE - 36)
    );
end

function ActionPad_HideUnusedActionButtons()
    if table_length(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS) then
        for i = 1, table_length(ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS) do
            local actButId = ACTIONPAD_LIST_OF_AVAILABLE_ACTION_BUTTONS[i];
            local frameName = ActionPad_GetFrameNameFromActionButtonSlotNumber(actButId);
            local buttonFrame = _G[frameName];
            ActionPad_HideFrame(buttonFrame);
            ActionPad_PrintDebugMessage("Permanently hiding unused action button slot #" .. i .. " (" .. frameName ..")");
        end
    end
end
