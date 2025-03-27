-- Этот скрипт должен быть помещен в LocalScript внутри StarterPlayerScripts

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local VirtualUser = game:GetService("VirtualUser")

print("Script started")

-- Ожидание PlayerGui
local function getPlayerGui()
    local timeout = 10
    local elapsed = 0
    local step = 0.1
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    while not PlayerGui and elapsed < timeout do
        print("Waiting for PlayerGui... (" .. elapsed .. "/" .. timeout .. ")")
        task.wait(step)
        elapsed = elapsed + step
        PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    end
    if not PlayerGui then
        warn("Failed to find PlayerGui after " .. timeout .. " seconds!")
        return nil
    end
    print("PlayerGui found at: " .. tostring(PlayerGui))
    return PlayerGui
end

local PlayerGui = getPlayerGui()
if not PlayerGui then
    warn("Script stopped: No PlayerGui")
    return
end

-- Таблица с 100 высказываниями для Auto Spam (без изменений)
local SpamMessages = {
    "EZ win for me!", "You're too slow!", "Try harder next time!", "I'm unstoppable!", "Get good, kid!",
    "This is too easy!", "Better luck next time!", "I'm the best here!", "You can't touch me!", "Let's go again!",
    "You're out of your league!", "I own this game!", "Catch me at the top!", "No challenge for me!", "I'm on fire!",
    "You need more practice!", "This is my game!", "Too good for you!", "I'm a pro at this!", "You can't stop me!",
    "I'm the king here!", "Nice try, but not enough!", "I'm dominating!", "You're no match for me!", "I make this look easy!",
    "Keep dreaming!", "I'm the champion!", "You can't handle me!", "I'm the boss here!", "This is my playground!",
    "You're going down!", "I'm the MVP!", "Too fast for you!", "I'm a legend!", "You can't keep up!",
    "I'm the master!", "This is child's play!", "I'm untouchable!", "You're not even close!", "I'm the winner!",
    "You need more skill!", "I'm the top dog!", "This is my domain!", "You're outclassed!", "I'm the best, admit it!",
    "You can't beat me!", "I'm a beast!", "This is my victory!", "You're too weak!", "I'm the greatest!",
    "You can't compete!", "I'm the ruler here!", "This is my throne!", "You're no challenge!", "I'm the elite!",
    "You can't win!", "I'm the star here!", "This is my show!", "You're outplayed!", "I'm the pro!",
    "You can't match me!", "I'm the leader!", "This is my arena!", "You're done for!", "I'm the victor!",
    "You can't catch me!", "I'm the top player!", "This is my turf!", "You're finished!", "I'm the champ!",
    "You can't outplay me!", "I'm the best ever!", "This is my world!", "You're toast!", "I'm the ultimate!",
    "You can't survive me!", "I'm the top tier!", "This is my battle!", "You're history!", "I'm the legend here!",
    "You can't fight me!", "I'm the supreme!", "This is my stage!", "You're defeated!", "I'm the hero!",
    "You can't rival me!", "I'm the top gun!", "This is my realm!", "You're crushed!", "I'm the icon!",
    "You can't challenge me!", "I'm the best of all!", "This is my empire!", "You're beaten!", "I'm the god here!",
    "You can't oppose me!", "I'm the number one!", "This is my legacy!", "You're over!"
}

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SimpleCheatMenu_" .. tick()
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Enabled = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
print("ScreenGui created: " .. ScreenGui.Name)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
if not MainFrame.Parent then warn("MainFrame failed to parent to ScreenGui") end

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))}
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame
print("MainFrame created")

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Simple Cheat Menu"
Title.TextColor3 = Color3.fromRGB(200, 150, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = TitleBar
print("TitleBar created")

-- Вкладки для переключения секций
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -10, 0, 30)
TabBar.Position = UDim2.new(0, 5, 0, 40)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local function createTabButton(name, offset)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.2, -5, 1, 0)
    button.Position = UDim2.new(offset, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 150, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    button.Parent = TabBar
    return button
end

local ESPTab = createTabButton("ESP", 0)
local SpamTab = createTabButton("Auto Spam", 0.2)
local SpinTab = createTabButton("Spin", 0.4)
local AimbotTab = createTabButton("Aimbot", 0.6)
local MiscTab = createTabButton("Misc", 0.8)
print("Tabs created")

-- Контейнер для секций
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -10, 1, -80)
ContentFrame.Position = UDim2.new(0, 5, 0, 75)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Секции
local ESPSection = Instance.new("ScrollingFrame")
ESPSection.Size = UDim2.new(1, 0, 1, 0)
ESPSection.BackgroundTransparency = 1
ESPSection.ScrollBarThickness = 5
ESPSection.CanvasSize = UDim2.new(0, 0, 0, 750)
ESPSection.Parent = ContentFrame

local SpamSection = Instance.new("ScrollingFrame")
SpamSection.Size = UDim2.new(1, 0, 1, 0)
SpamSection.BackgroundTransparency = 1
SpamSection.ScrollBarThickness = 5
SpamSection.CanvasSize = UDim2.new(0, 0, 0, 100)
SpamSection.Visible = false
SpamSection.Parent = ContentFrame

