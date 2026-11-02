-- ====================================================================
-- CATEGORY HUB: PART 1 (FIRST HALF) - INTERFACE & LAUNCHER ICON
-- ====================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- 1. CENTRAL GARBAGE DISPOSAL ENGINE (Halts past threads to eliminate lag)
if _G.Framework_Active_Signals then
    for _, disconnect in pairs(_G.Framework_Active_Signals) do pcall(disconnect) end
end
if CoreGui:FindFirstChild("UniversalCategoryHub") then
    CoreGui.UniversalCategoryHub:Destroy()
end

-- 2. MASTER PROPERTY MATRIX (Preserved System Parameters Matrix)
_G.Framework_Active_Signals = {}
_G.SettingsMatrix = {
    MasterESP = true,
    MemoryHook = true,
    HitboxSize = 2,
    HitboxTransparency = 80,
    WalkSpeed = 16,
    JumpPower = 50,
    TargetPlayer = "ALL"
}

_G.Framework_Core_Update_ESP = function() end

-- 3. WINDOW CANVAS BUILDER
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalCategoryHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- 4. THE LAUNCHER WIDGET (Draggable Floating Launcher Circle)
local FloatIcon = Instance.new("TextButton")
FloatIcon.Name = "FloatIcon"
FloatIcon.Size = UDim2.new(0, 46, 0, 46)
FloatIcon.Position = UDim2.new(0.02, 0, 0.2, 0)
FloatIcon.BackgroundColor3 = Color3.fromRGB(30, 25, 40)
FloatIcon.Text = "🌀"
FloatIcon.TextSize = 20
FloatIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatIcon.BorderSizePixel = 0
FloatIcon.Visible = false
FloatIcon.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = FloatIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(115, 60, 255)
IconStroke.Thickness = 2
IconStroke.Parent = FloatIcon

-- 5. THE MAIN PANEL COMPONENT
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Premium Header Bar Layout Panel
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = HeaderFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SYSTEM CONTROL HUB"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = HeaderFrame

-- Premium [X] Minimize Button Layout
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
CloseBtn.Text = "X"
CloseBtn.TextSize = 12
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = HeaderFrame
Instance.new("UICorner").CornerRadius = UDim.new(0, 4)

-- Window State Controller Actions
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatIcon.Visible = true
end)

FloatIcon.MouseButton1Click:Connect(function()
    FloatIcon.Visible = false
    MainFrame.Visible = true
end)

print("[System Hub]: Part 1 (First Half) Interface Elements Configured.")
-- ====================================================================
-- CATEGORY HUB: PART 1 (FINAL OF PART 1) - NAV & TAB CONTAINERS
-- ====================================================================

-- 6. MULTI-INSTANCE VECTOR DRAGGING COMPONENT
local function enableDragging(frame, dragHandle)
    local handle = dragHandle or frame
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
enableDragging(MainFrame, HeaderFrame)
enableDragging(FloatIcon)

-- 7. LEFT SIDE NAVIGATION MENU BAR
local SidebarFrame = Instance.new("Frame")
SidebarFrame.Name = "SidebarFrame"
SidebarFrame.Size = UDim2.new(0, 130, 1, -40)
SidebarFrame.Position = UDim2.new(0, 0, 0, 40)
SidebarFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
SidebarFrame.BorderSizePixel = 0
SidebarFrame.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 8)
SideCorner.Parent = SidebarFrame

local HideStrip = Instance.new("Frame")
HideStrip.Size = UDim2.new(0, 10, 1, 0)
HideStrip.Position = UDim2.new(1, -10, 0, 0)
HideStrip.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
HideStrip.BorderSizePixel = 0
HideStrip.Parent = SidebarFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Parent = SidebarFrame

