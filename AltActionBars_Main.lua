

local addonName, AAB = ...

AAB_SELECTED_THEME = nil

local point, relativeTo, relativePoint, xOfs, yOfs = MainMenuBarArtFrame.LeftEndCap:GetPoint()
local width, height = MainMenuBarArtFrame.LeftEndCap:GetWidth(), MainMenuBarArtFrame.LeftEndCap:GetHeight()
AAB_MAIN_MENU_BAR_LEFT_TEXTURE = { Width = width, Height = height, Point = point, RelativeTo = relativeTo, RelativePoint = relativePoint, Xoffset = xOfs, Yoffset = yOfs }

local point, relativeTo, relativePoint, xOfs, yOfs = MainMenuBarArtFrame.RightEndCap:GetPoint()
local width, height = MainMenuBarArtFrame.RightEndCap:GetWidth(), MainMenuBarArtFrame.RightEndCap:GetHeight()
AAB_MAIN_MENU_BAR_RIGHT_TEXTURE = { Width = width, Height = height, Point = point, RelativeTo = relativeTo, RelativePoint = relativePoint, Xoffset = xOfs, Yoffset = yOfs }



AAB_MAIN_MENU_BAR_HEIGHT = MainMenuBar:GetHeight()
AAB_MAIN_MENU_BAR_WIDTH = MainMenuBar:GetWidth()
AAB_STATUS_BAR_OFFSET = StatusTrackingBarManager:GetHeight()

AAB.MainMenuBarArtFrameBackground_TopBorder = MainMenuBarArtFrame:CreateTexture('$parent_ABB_TopBorder', 'ARTWORK')
AAB.MainMenuBarArtFrameBackground_TopBorder:SetTexture(nil)
AAB.MainMenuBarArtFrameBackground_TopBorder:SetSize(AAB_MAIN_MENU_BAR_WIDTH, AAB_STATUS_BAR_OFFSET * 2)
AAB.MainMenuBarArtFrameBackground_TopBorder:SetTexCoord(0, 1, 0.025, 0.06)
AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, AAB_MAIN_MENU_BAR_HEIGHT + AAB_STATUS_BAR_OFFSET)
AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPRIGHT', MainMenuBarArtFrame, 'TOPRIGHT', 0, AAB_MAIN_MENU_BAR_HEIGHT + AAB_STATUS_BAR_OFFSET)