local SpinSection = Instance.new("ScrollingFrame")
SpinSection.Size = UDim2.new(1, 0, 1, 0)
SpinSection.BackgroundTransparency = 1
SpinSection.ScrollBarThickness = 5
SpinSection.CanvasSize = UDim2.new(0, 0, 0, 100)
SpinSection.Visible = false
SpinSection.Parent = ContentFrame

local AimbotSection = Instance.new("ScrollingFrame")
AimbotSection.Size = UDim2.new(1, 0, 1, 0)
AimbotSection.BackgroundTransparency = 1
AimbotSection.ScrollBarThickness = 5
AimbotSection.CanvasSize = UDim2.new(0, 0, 0, 500)
AimbotSection.Visible = false
AimbotSection.Parent = ContentFrame

local MiscSection = Instance.new("ScrollingFrame")
MiscSection.Size = UDim2.new(1, 0, 1, 0)
MiscSection.BackgroundTransparency = 1
MiscSection.ScrollBarThickness = 5
MiscSection.CanvasSize = UDim2.new(0, 0, 0, 500) -- Увеличено для новых элементов
MiscSection.Visible = false
MiscSection.Parent = ContentFrame
print("Content sections created")

-- Функция для переключения секций
local function showSection(section)
    ESPSection.Visible = section == ESPSection
    SpamSection.Visible = section == SpamSection
    SpinSection.Visible = section == SpinSection
    AimbotSection.Visible = section == AimbotSection
    MiscSection.Visible = section == MiscSection
end

ESPTab.MouseButton1Click:Connect(function() showSection(ESPSection) end)
SpamTab.MouseButton1Click:Connect(function() showSection(SpamSection) end)
SpinTab.MouseButton1Click:Connect(function() showSection(SpinSection) end)
AimbotTab.MouseButton1Click:Connect(function() showSection(AimbotSection) end)
MiscTab.MouseButton1Click:Connect(function() showSection(MiscSection) end)
showSection(ESPSection)
print("Tab system initialized")

-- Переменные для функционала
local espEnabled = false
local boxesEnabled = false
local linesEnabled = false
local namesEnabled = false
local espDistance = 500
local lineThickness = 1
local nameSize = 20
local boxesColor = Color3.fromRGB(255, 255, 255)
local linesColor = Color3.fromRGB(255, 255, 255)
local namesColor = Color3.fromRGB(255, 255, 255)
local boxesR, boxesG, boxesB = 255, 255, 255
local linesR, linesG, linesB = 255, 255, 255
local namesR, namesG, namesB = 255, 255, 255
local spamEnabled = false
local spamDelay = 2
local spinEnabled = false
local spinSpeed = 30
local aimbotEnabled = false
local aimbotFOV = 50
local aimbotSpeed = 5
local aimbotSmoothing = 10
local aimbotDistance = 500
local aimbotTargetPart = "Head"
local aimbotKey = Enum.KeyCode.Q
local aimbotLock = false
local aimbotActive = false
local aimbotWallCheck = true
local aimbotPriority = "Distance"
local aimbotMode = "Smooth"
local aimbotAlwaysOn = false
local speedEnabled = false
local speedValue = 50
local jumpPowerEnabled = false
local jumpPowerValue = 100
local infiniteJumpEnabled = false
local noClipEnabled = false
local autoTargetEnabled = false
local autoTargetDistance = 100
local autoTargetFOV = 90
local autoTargetAttackDelay = 1 -- в миллисекундах
local autoTargetPriority = "Distance"
local autoTargetTeleportEnabled = false
local boxes = {}
local lines = {}
local nameLabels = {}
local espConnection
local spamConnection
local spinConnection
local aimbotConnection
local speedConnection
local jumpPowerConnection
local infiniteJumpConnection
local noClipConnection
local autoTargetConnection

-- ESP функционал (без изменений)
local function createESP(player)
    if player == LocalPlayer or not player.Character or not espEnabled then return end
    local char = player.Character
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude) or math.huge
    
    if distance > espDistance then
        if boxes[player] then boxes[player]:Destroy() boxes[player] = nil end
        if lines[player] then lines[player]:Remove() lines[player] = nil end
        if nameLabels[player] then nameLabels[player]:Remove() nameLabels[player] = nil end
        return
    end

    if boxesEnabled and not boxes[player] then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "SimpleESP_Box"
        box.Size = Vector3.new(4, 6, 4)
        box.Adornee = rootPart
        box.Color3 = boxesColor
        box.Transparency = 0.5
        box.AlwaysOnTop = true
        box.ZIndex = 10
        box.Parent = char
        boxes[player] = box
    end
    
    if linesEnabled and not lines[player] then
        local line = Drawing.new("Line")
        line.Visible = true
        line.Color = linesColor
        line.Thickness = lineThickness
        line.Transparency = 0.8
        lines[player] = line
    end
    
    if namesEnabled and not nameLabels[player] then
        local label = Drawing.new("Text")
        label.Visible = true
        label.Text = player.Name
        label.Size = nameSize
        label.Center = true
        label.Color = namesColor
        label.Outline = true
        label.OutlineColor = Color3.fromRGB(0, 0, 0)
        nameLabels[player] = label
    end