-- 8. VIEWPORT PAGE STORAGE OVERLAYS
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -130, 1, -40)
ContentContainer.Position = UDim2.new(0, 130, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

_G.CombatPage = Instance.new("Frame")
_G.CombatPage.Name = "CombatPage"
_G.CombatPage.Size = UDim2.new(1, 0, 1, 0)
_G.CombatPage.BackgroundTransparency = 1
_G.CombatPage.Visible = true
_G.CombatPage.Parent = ContentContainer

_G.VisualsPage = Instance.new("Frame")
_G.VisualsPage.Name = "VisualsPage"
_G.VisualsPage.Size = UDim2.new(1, 0, 1, 0)
_G.VisualsPage.BackgroundTransparency = 1
_G.VisualsPage.Visible = false
_G.VisualsPage.Parent = ContentContainer

_G.MiscPage = Instance.new("Frame")
_G.MiscPage.Name = "MiscPage"
_G.MiscPage.Size = UDim2.new(1, 0, 1, 0)
_G.MiscPage.BackgroundTransparency = 1
_G.MiscPage.Visible = false
_G.MiscPage.Parent = ContentContainer

local function switchTab(activePage)
    _G.CombatPage.Visible = (activePage == _G.CombatPage)
    _G.VisualsPage.Visible = (activePage == _G.VisualsPage)
    _G.MiscPage.Visible = (activePage == _G.MiscPage)
end

local function createTabButton(text, pageTarget)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 115, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 205)
    btn.TextSize = 11
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    btn.Parent = SidebarFrame
    Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function() switchTab(pageTarget) end)
    return btn
end

createTabButton("🎯 Combat Engine", _G.CombatPage)
createTabButton("👁️ Visuals ESP", _G.VisualsPage)
createTabButton("⚙️ Movement / Misc", _G.MiscPage)

print("[System Hub]: Part 1 Layout Panels Locked Down.")

-- ====================================================================
-- CATEGORY HUB: PART 2 (FIRST HALF) - INTERFACE OBJECT FACTORIES
-- ====================================================================

local RunService = game:GetService("RunService")

----------------------------------------------------------------
-- [9. CATEGORIZED COMPONENT OBJECT FACTORIES]
----------------------------------------------------------------
local function makeToggle(text, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(240, 240, 245)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
    
    local statusIndicator = Instance.new("Frame")
    statusIndicator.Size = UDim2.new(0, 12, 0, 12)
    statusIndicator.Position = UDim2.new(1, -22, 0, 10)
    statusIndicator.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    statusIndicator.BorderSizePixel = 0
    statusIndicator.Parent = btn
    Instance.new("UICorner").CornerRadius = UDim.new(1, 0)

    btn.MouseButton1Click:Connect(function()
        callback(btn, statusIndicator)
    end)
    return btn
end

local function makeInputSlot(text, parent, callback)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0, 300, 0, 30)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    box.Text = text
    box.TextColor3 = Color3.fromRGB(180, 180, 185)
    box.TextSize = 11
    box.Font = Enum.Font.SourceSans
    box.BorderSizePixel = 0
    box.Parent = parent
    Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
    
    box.FocusLost:Connect(function() callback(box) end)
    return box
end

local function makeUtilityMiniButton(text, parent, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 300, 0, 26)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 11
    b.Font = Enum.Font.SourceSansBold
    b.BorderSizePixel = 0
    b.Parent = parent
    Instance.new("UICorner").CornerRadius = UDim.new(0, 5)
    b.MouseButton1Click:Connect(callback)
    return b
end

----------------------------------------------------------------
-- CATEGORY A: COMBAT INTERFACE CONFIGURATION
----------------------------------------------------------------
local targetListPadding = Instance.new("UIListLayout")
targetListPadding.Padding = UDim.new(0, 6)
targetListPadding.HorizontalAlignment = Enum.HorizontalAlignment.Center
targetListPadding.Parent = _G.CombatPage

local spacerCombat = Instance.new("Frame")
spacerCombat.Size = UDim2.new(1, 0, 0, 5)
spacerCombat.BackgroundTransparency = 1
spacerCombat.Parent = _G.CombatPage