function AAB.UpdateTextures()

    if AAB_SELECTED_THEME then

        AAB_MAIN_MENU_BAR_HEIGHT = MainMenuBar:GetHeight()
        AAB_MAIN_MENU_BAR_WIDTH = MainMenuBar:GetWidth()
        AAB_STATUS_BAR_OFFSET = StatusTrackingBarManager:GetHeight()

        -- set the left end texture
        MainMenuBarArtFrame.LeftEndCap:SetTexture(AAB_SELECTED_THEME.ID)
        MainMenuBarArtFrame.LeftEndCap:SetTexCoord(0, 0.32, 0.78, 1)

        -- set the right end texture, here we flip the image using the 8 point coord system
        MainMenuBarArtFrame.RightEndCap:SetTexture(AAB_SELECTED_THEME.ID)
        MainMenuBarArtFrame.RightEndCap:SetTexCoord(0.32, 0.78, 0.32, 1, 0, 0.78, 0, 1)

        -- set the background when no extra bars are displayed
        MainMenuBarArtFrameBackground.BackgroundSmall:SetTexture(AAB_SELECTED_THEME.ID)
        MainMenuBarArtFrameBackground.BackgroundSmall:SetTexCoord(0, 1, 0.17, 0.35)
        MainMenuBarArtFrameBackground.BackgroundSmall:SetDrawLayer("BACKGROUND", -1)

        -- set the background when extra bars are displayed
        MainMenuBarArtFrameBackground.BackgroundLarge:SetTexture(AAB_SELECTED_THEME.ID)
        MainMenuBarArtFrameBackground.BackgroundLarge:SetTexCoord(0, 1, 0.17, 0.35)
        MainMenuBarArtFrameBackground.BackgroundLarge:SetDrawLayer("BACKGROUND", -1)

        -- update extra border texture
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetTexture(AAB_SELECTED_THEME.ID)
    
        -- get action bar visiblities
        if InterfaceOptionsActionBarsPanelBottomLeft:GetChecked() == true or InterfaceOptionsActionBarsPanelBottomRight:GetChecked() == true then
            -- set textures to double height
            MainMenuBarArtFrameBackground.BackgroundSmall:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, AAB_MAIN_MENU_BAR_HEIGHT)
            MainMenuBarArtFrameBackground.BackgroundLarge:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, AAB_MAIN_MENU_BAR_HEIGHT)

            MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPLEFT', MainMenuBarArtFrameBackground, 'TOPLEFT', -196, AAB_MAIN_MENU_BAR_HEIGHT + (AAB_STATUS_BAR_OFFSET * 3))
            MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrameBackground, 'TOPLEFT', AAB_MAIN_MENU_BAR_HEIGHT, AAB_MAIN_MENU_BAR_HEIGHT + (AAB_STATUS_BAR_OFFSET * 3))

            MainMenuBarArtFrame.RightEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrameBackground, 'TOPRIGHT', 196, AAB_MAIN_MENU_BAR_HEIGHT + (AAB_STATUS_BAR_OFFSET * 3))
            MainMenuBarArtFrame.RightEndCap:SetPoint('TOPLEFT', MainMenuBarArtFrameBackground, 'TOPRIGHT', AAB_MAIN_MENU_BAR_HEIGHT * -1, AAB_MAIN_MENU_BAR_HEIGHT + (AAB_STATUS_BAR_OFFSET * 3))

            AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, AAB_MAIN_MENU_BAR_HEIGHT + AAB_STATUS_BAR_OFFSET)
            AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPRIGHT', MainMenuBarArtFrame, 'TOPRIGHT', 0, AAB_MAIN_MENU_BAR_HEIGHT + AAB_STATUS_BAR_OFFSET)
        else
            -- set to single height
            MainMenuBarArtFrameBackground.BackgroundSmall:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, 0)
            MainMenuBarArtFrameBackground.BackgroundSmall:SetFrameLevel(-1)

            MainMenuBarArtFrameBackground.BackgroundLarge:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, 0)
            MainMenuBarArtFrameBackground.BackgroundLarge:SetFrameLevel(-1)

            local scaler = (MainMenuBarArtFrame.LeftEndCap:GetHeight() + AAB_STATUS_BAR_OFFSET) / MainMenuBarArtFrame.LeftEndCap:GetHeight()
            MainMenuBarArtFrame.LeftEndCap:SetWidth(MainMenuBarArtFrame.LeftEndCap:GetWidth() * scaler)

            MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPLEFT', MainMenuBarArtFrameBackground, 'TOPLEFT', -98 * scaler, AAB_STATUS_BAR_OFFSET * 2.5)
            MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrameBackground, 'TOPLEFT', (AAB_MAIN_MENU_BAR_HEIGHT / 2), AAB_STATUS_BAR_OFFSET * 2.5)

            MainMenuBarArtFrame.RightEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrameBackground, 'TOPRIGHT', 98 * scaler, AAB_STATUS_BAR_OFFSET * 2.5)
            MainMenuBarArtFrame.RightEndCap:SetPoint('TOPLEFT', MainMenuBarArtFrameBackground, 'TOPRIGHT', ((AAB_MAIN_MENU_BAR_HEIGHT / 2) * -1), AAB_STATUS_BAR_OFFSET * 2.5)

            AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, AAB_STATUS_BAR_OFFSET)
            AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPRIGHT', MainMenuBarArtFrame, 'TOPRIGHT', 0, AAB_STATUS_BAR_OFFSET)
        end

        
        for i = 1, 12 do
            local button = _G['ActionButton'..i]




            local buttonBorder = _G['ActionButton'..i..'Border']
            buttonBorder:SetTexture(AAB_SELECTED_THEME.ID)
            buttonBorder:SetTexCoord(0.38, 0.48, 0.63, 0.73)

            -- local buttonBorder = _G['ActionButton'..i..'NormalTexture']
            -- buttonBorder:SetTexture(AAB_SELECTED_THEME.ID)
            -- buttonBorder:SetTexCoord(0.38, 0.48, 0.63, 0.73)

            -- local buttonBorder = _G['ActionButton'..i..'FlyoutBorder']
            -- buttonBorder:SetTexture(AAB_SELECTED_THEME.ID)
            -- buttonBorder:SetTexCoord(0.38, 0.48, 0.63, 0.73)

            -- local buttonBorder = _G['ActionButton'..i..'Border']
            -- buttonBorder:SetTexture(AAB_SELECTED_THEME.ID)
            -- buttonBorder:SetTexCoord(0.38, 0.48, 0.63, 0.73)

            -- local buttonBorder = _G['ActionButton'..i..'Border']
            -- buttonBorder:SetTexture(AAB_SELECTED_THEME.ID)
            -- buttonBorder:SetTexCoord(0.38, 0.48, 0.63, 0.73)






            --local parent, parentLevel, grandparent, grandparentLevel, buttonLevel = button:GetParent():GetName(), button:GetParent():GetFrameLevel(), button:GetParent():GetParent():GetName(), button:GetParent():GetParent():GetFrameLevel(), button:GetFrameLevel()
            --print(parent, parentLevel, grandparent, grandparentLevel, buttonLevel)
            
            --local point, relativeTo, relativePoint, xOfs, yOfs = button:GetPoint()
            --print(point, relativeTo, relativePoint, xOfs, yOfs)

            --ActionButton1:ClearAllPoints()
            --ActionButton1:SetPoint('CENTER', UIParent, 'CENTER', 0 , 0)
        end

        local numButtons = 12;
        for i=1, numButtons do
            local button = _G["ActionButton"..i];

            button:SetFrameLevel(5)
            button:SetFrameStrata('HIGH')


            --button:SetSize(30, 30);
            
            local hotkey = _G[button:GetName().."HotKey"];
            --hotkey:SetSize(30, 14);
            
            local name = _G[button:GetName().."Name"];
            --name:SetSize(30, 14);
        
            -- local texture = MainMenuBarArtFrame:CreateTexture(button:GetName().."Texture");
            -- texture:SetTexture("Interface\\Buttons\\UI-Quickslot");
            -- texture:SetDrawLayer("BACKGROUND", -1);
            -- texture:SetSize(60, 60);
            -- texture:SetPoint("CENTER", button);
            --button:GetNormalTexture():SetAlpha(0);
            
            if (  i == 1 ) then
                --button:ClearAllPoints();
                --button:SetPoint("BOTTOMLEFT", MainMenuBarArtFrame, "BOTTOMLEFT", 0, 0);
            else
                --button:ClearAllPoints();
                --button:SetPoint("LEFT", _G["ActionButton"..(i-1)], "RIGHT", 8, 0);
            end
        end

    end