end

local function updateESP()
    for player, box in pairs(boxes) do
        if box and box.Adornee then
            box.Color3 = boxesColor
        end
    end
    for player, line in pairs(lines) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
            local playerPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position
            if playerPos and onScreen then
                local fromPos = workspace.CurrentCamera:WorldToViewportPoint(playerPos)
                line.From = Vector2.new(fromPos.X, fromPos.Y)
                line.To = Vector2.new(screenPos.X, screenPos.Y)
                line.Color = linesColor
                line.Thickness = lineThickness
                line.Visible = linesEnabled
            else
                line.Visible = false
            end
        else
            line:Remove()
            lines[player] = nil
        end
    end
    for player, label in pairs(nameLabels) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = player.Character.HumanoidRootPart
            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
            local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude) or math.huge
            if onScreen and distance <= espDistance then
                label.Position = Vector2.new(screenPos.X, screenPos.Y)
                label.Text = player.Name .. " [" .. math.floor(distance) .. "m]"
                label.Size = nameSize
                label.Color = namesColor
                label.Visible = namesEnabled
            else
                label.Visible = false
            end
        else
            label:Remove()
            nameLabels[player] = nil
        end
    end
end

local function clearESP()
    for _, box in pairs(boxes) do if box then box:Destroy() end end
    for _, line in pairs(lines) do line:Remove() end
    for _, label in pairs(nameLabels) do label:Remove() end
    boxes = {}
    lines = {}
    nameLabels = {}
    print("ESP cleared")
end

-- Auto Spam функционал (без изменений)
local function sendChatMessage(message)
    local success, err = pcall(function()
        if ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") then
            ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
            return true
        end
        if TextChatService and TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local textChannels = TextChatService:FindFirstChild("TextChannels")
            if textChannels then
                local channel = textChannels:FindFirstChild("RBXGeneral") or textChannels:GetChildren()[1]
                if channel then
                    channel:SendAsync(message)
                    return true
                end
            end
        end
        return false
    end)
    if not success then warn("Failed to send message: " .. tostring(err)) end
    return success
end

local function startSpam()
    if spamConnection then spamConnection:Disconnect() end
    spamConnection = task.spawn(function()
        while spamEnabled do
            local message = SpamMessages[math.random(1, #SpamMessages)]
            sendChatMessage(message)
            task.wait(spamDelay)
        end
    end)
end

-- Spin функционал (без изменений)
local function startSpin()
    if spinConnection then spinConnection:Disconnect() end
    spinConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local camera = workspace.CurrentCamera
        local isShiftLock = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
        if isShiftLock then
            local currentCameraCFrame = camera.CFrame
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed * deltaTime), 0)
            camera.CFrame = currentCameraCFrame
        else
            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed * deltaTime), 0)
        end
    end)
end

local function stopSpin()
    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end
end

-- Aimbot и AutoTarget общие функции
local function isVisible(targetPart)
    local camera = workspace.CurrentCamera
    local rayOrigin = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position or camera.CFrame.Position
    local rayDirection = (targetPart.Position - rayOrigin).Unit * autoTargetDistance
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    return not raycastResult or raycastResult.Instance:IsDescendantOf(targetPart.Parent)
end

local function getBestTarget()
    local camera = workspace.CurrentCamera
    local bestTarget = nil
    local bestScore = math.huge
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if not myRoot then return nil end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
            local targetRoot = player.Character.HumanoidRootPart
            local targetHumanoid = player.Character.Humanoid
            local distance = (myRoot.Position - targetRoot.Position).Magnitude
            local direction = (targetRoot.Position - myRoot.Position).Unit
            local forwardVector = myRoot.CFrame.LookVector
            local angle = math.deg(math.acos(direction:Dot(forwardVector)))

            -- Проверка условий: дистанция, FOV, здоровье, видимость, не союзник
            if distance <= autoTargetDistance and angle <= autoTargetFOV and targetHumanoid.Health > 0 and isVisible(targetRoot) and player.Team ~= LocalPlayer.Team then
                local score
                if autoTargetPriority == "Distance" then
                    score = distance
                elseif autoTargetPriority == "Health" then
                    score = targetHumanoid.Health
                end
                if score < bestScore then
                    bestScore = score
                    bestTarget = player
                end
            end
        end
    end
    return bestTarget
end