makeInputSlot("Hitbox Size Variable (Max: 100)", _G.CombatPage, function(box)
    local num = tonumber(box.Text)
    if num then _G.SettingsMatrix.HitboxSize = math.clamp(num, 2, 100) box.Text = "Hitbox Size Locked: " .. tostring(_G.SettingsMatrix.HitboxSize)
    else box.Text = "Invalid Input! Reset to 2" _G.SettingsMatrix.HitboxSize = 2 end
end)

makeInputSlot("Hitbox Transparency Setting (0 - 100)", _G.CombatPage, function(box)
    local num = tonumber(box.Text)
    if num then _G.SettingsMatrix.HitboxTransparency = math.clamp(num, 0, 100) box.Text = "Hitbox Transparency: " .. tostring(_G.SettingsMatrix.HitboxTransparency) .. "%"
    else box.Text = "Invalid Input! Reset to 80%" _G.SettingsMatrix.HitboxTransparency = 80 end
end)

local SelectorBox = Instance.new("ScrollingFrame")
SelectorBox.Size = UDim2.new(0, 300, 0, 100)
SelectorBox.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
SelectorBox.BorderSizePixel = 0
SelectorBox.CanvasSize = UDim2.new(0, 0, 0, 0)
SelectorBox.ScrollBarThickness = 4
SelectorBox.Parent = _G.CombatPage
Instance.new("UICorner").CornerRadius = UDim.new(0, 5)

local SelectorLayout = Instance.new("UIListLayout")
SelectorLayout.Padding = UDim.new(0, 4)
SelectorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SelectorLayout.Parent = SelectorBox

local TargetStatusDisplay = Instance.new("TextLabel")
TargetStatusDisplay.Size = UDim2.new(0, 300, 0, 20)
TargetStatusDisplay.BackgroundTransparency = 1
TargetStatusDisplay.Text = "Selected Targeted Tracker: ALL"
TargetStatusDisplay.TextColor3 = Color3.fromRGB(0, 255, 150)
TargetStatusDisplay.TextSize = 11
TargetStatusDisplay.Font = Enum.Font.SourceSansBold
TargetStatusDisplay.Parent = _G.CombatPage