end

InterfaceOptionsActionBarsPanelBottomLeft:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelBottomRight:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelRight:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelRightTwo:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelStackRightBars:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelLockActionBars:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelAlwaysShowActionBars:HookScript('OnClick', AAB.UpdateTextures)
InterfaceOptionsActionBarsPanelCountdownCooldowns:HookScript('OnClick', AAB.UpdateTextures)

AAB.ThemeSelectionDropDownHeader = InterfaceOptionsActionBarsPanel:CreateFontString('$parent_AAB_ThemeSelectionHeader', 'OVERLAY', 'GameFontNormal')
AAB.ThemeSelectionDropDownHeader:SetPoint('TOPLEFT', InterfaceOptionsActionBarsPanelCountdownCooldowns, 'BOTTOMLEFT', 16, -8)
AAB.ThemeSelectionDropDownHeader:SetText('Themes')

AAB.ThemeSelectionDropDown = CreateFrame('FRAME', 'ABB_ThemeSelectionDropdown', InterfaceOptionsActionBarsPanel, "UIDropDownMenuTemplate")
AAB.ThemeSelectionDropDown:SetPoint('TOPLEFT', AAB.ThemeSelectionDropDownHeader, 'BOTTOMLEFT', -16, -8)
UIDropDownMenu_SetWidth(AAB.ThemeSelectionDropDown, 100)
UIDropDownMenu_SetText(AAB.ThemeSelectionDropDown, 'Select theme')
UIDropDownMenu_Initialize(AAB.ThemeSelectionDropDown, function()
    local info = UIDropDownMenu_CreateInfo()
    for k, v in pairs(AAB.Textures.ActionBar) do
        info.text = k
        info.isTitle = false
        info.func = function()
            AAB_SELECTED_THEME = v
            AAB.UpdateTextures()
            UIDropDownMenu_SetText(AAB.ThemeSelectionDropDown, k)
        end
        UIDropDownMenu_AddButton(info)
    end
end)