local lockedTarget = nil
local function startAimbot()
    if aimbotConnection then aimbotConnection:Disconnect() end
    aimbotConnection = RunService.RenderStepped:Connect(function(deltaTime)
        if not aimbotEnabled or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            lockedTarget = nil
            return
        end

        if not aimbotAlwaysOn and not aimbotActive then
            lockedTarget = nil
            return
        end

        local targetPlayer = aimbotLock and lockedTarget or getBestTarget()
        if not targetPlayer and aimbotLock then
            lockedTarget = nil
            targetPlayer = getBestTarget()
        end

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild(aimbotTargetPart) then
            lockedTarget = targetPlayer
            local targetPart = targetPlayer.Character[aimbotTargetPart]
            local camera = workspace.CurrentCamera
            local currentCFrame = camera.CFrame
            local targetCFrame = CFrame.new(currentCFrame.Position, targetPart.Position)

            if aimbotMode == "Smooth" then
                local lerpFactor = math.clamp(aimbotSpeed / aimbotSmoothing, 0, 1) * deltaTime * 60
                camera.CFrame = currentCFrame:Lerp(targetCFrame, lerpFactor)
            elseif aimbotMode == "Instant" then
                camera.CFrame = targetCFrame
            end
        end
    end)
end

-- Misc функционал
local defaultWalkSpeed = 16
local defaultJumpPower = 50

local function startSpeedHack()
    if speedConnection then speedConnection:Disconnect() end
    speedConnection = RunService.Heartbeat:Connect(function()
        if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
        end
    end)
end

local function stopSpeedHack()
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = defaultWalkSpeed
    end
end

local function startJumpPower()
    if jumpPowerConnection then jumpPowerConnection:Disconnect() end
    jumpPowerConnection = RunService.Heartbeat:Connect(function()
        if jumpPowerEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = jumpPowerValue
        end
    end)
end

local function stopJumpPower()
    if jumpPowerConnection then
        jumpPowerConnection:Disconnect()
        jumpPowerConnection = nil
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = defaultJumpPower
    end
end

local function startInfiniteJump()
    if infiniteJumpConnection then infiniteJumpConnection:Disconnect() end
    infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function stopInfiniteJump()
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
        infiniteJumpConnection = nil
    end
end

local function startNoClip()
    if noClipConnection then noClipConnection:Disconnect() end
    noClipConnection = RunService.Stepped:Connect(function()
        if noClipEnabled and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function stopNoClip()
    if noClipConnection then
        noClipConnection:Disconnect()
        noClipConnection = nil
    end
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Улучшенный AutoTarget функционал
local function startAutoTarget()
    if autoTargetConnection then autoTargetConnection:Disconnect() end
    autoTargetConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not autoTargetEnabled or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Humanoid") or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return
        end

        local humanoid = LocalPlayer.Character.Humanoid
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        local camera = workspace.CurrentCamera
        local target = getBestTarget()

        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos = target.Character.HumanoidRootPart.Position
            local distance = (rootPart.Position - targetPos).Magnitude

            -- Поворот персонажа к цели
            local lookAtCFrame = CFrame.new(rootPart.Position, Vector3.new(targetPos.X, rootPart.Position.Y, targetPos.Z))
            rootPart.CFrame = rootPart.CFrame:Lerp(lookAtCFrame, 0.5)

            -- Движение или телепортация
            if autoTargetTeleportEnabled and distance > 10 then
                rootPart.CFrame = CFrame.new(targetPos + (rootPart.Position - targetPos).Unit * 5) -- Телепорт на расстояние 5 от цели
            else
                humanoid:MoveTo(targetPos)
            end

            -- Атака и наведение камеры
            if isVisible(target.Character.HumanoidRootPart) then
                -- Наведение камеры (интеграция с аимботом)
                local targetCFrame = CFrame.new(camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.5)

                -- Атака
                VirtualUser:ClickButton1(Vector2.new())
                task.wait(autoTargetAttackDelay / 1000) -- Кулдаун в секундах
            end
        end
    end)
end

local function stopAutoTarget()
    if autoTargetConnection then
        autoTargetConnection:Disconnect()
        autoTargetConnection = nil
    end
end

-- Функция для создания переключателя
local function createToggle(parent, name, posY, defaultState, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -10, 0, 30)
    toggle.Position = UDim2.new(0, 5, 0, posY)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggle.Text = name .. ": " .. (defaultState and "ON" or "OFF")
    toggle.TextColor3 = Color3.fromRGB(200, 150, 255)
    toggle.Font = Enum.Font.GothamSemibold
    toggle.TextSize = 14
    toggle.Parent = parent
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = toggle

    local state = defaultState
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = name .. ": " .. (state and "ON" or "OFF")
        toggle.BackgroundColor3 = state and Color3.fromRGB(100, 70, 140) or Color3.fromRGB(50, 50, 50)
        if callback then callback(state) end
    end)

    toggle.MouseEnter:Connect(function()
        toggle.BackgroundColor3 = state and Color3.fromRGB(120, 90, 160) or Color3.fromRGB(60, 60, 60)
    end)
    toggle.MouseLeave:Connect(function()
        toggle.BackgroundColor3 = state and Color3.fromRGB(100, 70, 140) or Color3.fromRGB(50, 50, 50)
    end)

    return toggle
end