local function updatePlayerDropdown()
    for _, child in ipairs(SelectorBox:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local allBtn = Instance.new("TextButton")
    allBtn.Size = UDim2.new(0, 285, 0, 22)
    allBtn.BackgroundColor3 = Color3.fromRGB(45, 55, 70)
    allBtn.Text = "[ CHOOSE ALL PLAYERS ]"
    allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    allBtn.TextSize = 10
    allBtn.Font = Enum.Font.SourceSansBold
    allBtn.Parent = SelectorBox
    Instance.new("UICorner").CornerRadius = UDim.new(0, 4)
    
    allBtn.MouseButton1Click:Connect(function()
        _G.SettingsMatrix.TargetPlayer = "ALL"
        TargetStatusDisplay.Text = "Selected Targeted Tracker: ALL"
    end)

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(0, 285, 0, 22)
            pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            pBtn.Text = p.Name
            pBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
            pBtn.TextSize = 10
            pBtn.Font = Enum.Font.SourceSans
            pBtn.Parent = SelectorBox
            Instance.new("UICorner").CornerRadius = UDim.new(0, 4)

            pBtn.MouseButton1Click:Connect(function()
                _G.SettingsMatrix.TargetPlayer = p.Name
                TargetStatusDisplay.Text = "Selected Targeted Tracker: " .. p.Name
            end)
        end
    end
    SelectorBox.CanvasSize = UDim2.new(0, 0, 0, SelectorLayout.AbsoluteContentSize.Y + 10)
end

makeUtilityMiniButton("🔄 Refresh Player Server List", _G.CombatPage, function()
    updatePlayerDropdown()
end)

updatePlayerDropdown()

print("[System Hub]: Part 2 (First Half) Factories and Dropdown Deployed.")

-- ====================================================================
-- CATEGORY HUB: PART 2 (FINAL OF PART 2) - ENGINE PIPELINES
-- ====================================================================

----------------------------------------------------------------
-- CATEGORY B: VISUALS INTERFACE CONFIGURATION
----------------------------------------------------------------
local visualsListPadding = Instance.new("UIListLayout")
visualsListPadding.Padding = UDim.new(0, 6)
visualsListPadding.HorizontalAlignment = Enum.HorizontalAlignment.Center
visualsListPadding.Parent = _G.VisualsPage

local spacerVisuals = Instance.new("Frame")
spacerVisuals.Size = UDim2.new(1, 0, 0, 5)
spacerVisuals.BackgroundTransparency = 1
spacerVisuals.Parent = _G.VisualsPage

makeToggle("Master Visual Layer (ESP)", _G.VisualsPage, function(btn, indicator)
    _G.SettingsMatrix.MasterESP = not _G.SettingsMatrix.MasterESP
    btn.Text = _G.SettingsMatrix.MasterESP and "  Master Visual Layer (ESP): ON" or "  Master Visual Layer (ESP): OFF"
    indicator.BackgroundColor3 = _G.SettingsMatrix.MasterESP and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(80, 80, 85)
    _G.Framework_Core_Update_ESP()
end)

----------------------------------------------------------------
-- CATEGORY C: MOVEMENT & MISC CONFIGURATION
----------------------------------------------------------------
local miscListPadding = Instance.new("UIListLayout")
miscListPadding.Padding = UDim.new(0, 6)
miscListPadding.HorizontalAlignment = Enum.HorizontalAlignment.Center
miscListPadding.Parent = _G.MiscPage

local spacerMisc = Instance.new("Frame")
spacerMisc.Size = UDim2.new(1, 0, 0, 5)
spacerMisc.BackgroundTransparency = 1
spacerMisc.Parent = _G.MiscPage

makeToggle("Anti-Cheat Memory Hook Status", _G.MiscPage, function(btn, indicator)
    _G.SettingsMatrix.MemoryHook = not _G.SettingsMatrix.MemoryHook
    btn.Text = _G.SettingsMatrix.MemoryHook and "  Anti-Cheat Memory Hook Status: ON" or "  Anti-Cheat Memory Hook Status: OFF"
    indicator.BackgroundColor3 = _G.SettingsMatrix.MemoryHook and Color3.fromRGB(20, 150, 80) or Color3.fromRGB(150, 40, 40)
end)

makeInputSlot("Adjust WalkSpeed Configuration", _G.MiscPage, function(box)
    local num = tonumber(box.Text)
    if num then _G.SettingsMatrix.WalkSpeed = math.clamp(num, 16, 250) box.Text = "WalkSpeed Locked: " .. tostring(_G.SettingsMatrix.WalkSpeed)
    else box.Text = "Invalid Input! Reset to 16" _G.SettingsMatrix.WalkSpeed = 16 end
end)

makeInputSlot("Adjust JumpPower Configuration", _G.MiscPage, function(box)
    local num = tonumber(box.Text)
    if num then _G.SettingsMatrix.JumpPower = math.clamp(num, 50, 350) box.Text = "JumpPower Locked: " .. tostring(_G.SettingsMatrix.JumpPower)
    else box.Text = "Invalid Input! Reset to 50" _G.SettingsMatrix.JumpPower = 50 end
end)

makeUtilityMiniButton("🛑 Completely Shutdown Script Systems", _G.MiscPage, function()
    for _, disconnect in pairs(_G.Framework_Active_Signals) do pcall(disconnect) end
    local CoreGui = game:GetService("CoreGui")
    if CoreGui:FindFirstChild("UniversalCategoryHub") then CoreGui.UniversalCategoryHub:Destroy() end
    print("[Category Hub]: Framework safely purged.")
end)

----------------------------------------------------------------
-- [10. CORE MOVEMENT & HOOK ENFORCEMENT ENGINE]
----------------------------------------------------------------
task.spawn(function()
    pcall(function()
        local rawMetatable = getrawmetatable(game)
        local originalIndex = rawMetatable.__index
        setreadonly(rawMetatable, false)

        rawMetatable.__index = newcclosure(function(instance, property)
            if _G.SettingsMatrix.MemoryHook and not checkcaller() then
                if property == "WalkSpeed" and instance:IsA("Humanoid") then return 16
                elseif property == "JumpPower" and instance:IsA("Humanoid") then return 50
                elseif property == "Size" and instance.Name == "HumanoidRootPart" then return Vector3.new(2, 2, 1) end
            end
            return originalIndex(instance, property)
        end)
        setreadonly(rawMetatable, true)
    end)
end)

local function applyVisuals(player, character)
    if not character or not character:IsDescendantOf(workspace) then return end
    
    for _, item in ipairs(character:GetDescendants()) do
        if item.Name == "UniversalRedNameTag" or item.Name == "UniversalBlueESP" then
            pcall(function() item:Destroy() end)
        end
    end

    local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildOfClass("BasePart")
    if root and _G.SettingsMatrix.MasterESP then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "UniversalRedNameTag"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 4, 0)
        billboard.AlwaysOnTop = true
        billboard.Adornee = root
        billboard.Parent = root

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.TextSize = 13
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.TextStrokeTransparency = 0
        textLabel.Parent = billboard

        local highlight = Instance.new("Highlight")
        highlight.Name = "UniversalBlueESP"
        highlight.FillColor = Color3.fromRGB(0, 0, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = character
        highlight.Parent = character
    end
end

local function registerPipeline(player)
    if player == LocalPlayer then return end
    local connections = {}

    local function onCharacter(char)
        if not char then return end
        task.wait(0.3)
        applyVisuals(player, char)
    end

    if player.Character then onCharacter(player.Character) end
    connections.Character = player.CharacterAdded:Connect(onCharacter)
    
    table.insert(_G.Framework_Active_Signals, function()
        if connections.Character then connections.Character:Disconnect() end
    end)
end

_G.Framework_Core_Update_ESP = function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then applyVisuals(p, p.Character) end
    end
end

for _, p in ipairs(Players:GetPlayers()) do registerPipeline(p) end
table.insert(_G.Framework_Active_Signals, Players.PlayerAdded:Connect(function(p)
    registerPipeline(p)
    updatePlayerDropdown()
end))

local heartbeatConnection = RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local myHum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if myHum.WalkSpeed ~= _G.SettingsMatrix.WalkSpeed then myHum.WalkSpeed = _G.SettingsMatrix.WalkSpeed end
        if myHum.JumpPower ~= _G.SettingsMatrix.JumpPower then myHum.JumpPower = _G.SettingsMatrix.JumpPower end
    end

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChildOfClass("BasePart")
            if root then
                if _G.SettingsMatrix.TargetPlayer == "ALL" or _G.SettingsMatrix.TargetPlayer == p.Name then
                    local expectedSize = Vector3.new(_G.SettingsMatrix.HitboxSize, _G.SettingsMatrix.HitboxSize, _G.SettingsMatrix.HitboxSize)
                    local expectedTrans = (_G.SettingsMatrix.HitboxTransparency / 100)
                    if root.Size ~= expectedSize or root.Transparency ~= expectedTrans then
                        root.Size = expectedSize
                        root.Transparency = expectedTrans
                        root.Color = Color3.fromRGB(255, 0, 0)
                        root.CanCollide = false
                    end
                else
                    if root.Size.X ~= 2 then root.Size = Vector3.new(2, 2, 1) root.Transparency = 1 end
                end
            end
        end
    end
end)

table.insert(_G.Framework_Active_Signals, function()
    heartbeatConnection:Disconnect()
end)

print("[System Hub]: Part 2 Complete Architecture Successfully Live.");