AAB.Events = {
    ['ACTIONBAR_SLOT_CHANGED'] = function()
        AAB.UpdateTextures()
    end,
    ['ACTIONBAR_PAGE_CHANGED'] = function()
        AAB.UpdateTextures()
    end,
    ['UI_SCALE_CHANGED'] = function()
        AAB.UpdateTextures()
    end,
}



AAB.EventFrame = CreateFrame('FRAME', 'AAB_EventFrame', UIParent)
AAB.EventFrame:RegisterEvent('ACTIONBAR_SLOT_CHANGED')
AAB.EventFrame:RegisterEvent('ACTIONBAR_PAGE_CHANGED')
AAB.EventFrame:RegisterEvent('UI_SCALE_CHANGED')
AAB.EventFrame:SetScript('OnEvent', function(self, event, ...)
    AAB.Events[event]()
end)


























































-- --options interface
-- AAB.OptionsPanel = CreateFrame("Frame", "AAB_OptionsPanel", UIParent);
-- AAB.OptionsPanel.name = "AAB";
-- InterfaceOptions_AddCategory(AAB.OptionsPanel)
-- -- AAB.OptionsPanel:SetBackdrop({ --bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
--                                             -- edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
--                                             -- tile = true, tileSize = 16, edgeSize = 20, 
--                                             -- insets = { left = 4, right = 4, top = 4, bottom = 4 }});
-- --AAB.OptionsPanel:SetBackdropColor(0,0,0,0.5)
-- AAB.OptionsPanel.texture = AAB.OptionsPanel:CreateTexture('$parent_Texture', 'BACKGROUND')
-- --AAB.OptionsPanel.texture:SetAllPoints(AAB.OptionsPanel)
-- AAB.OptionsPanel.texture:SetPoint('TOPLEFT', 4, -4)
-- AAB.OptionsPanel.texture:SetPoint('BOTTOMRIGHT', -4, 4)

-- --header
-- AAB.OptionsPanel.Header = AAB.OptionsPanel:CreateFontString('AAB_OptionsPanel_Header', 'OVERLAY', 'GameFontNormal')
-- AAB.OptionsPanel.Header:SetText('Alt Action Bars')
-- AAB.OptionsPanel.Header:SetPoint('TOPLEFT', 16, -16)
-- AAB.OptionsPanel.Header:SetFont("Fonts\\FRIZQT__.TTF", 16)