-- Функция для создания слайдера
local function createSlider(parent, label, posY, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.Position = UDim2.new(0, 5, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(1, 0, 0, 20)
    labelText.BackgroundTransparency = 1
    labelText.Text = label .. ": " .. default
    labelText.TextColor3 = Color3.fromRGB(200, 150, 255)
    labelText.Font = Enum.Font.GothamSemibold
    labelText.TextSize = 12
    labelText.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 10)
    slider.Position = UDim2.new(0, 0, 0, 20)
    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    slider.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = slider

    local grab = Instance.new("Frame")
    grab.Size = UDim2.new(0, 15, 0, 15)
    grab.Position = UDim2.new((default - min) / (max - min), -7.5, 0, -2.5)
    grab.BackgroundColor3 = Color3.fromRGB(100, 70, 140)
    grab.Parent = slider
    local grabCorner = Instance.new("UICorner")
    grabCorner.CornerRadius = UDim.new(0, 8)
    grabCorner.Parent = grab

    local value = default
    local dragging = false

    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local mouseConnection
            mouseConnection = UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                    local percent = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    value = math.floor(min + percent * (max - min))
                    grab.Position = UDim2.new(percent, -7.5, 0, -2.5)
                    labelText.Text = label .. ": " .. value
                    callback(value)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    mouseConnection:Disconnect()
                end
            end)
        end
    end)

    return frame, value
end

