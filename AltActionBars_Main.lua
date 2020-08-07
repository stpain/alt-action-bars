

local addonName, AAB = ...

function AAB.UpdateTextures(texture)

    local barHeight = MainMenuBar:GetHeight()
    local barWidth = MainMenuBar:GetWidth()
    local yOffset = StatusTrackingBarManager:GetHeight()

    -- set the left end texture
    MainMenuBarArtFrame.LeftEndCap:SetTexture(texture.ID)
    MainMenuBarArtFrame.LeftEndCap:SetTexCoord(0, 0.32, 0.78, 1)

    -- set the right end texture, here we flip the image using the 8 point coord system
    MainMenuBarArtFrame.RightEndCap:SetTexture(texture.ID)
    MainMenuBarArtFrame.RightEndCap:SetTexCoord(0.32, 0.78, 0.32, 1, 0, 0.78, 0, 1)

    -- set the background when no extra bars are displayed
    MainMenuBarArtFrameBackground.BackgroundSmall:SetTexture(texture.ID)
    MainMenuBarArtFrameBackground.BackgroundSmall:SetTexCoord(0, 1, 0.17, 0.35)
    MainMenuBarArtFrameBackground.BackgroundSmall:SetDrawLayer("BACKGROUND", -1)

    -- set the background when extra bars are displayed
    MainMenuBarArtFrameBackground.BackgroundLarge:SetTexture(texture.ID)
    MainMenuBarArtFrameBackground.BackgroundLarge:SetTexCoord(0, 1, 0.17, 0.35)
    MainMenuBarArtFrameBackground.BackgroundLarge:SetDrawLayer("BACKGROUND", -1)
  
    if MultiBarBottomLeft:IsVisible() then
        MainMenuBarArtFrameBackground.BackgroundSmall:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, barHeight)
        MainMenuBarArtFrameBackground.BackgroundLarge:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, barHeight)

        --MainMenuBarArtFrame.LeftEndCap:ClearAllPoints()
        MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPLEFT', MainMenuBarArtFrameBackground, 'TOPLEFT', -200, barHeight + yOffset + yOffset + yOffset)
        MainMenuBarArtFrame.LeftEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrameBackground, 'TOPLEFT', barHeight, barHeight + yOffset + yOffset + yOffset)


        MainMenuBarArtFrame.RightEndCap:SetPoint('TOPRIGHT', MainMenuBarArtFrameBackground, 'TOPRIGHT', 200, barHeight + yOffset + yOffset + yOffset)
        MainMenuBarArtFrame.RightEndCap:SetPoint('TOPLEFT', MainMenuBarArtFrameBackground, 'TOPRIGHT', barHeight * -1, barHeight + yOffset + yOffset + yOffset)

        
    end

    if not AAB.MainMenuBarArtFrameBackground_TopBorder then
        AAB.MainMenuBarArtFrameBackground_TopBorder = MainMenuBarArtFrame:CreateTexture('$parent_ABB_TopBorder', 'ARTWORK')
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetTexture(texture.ID)
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetSize(barWidth, yOffset * 2)
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetTexCoord(0, 1, 0.025, 0.06)
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPLEFT', MainMenuBarArtFrame, 'TOPLEFT', 0, barHeight + yOffset)
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetPoint('TOPRIGHT', MainMenuBarArtFrame, 'TOPRIGHT', 0, barHeight + yOffset)
    else
        AAB.MainMenuBarArtFrameBackground_TopBorder:SetTexture(texture.ID)
    end
    
    for i = 1, 12 do
        local button = _G['ActionButton'..i]
        local parent, parentLevel, grandparent, grandparentLevel, buttonLevel = button:GetParent():GetName(), button:GetParent():GetFrameLevel(), button:GetParent():GetParent():GetName(), button:GetParent():GetParent():GetFrameLevel(), button:GetFrameLevel()
        --print(parent, parentLevel, grandparent, grandparentLevel, buttonLevel)
        
        local point, relativeTo, relativePoint, xOfs, yOfs = button:GetPoint()
        --print(point, relativeTo, relativePoint, xOfs, yOfs)

        --ActionButton1:ClearAllPoints()
        --ActionButton1:SetPoint('CENTER', UIParent, 'CENTER', 0 , 0)
    end

end

AAB.ThemeSelectionDropDownHeader = InterfaceOptionsActionBarsPanel:CreateFontString('$parent_AAB_ThemeSelectionHeader', 'OVERLAY', 'GameFontNormal')
AAB.ThemeSelectionDropDownHeader:SetPoint('TOPLEFT', InterfaceOptionsActionBarsPanelCountdownCooldowns, 'BOTTOMLEFT', 16, -8)
AAB.ThemeSelectionDropDownHeader:SetText('Themes')

AAB.ThemeSelectionDropDown = CreateFrame('FRAME', 'ABB_ThemeSelectionDropdown', InterfaceOptionsActionBarsPanel, "UIDropDownMenuTemplate")
AAB.ThemeSelectionDropDown:SetPoint('TOPLEFT', AAB.ThemeSelectionDropDownHeader, 'BOTTOMLEFT', 0, -8)
UIDropDownMenu_SetWidth(AAB.ThemeSelectionDropDown, 100)
UIDropDownMenu_SetText(AAB.ThemeSelectionDropDown, 'Select theme')
UIDropDownMenu_Initialize(AAB.ThemeSelectionDropDown, function()
    local info = UIDropDownMenu_CreateInfo()
    for k, v in pairs(AAB.Textures.ActionBar) do
        info.text = k
        info.isTitle = false
        info.func = function()
            AAB.UpdateTextures(v)
        end
        UIDropDownMenu_AddButton(info)
    end
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