-- --summary text
-- AAB.OptionsPanel.SummaryText = AAB.OptionsPanel:CreateFontString('AAB_OptionsPanel_SummaryText', 'OVERLAY', 'GameFontNormal')
-- AAB.OptionsPanel.SummaryText:SetPoint('TOPLEFT', 16, -40)
-- AAB.OptionsPanel.SummaryText:SetText('Select design')
-- AAB.OptionsPanel.SummaryText:SetTextColor(1,1,1,1)
-- AAB.OptionsPanel.SummaryText:SetJustifyV("TOP")
-- AAB.OptionsPanel.SummaryText:SetJustifyH("LEFT")
-- AAB.OptionsPanel.SummaryText:SetSize(400, 50)


--texture coord viewer
AAB.TextureViewer = CreateFrame('FRAME', 'AAB_TextureViewer', UIParent)
AAB.TextureViewer:SetPoint('Center', 0, 0)
AAB.TextureViewer:SetSize(800, 600)
AAB.TextureViewer.texture = AAB.TextureViewer:CreateTexture('$parent_Texture', 'ARTWORK')
AAB.TextureViewer.texture:SetAllPoints(AAB.TextureViewer)
AAB.TextureViewer.texture:SetTexture(534045)
AAB.TextureViewer:Hide()

for i = 1, 20 do
    local l = AAB.TextureViewer:CreateLine()
    l:SetColorTexture(1,1,1,1)
    l:SetThickness(2)
    l:SetStartPoint("BOTTOMLEFT",0,(i-1)*30)
    l:SetEndPoint("BOTTOMRIGHT",0,(i-1)*30)
end
for i = 1, 20 do
    local l = AAB.TextureViewer:CreateLine()
    l:SetColorTexture(1,1,1,1)
    l:SetThickness(2)
    l:SetStartPoint("BOTTOMLEFT",(i-1)*40, 0)
    l:SetEndPoint("TOPLEFT",(i-1)*40, 0)
end
















-- testing stuff

--MainMenuBarArtFrame:Hide()
-- MainMenuBarArtFrame.PageNumber:Hide()
-- MainMenuBarArtFrame.LeftEndCap:Hide()
-- MainMenuBarArtFrame.RightEndCap:Hide()
-- MainMenuBarArtFrameBackground:Hide()
-- ActionBarUpButton:Hide()
-- ActionBarDownButton:Hide()

-- C_Timer.After(2, function()
--     local w, h = MainMenuBar:GetWidth(), MainMenuBar:GetHeight()
--     MainMenuBar:SetSize(w, h * 2)
--     MainMenuBarArtFrame:SetSize(w, h * 2)
--     MainMenuBarArtFrameBackground.BackgroundLarge:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0 , 0)
--     MainMenuBarArtFrameBackground.BackgroundLarge:SetPoint('BOTTOMRIGHT', MainMenuBarArtFrame, 'BOTTOMRIGHT', 0 , -14)

--     local w, h = MainMenuBarArtFrame.LeftEndCap:GetWidth(), MainMenuBarArtFrame.LeftEndCap:GetHeight()
--     MainMenuBarArtFrame.LeftEndCap:SetSize(w*2, h*2)
--     --MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrame, 'TOPLEFT', 14, 0)
--     MainMenuBarArtFrame.LeftEndCap:SetPoint('BOTTOMLEFT', MainMenuBarArtFrame, 'BOTTOMLEFT', -200, -28)

--     local w, h = MainMenuBarArtFrame.RightEndCap:GetWidth(), MainMenuBarArtFrame.RightEndCap:GetHeight()
--     MainMenuBarArtFrame.RightEndCap:SetSize(w*2, h*2)
--     --MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrame, 'TOPLEFT', 14, 0)
--     MainMenuBarArtFrame.RightEndCap:SetPoint('BOTTOMRIGHT', MainMenuBarArtFrame, 'BOTTOMRIGHT', 200, -28)
-- end)




-- ActionBarUpButton:SetNormalTexture(534045)
-- ActionBarUpButton:SetTexCoord(0, 0.06, 0.44, 0.49)