-- Функция для создания кнопки выбора части тела
local function createTargetPartSelector(parent, posY)
    local parts = {"Head", "Torso", "HumanoidRootPart"}
    local currentIndex = 1

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.Position = UDim2.new(0, 5, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Target Part:"
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.6, 0, 1, 0)
    button.Position = UDim2.new(0.4, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = parts[currentIndex]
    button.TextColor3 = Color3.fromRGB(200, 150, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        currentIndex = (currentIndex % #parts) + 1
        button.Text = parts[currentIndex]
        aimbotTargetPart = parts[currentIndex]
        print("Aimbot Target Part set to: " .. aimbotTargetPart)
    end)

    return frame
end

-- Функция для настройки клавиши Aimbot
local function createKeybindSelector(parent, posY)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.Position = UDim2.new(0, 5, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Aimbot Key:"
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.6, 0, 1, 0)
    button.Position = UDim2.new(0.4, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = aimbotKey.Name
    button.TextColor3 = Color3.fromRGB(200, 150, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    local waitingForInput = false
    button.MouseButton1Click:Connect(function()
        if waitingForInput then return end
        waitingForInput = true
        button.Text = "Press a key..."
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                aimbotKey = input.KeyCode
                button.Text = aimbotKey.Name
                waitingForInput = false
                connection:Disconnect()
                print("Aimbot Key set to: " .. aimbotKey.Name)
            end
        end)
    end)

    return frame
end

-- Функция для выбора приоритета
local function createPrioritySelector(parent, posY, defaultPriority, callback)
    local priorities = {"Distance", "Health"}
    local currentIndex = defaultPriority == "Distance" and 1 or 2

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.Position = UDim2.new(0, 5, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Priority:"
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.6, 0, 1, 0)
    button.Position = UDim2.new(0.4, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = priorities[currentIndex]
    button.TextColor3 = Color3.fromRGB(200, 150, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        currentIndex = (currentIndex % #priorities) + 1
        button.Text = priorities[currentIndex]
        callback(priorities[currentIndex])
        print("Priority set to: " .. priorities[currentIndex])
    end)

    return frame
end

-- Функция для выбора режима аима
local function createModeSelector(parent, posY)
    local modes = {"Smooth", "Instant"}
    local currentIndex = 1

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 30)
    frame.Position = UDim2.new(0, 5, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Aim Mode:"
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.6, 0, 1, 0)
    button.Position = UDim2.new(0.4, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Text = modes[currentIndex]
    button.TextColor3 = Color3.fromRGB(200, 150, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseButton1Click:Connect(function()
        currentIndex = (currentIndex % #modes) + 1
        button.Text = modes[currentIndex]
        aimbotMode = modes[currentIndex]
        print("Aimbot Mode set to: " .. aimbotMode)
    end)

    return frame
end

-- Функция для выбора игрока для телепорта
local function createTeleportSelector(parent, posY)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.Position = UDim2.new(0, 5, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Teleport to Player:"
    label.TextColor3 = Color3.fromRGB(200, 150, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.Parent = frame

    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(1, 0, 0, 30)
    dropdown.Position = UDim2.new(0, 0, 0, 20)
    dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdown.Text = "Select Player"
    dropdown.TextColor3 = Color3.fromRGB(200, 150, 255)
    dropdown.Font = Enum.Font.GothamSemibold
    dropdown.TextSize = 14
    dropdown.Parent = frame
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = dropdown

    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
    dropdownFrame.Position = UDim2.new(0, 0, 1, 0)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdownFrame.BorderSizePixel = 0
    dropdownFrame.Visible = false
    dropdownFrame.Parent = dropdown
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = dropdownFrame

    local function updateDropdown()
        for _, child in pairs(dropdownFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        local players = Players:GetPlayers()
        dropdownFrame.Size = UDim2.new(1, 0, 0, #players * 30)
        for i, player in pairs(players) do
            if player ~= LocalPlayer then
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(1, 0, 0, 30)
                button.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
                button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                button.Text = player.Name
                button.TextColor3 = Color3.fromRGB(200, 150, 255)
                button.Font = Enum.Font.GothamSemibold
                button.TextSize = 14
                button.Parent = dropdownFrame
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 6)
                btnCorner.Parent = button

                button.MouseButton1Click:Connect(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                        print("Teleported to: " .. player.Name)
                    end
                    dropdownFrame.Visible = false
                    dropdown.Text = player.Name
                end)
            end
        end
    end

    dropdown.MouseButton1Click:Connect(function()
        dropdownFrame.Visible = not dropdownFrame.Visible
        if dropdownFrame.Visible then updateDropdown() end
    end)

    return frame
end

-- Настройки для ESP (без изменений)
local ESPToggle = createToggle(ESPSection, "ESP", 0, false, function(state)
    espEnabled = state
    if not espEnabled then
        clearESP()
        if espConnection then espConnection:Disconnect() espConnection = nil end
    else
        if espConnection then espConnection:Disconnect() end
        espConnection = RunService.RenderStepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                createESP(player)
            end
            updateESP()
        end)
    end
    print("ESP toggled: " .. tostring(espEnabled))
end)

local BoxesToggle = createToggle(ESPSection, "Boxes", 35, false, function(state)
    boxesEnabled = state
    print("Boxes toggled: " .. tostring(boxesEnabled))
end)

local LinesToggle = createToggle(ESPSection, "Lines", 70, false, function(state)
    linesEnabled = state
    print("Lines toggled: " .. tostring(linesEnabled))
end)

local NamesToggle = createToggle(ESPSection, "Names", 105, false, function(state)
    namesEnabled = state
    print("Names toggled: " .. tostring(namesEnabled))
end)

local ESPDistanceSlider = createSlider(ESPSection, "Distance", 140, 100, 2000, 500, function(value)
    espDistance = value
    print("ESP Distance set to: " .. value)
end)

local LineThicknessSlider = createSlider(ESPSection, "Line Thickness", 185, 1, 10, 1, function(value)
    lineThickness = value
    print("Line Thickness set to: " .. value)
end)

local NameSizeSlider = createSlider(ESPSection, "Name Size", 230, 10, 50, 20, function(value)
    nameSize = value
    print("Name Size set to: " .. value)
end)

local BoxesColorLabel = Instance.new("TextLabel")
BoxesColorLabel.Size = UDim2.new(1, -10, 0, 20)
BoxesColorLabel.Position = UDim2.new(0, 5, 0, 275)
BoxesColorLabel.BackgroundTransparency = 1
BoxesColorLabel.Text = "Boxes Color (RGB)"
BoxesColorLabel.TextColor3 = Color3.fromRGB(200, 150, 255)
BoxesColorLabel.Font = Enum.Font.GothamSemibold
BoxesColorLabel.TextSize = 12
BoxesColorLabel.Parent = ESPSection

local BoxesRSlider = createSlider(ESPSection, "R", 300, 0, 255, 255, function(value)
    boxesR = value
    boxesColor = Color3.fromRGB(boxesR, boxesG, boxesB)
    print("Boxes Color R set to: " .. value)
end)

local BoxesGSlider = createSlider(ESPSection, "G", 345, 0, 255, 255, function(value)
    boxesG = value
    boxesColor = Color3.fromRGB(boxesR, boxesG, boxesB)
    print("Boxes Color G set to: " .. value)
end)

local BoxesBSlider = createSlider(ESPSection, "B", 390, 0, 255, 255, function(value)
    boxesB = value
    boxesColor = Color3.fromRGB(boxesR, boxesG, boxesB)
    print("Boxes Color B set to: " .. value)
end)

local LinesColorLabel = Instance.new("TextLabel")
LinesColorLabel.Size = UDim2.new(1, -10, 0, 20)
LinesColorLabel.Position = UDim2.new(0, 5, 0, 435)
LinesColorLabel.BackgroundTransparency = 1
LinesColorLabel.Text = "Lines Color (RGB)"
LinesColorLabel.TextColor3 = Color3.fromRGB(200, 150, 255)
LinesColorLabel.Font = Enum.Font.GothamSemibold
LinesColorLabel.TextSize = 12
LinesColorLabel.Parent = ESPSection

local LinesRSlider = createSlider(ESPSection, "R", 460, 0, 255, 255, function(value)
    linesR = value
    linesColor = Color3.fromRGB(linesR, linesG, linesB)
    print("Lines Color R set to: " .. value)
end)

local LinesGSlider = createSlider(ESPSection, "G", 505, 0, 255, 255, function(value)
    linesG = value
    linesColor = Color3.fromRGB(linesR, linesG, linesB)
    print("Lines Color G set to: " .. value)
end)

local LinesBSlider = createSlider(ESPSection, "B", 550, 0, 255, 255, function(value)
    linesB = value
    linesColor = Color3.fromRGB(linesR, linesG, linesB)
    print("Lines Color B set to: " .. value)
end)

local NamesColorLabel = Instance.new("TextLabel")
NamesColorLabel.Size = UDim2.new(1, -10, 0, 20)
NamesColorLabel.Position = UDim2.new(0, 5, 0, 595)
NamesColorLabel.BackgroundTransparency = 1
NamesColorLabel.Text = "Names Color (RGB)"
NamesColorLabel.TextColor3 = Color3.fromRGB(200, 150, 255)
NamesColorLabel.Font = Enum.Font.GothamSemibold
NamesColorLabel.TextSize = 12
NamesColorLabel.Parent = ESPSection

local NamesRSlider = createSlider(ESPSection, "R", 620, 0, 255, 255, function(value)
    namesR = value
    namesColor = Color3.fromRGB(namesR, namesG, namesB)
    print("Names Color R set to: " .. value)
end)

local NamesGSlider = createSlider(ESPSection, "G", 665, 0, 255, 255, function(value)
    namesG = value
    namesColor = Color3.fromRGB(namesR, namesG, namesB)
    print("Names Color G set to: " .. value)
end)

local NamesBSlider = createSlider(ESPSection, "B", 710, 0, 255, 255, function(value)
    namesB = value
    namesColor = Color3.fromRGB(namesR, namesG, namesB)
    print("Names Color B set to: " .. value)
end)

-- Настройки для Auto Spam (без изменений)
local AutoSpamToggle = createToggle(SpamSection, "Auto Spam", 0, false, function(state)
    spamEnabled = state
    if state then
        startSpam()
    else
        if spamConnection then spamConnection:Disconnect() spamConnection = nil end
    end
    print("Auto Spam toggled: " .. tostring(spamEnabled))
end)

local SpamDelaySlider = createSlider(SpamSection, "Delay (sec)", 35, 1, 10, 2, function(value)
    spamDelay = value
    print("Spam Delay set to: " .. value)
end)

-- Настройки для Spin (без изменений)
local SpinToggle = createToggle(SpinSection, "Spin", 0, false, function(state)
    spinEnabled = state
    if state then
        startSpin()
    else
        stopSpin()
    end
    print("Spin toggled: " .. tostring(spinEnabled))
end)

local SpinSpeedSlider = createSlider(SpinSection, "Spin Speed", 35, 10, 5000, 30, function(value)
    spinSpeed = value
    print("Spin Speed set to: " .. value)
end)

-- Настройки для Aimbot (без изменений)
local AimbotToggle = createToggle(AimbotSection, "Aimbot", 0, false, function(state)
    aimbotEnabled = state
    if state then
        startAimbot()
    else
        if aimbotConnection then aimbotConnection:Disconnect() aimbotConnection = nil end
        lockedTarget = nil
    end
    print("Aimbot toggled: " .. tostring(aimbotEnabled))
end)

local AimbotFOVSlider = createSlider(AimbotSection, "FOV", 35, 10, 200, 50, function(value)
    aimbotFOV = value
    print("Aimbot FOV set to: " .. value)
end)

local AimbotSpeedSlider = createSlider(AimbotSection, "Speed", 80, 1, 50, 5, function(value)
    aimbotSpeed = value
    print("Aimbot Speed set to: " .. value)
end)

local AimbotSmoothingSlider = createSlider(AimbotSection, "Smoothing", 125, 1, 20, 10, function(value)
    aimbotSmoothing = value
    print("Aimbot Smoothing set to: " .. value)
end)

local AimbotDistanceSlider = createSlider(AimbotSection, "Distance", 170, 100, 2000, 500, function(value)
    aimbotDistance = value
    print("Aimbot Distance set to: " .. value)
end)

local AimbotTargetPartSelector = createTargetPartSelector(AimbotSection, 215)

local AimbotLockToggle = createToggle(AimbotSection, "Lock Target", 250, false, function(state)
    aimbotLock = state
    if not state then lockedTarget = nil end
    print("Aimbot Lock toggled: " .. tostring(aimbotLock))
end)

local AimbotWallCheckToggle = createToggle(AimbotSection, "Wall Check", 285, true, function(state)
    aimbotWallCheck = state
    print("Aimbot Wall Check toggled: " .. tostring(aimbotWallCheck))
end)

local AimbotPrioritySelector = createPrioritySelector(AimbotSection, 320, aimbotPriority, function(value)
    aimbotPriority = value
end)

local AimbotModeSelector = createModeSelector(AimbotSection, 355)

local AimbotAlwaysOnToggle = createToggle(AimbotSection, "Always On", 390, false, function(state)
    aimbotAlwaysOn = state
    print("Aimbot Always On toggled: " .. tostring(aimbotAlwaysOn))
end)

local AimbotKeybindSelector = createKeybindSelector(AimbotSection, 425)

-- Настройки для Misc
local SpeedToggle = createToggle(MiscSection, "Speed Hack", 0, false, function(state)
    speedEnabled = state
    if state then
        startSpeedHack()
    else
        stopSpeedHack()
    end
    print("Speed Hack toggled: " .. tostring(speedEnabled))
end)

local SpeedSlider = createSlider(MiscSection, "Speed", 35, 16, 200, 50, function(value)
    speedValue = value
    print("Speed set to: " .. value)
end)

local JumpPowerToggle = createToggle(MiscSection, "Jump Power", 80, false, function(state)
    jumpPowerEnabled = state
    if state then
        startJumpPower()
    else
        stopJumpPower()
    end
    print("Jump Power toggled: " .. tostring(jumpPowerEnabled))
end)

local JumpPowerSlider = createSlider(MiscSection, "Jump Power", 115, 50, 200, 100, function(value)
    jumpPowerValue = value
    print("Jump Power set to: " .. value)
end)

local InfiniteJumpToggle = createToggle(MiscSection, "Infinite Jump", 160, false, function(state)
    infiniteJumpEnabled = state
    if state then
        startInfiniteJump()
    else
        stopInfiniteJump()
    end
    print("Infinite Jump toggled: " .. tostring(infiniteJumpEnabled))
end)

local NoClipToggle = createToggle(MiscSection, "NoClip", 195, false, function(state)
    noClipEnabled = state
    if state then
        startNoClip()
    else
        stopNoClip()
    end
    print("NoClip toggled: " .. tostring(noClipEnabled))
end)

local TeleportSelector = createTeleportSelector(MiscSection, 230)

local AutoTargetToggle = createToggle(MiscSection, "Auto Target", 295, false, function(state)
    autoTargetEnabled = state
    if state then
        startAutoTarget()
    else
        stopAutoTarget()
    end
    print("Auto Target toggled: " .. tostring(autoTargetEnabled))
end)

local AutoTargetDistanceSlider = createSlider(MiscSection, "Target Distance", 330, 10, 200, 100, function(value)
    autoTargetDistance = value
    print("Auto Target Distance set to: " .. value)
end)

local AutoTargetFOVSlider = createSlider(MiscSection, "Target FOV", 375, 10, 180, 90, function(value)
    autoTargetFOV = value
    print("Auto Target FOV set to: " .. value)
end)

local AutoTargetAttackDelaySlider = createSlider(MiscSection, "Attack Delay (ms)", 420, 1, 1000, 1, function(value)
    autoTargetAttackDelay = value
    print("Auto Target Attack Delay set to: " .. value .. "ms")
end)

local AutoTargetPrioritySelector = createPrioritySelector(MiscSection, 465, autoTargetPriority, function(value)
    autoTargetPriority = value
end)

local AutoTargetTeleportToggle = createToggle(MiscSection, "Teleport to Target", 500, false, function(state)
    autoTargetTeleportEnabled = state
    print("Auto Target Teleport toggled: " .. tostring(autoTargetTeleportEnabled))
end)

-- Перетаскивание меню
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        print("Dragging started")
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        print("Dragging stopped")
    end
end)

-- Горячие клавиши
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then
        MainFrame.Visible = not MainFrame.Visible
        print("Menu visibility toggled: " .. tostring(MainFrame.Visible))
    elseif input.KeyCode == aimbotKey then
        aimbotActive = true
        print("Aimbot activated")
    elseif input.KeyCode == Enum.KeyCode.P then
        if espConnection then espConnection:Disconnect() end
        if spamConnection then spamConnection:Disconnect() end
        if spinConnection then spinConnection:Disconnect() end
        if aimbotConnection then aimbotConnection:Disconnect() end
        if speedConnection then speedConnection:Disconnect() end
        if jumpPowerConnection then jumpPowerConnection:Disconnect() end
        if infiniteJumpConnection then infiniteJumpConnection:Disconnect() end
        if noClipConnection then noClipConnection:Disconnect() end
        if autoTargetConnection then autoTargetConnection:Disconnect() end
        clearESP()
        ScreenGui:Destroy()
        print("Script terminated by user")
        script.Disabled = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == aimbotKey then
        aimbotActive = false
        print("Aimbot deactivated")
    end
end)

-- Обновление ESP при появлении новых игроков
Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        createESP(player)
    end
    player.CharacterAdded:Connect(function()
        if espEnabled then
            createESP(player)
        end
    end)
end)

-- Очистка ESP при выходе игрока
Players.PlayerRemoving:Connect(function(player)
    if boxes[player] then boxes[player]:Destroy() boxes[player] = nil end
    if lines[player] then lines[player]:Remove() lines[player] = nil end
    if nameLabels[player] then nameLabels[player]:Remove() nameLabels[player] = nil end
    print("Player removed: " .. player.Name)
end)

-- Обновление при респавне локального игрока
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if espEnabled then
        clearESP()
        for _, player in pairs(Players:GetPlayers()) do
            createESP(player)
        end
    end
    if spinEnabled then
        startSpin()
    end
    if aimbotEnabled then
        startAimbot()
    end
    if speedEnabled then
        startSpeedHack()
    end
    if jumpPowerEnabled then
        startJumpPower()
    end
    if infiniteJumpEnabled then
        startInfiniteJump()
    end
    if noClipEnabled then
        startNoClip()
    end
    if autoTargetEnabled then
        startAutoTarget()
    end
    print("LocalPlayer character respawned")
end)

-- Тестовая активация меню
task.spawn(function()
    task.wait(1)
    MainFrame.Visible = true
    print("Menu should now be visible")
end)

print("Script initialization complete")
