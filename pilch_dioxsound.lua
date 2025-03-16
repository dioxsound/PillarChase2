-- Сервисы Roblox
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Создание кастомной заставки
local SplashScreen = Instance.new("ScreenGui")
SplashScreen.Name = "DioxsoundSplashScreen"
SplashScreen.IgnoreGuiInset = true
SplashScreen.Parent = CoreGui

-- Фон
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Background.BorderSizePixel = 0
Background.Parent = SplashScreen

-- Градиентный фон
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                                    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))})
Gradient.Rotation = 45
Gradient.Parent = Background

-- Текст "DXSNDHUB"
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(0, 400, 0, 100)
LogoLabel.Position = UDim2.new(0.5, 0, 0.4, 0)
LogoLabel.AnchorPoint = Vector2.new(0.5, 0.5)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "DXSNDHUB"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.TextSize = 60
LogoLabel.Font = Enum.Font.GothamBlack
LogoLabel.TextTransparency = 1
LogoLabel.Parent = Background

-- Подзаголовок "telegram: @DXSNDHUB"
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(0, 400, 0, 50)
SubtitleLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
SubtitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "telegram: @DXSNDHUB"
SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SubtitleLabel.TextSize = 30
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextTransparency = 1
SubtitleLabel.Parent = Background

-- Прогресс-бар
local ProgressBarFrame = Instance.new("Frame")
ProgressBarFrame.Size = UDim2.new(0, 300, 0, 20)
ProgressBarFrame.Position = UDim2.new(0.5, 0, 0.6, 0)
ProgressBarFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ProgressBarFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressBarFrame.BorderSizePixel = 0
ProgressBarFrame.Parent = Background

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressBarFrame

-- Анимация появления текста
local fadeInTween = TweenService:Create(LogoLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    TextTransparency = 0
})
local subtitleFadeInTween = TweenService:Create(SubtitleLabel,
    TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 0
    })
fadeInTween:Play()
wait(0.5)
subtitleFadeInTween:Play()

-- Анимация волны для текста
local waveTween = TweenService:Create(LogoLabel,
    TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        TextSize = 65
    })
waveTween:Play()

-- Анимация прогресс-бара
local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {
    Size = UDim2.new(1, 0, 1, 0)
})
progressTween:Play()

-- Ждём завершения анимации
wait(3)

-- Анимация исчезновения
local fadeOutTween = TweenService:Create(LogoLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
    TextTransparency = 1
})
local subtitleFadeOutTween = TweenService:Create(SubtitleLabel,
    TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        TextTransparency = 1
    })
fadeOutTween:Play()
subtitleFadeOutTween:Play()
wait(1)

-- Удаляем заставку
SplashScreen:Destroy()

-- Загрузка Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

if not Rayfield then
    warn("Не удалось загрузить Rayfield!")
    return
end

-- Создание окна Rayfield
local Window = Rayfield:CreateWindow({
    Name = "DXSNDHUB 🎶",
    LoadingTitle = "DXSNDHUB",
    LoadingSubtitle = "telegram: @dioxsound",
    KeySystem = false
})

-- Установка бесконечной стамины
local function setInfiniteStamina()
    local players = game:GetService("Players")
    local function setupStamina(character)
        local stamina = character:WaitForChild("Aspects", 5)
        if stamina then
            stamina = stamina:WaitForChild("Stamina", 5)
            if stamina then
                stamina.Max.Value = 100
                stamina.RegenAmount.Value = 100
                stamina.RegenSpeed.Value = 100
                stamina.DrainAmount.Value = 0
                stamina.DrainSpeed.Value = 0
                spawn(function()
                    while stamina and stamina.Parent do
                        stamina.Value = stamina.Max.Value
                        task.wait(0.01)
                    end
                end)
            end
        end
    end
    local function onCharacterAdded(player)
        player.CharacterAdded:Connect(setupStamina)
        if player.Character then
            setupStamina(player.Character)
        end
    end
    for _, player in ipairs(players:GetPlayers()) do
        onCharacterAdded(player)
    end
    players.PlayerAdded:Connect(onCharacterAdded)
end

-- Установка полного освещения
local function setFullLighting()
    local lighting = game:GetService("Lighting")
    local ambientColor = Color3.fromRGB(255, 255, 255)
    local density, offset, glare, haze = 0.1, 0, 0, 0
    local atmosphereColor = Color3.fromRGB(255, 255, 255)
    local function applyLighting()
        lighting.Ambient = ambientColor
        lighting.Atmosphere.Density = density
        lighting.Atmosphere.Offset = offset
        lighting.Atmosphere.Glare = glare
        lighting.Atmosphere.Haze = haze
        lighting.Atmosphere.Color = atmosphereColor
    end
    spawn(function()
        while true do
            if lighting.Ambient ~= ambientColor then
                applyLighting()
            end
            wait(0.1)
        end
    end)
    applyLighting()
end

-- Установка максимального количества монет
local function setMaxCoins()
    local coinValue = 90
    local function updateCoins()
        local localPlayer = game.Players.LocalPlayer
        if localPlayer then
            local coins = localPlayer:FindFirstChild("CoinsToGive")
            if not coins then
                coins = Instance.new("IntValue")
                coins.Name = "CoinsToGive"
                coins.Value = coinValue
                coins.Parent = localPlayer
            elseif coins.Value < coinValue then
                coins.Value = coinValue
            end
        end
    end
    spawn(function()
        while true do
            task.wait()
            updateCoins()
        end
    end)
end

-- Анти-АФК система
local function createAntiAFK()
    local inputManager = game:GetService("VirtualInputManager")
    local movementKeys = {Enum.KeyCode.W, Enum.KeyCode.D, Enum.KeyCode.S, Enum.KeyCode.A}
    local isActive = false
    local function simulateMovement()
        while isActive do
            local character = game.Players.LocalPlayer.Character
            local humanoid = character and character:FindFirstChild("Humanoid")
            if humanoid and character:FindFirstChild("HumanoidRootPart") then
                for _, key in ipairs(movementKeys) do
                    if not isActive then
                        break
                    end
                    inputManager:SendKeyEvent(true, key, false, game)
                    task.wait(0.5)
                    inputManager:SendKeyEvent(false, key, false, game)
                    task.wait(0.1)
                end
            end
            task.wait(1)
        end
    end
    return function(state)
        isActive = state
        if state then
            spawn(simulateMovement)
        end
    end
end

-- ESP
_G.ESPEnabled = false
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local function createESP(player)
    if not _G.ESPEnabled or player == localPlayer or not player.Character then
        return
    end
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESPHighlight"
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.fromRGB(0, 255, 0)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = player.Character
end

local function removeESP(player)
    if player.Character then
        local highlight = player.Character:FindFirstChild("ESPHighlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

function toggleESP(state)
    _G.ESPEnabled = state
    for _, player in pairs(players:GetPlayers()) do
        if player ~= localPlayer then
            if state then
                createESP(player)
            else
                removeESP(player)
            end
        end
    end
end

players.PlayerAdded:Connect(function(player)
    if player ~= localPlayer then
        player.CharacterAdded:Connect(function()
            if _G.ESPEnabled then
                createESP(player)
            end
        end)
        player.CharacterRemoving:Connect(function()
            removeESP(player)
        end)
        if _G.ESPEnabled and player.Character then
            createESP(player)
        end
    end
end)

for _, player in pairs(players:GetPlayers()) do
    if player ~= localPlayer then
        player.CharacterAdded:Connect(function()
            if _G.ESPEnabled then
                createESP(player)
            end
        end)
        player.CharacterRemoving:Connect(function()
            removeESP(player)
        end)
        if _G.ESPEnabled and player.Character then
            createESP(player)
        end
    end
end

-- Авто-покупка Greedy
-- Авто-покупка Greedy
local playerGui = localPlayer.PlayerGui
local upgradesFolder = localPlayer:FindFirstChild("Upgrades")
local autoGreedyEnabled = false
local autoGreedyThread = nil

local function checkGreedy()
    if not upgradesFolder then
        warn("Upgrades folder not found!")
        return 0
    end
    -- Получаем все объекты с именем "Greedy"
    local greedyCount = 0
    for _, obj in pairs(upgradesFolder:GetChildren()) do
        if obj.Name == "Greedy" then
            local isOwned = (obj:IsA("BoolValue") and obj.Value) or
                            (obj:IsA("IntValue") and obj.Value == 1) or
                            (obj:IsA("StringValue") and (obj.Value == "true" or obj.Value == "owned"))
            if isOwned then
                greedyCount = greedyCount + 1
            end
            print("Found Greedy object:", obj.Name, "Type:", obj.ClassName, "Value:", obj.Value, "Is Owned:", isOwned)
        end
    end
    print("Total Greedy count:", greedyCount)
    return greedyCount -- Возвращаем количество купленных "Greedy"
end

local function buyGreedy()
    local success, buyEvent = pcall(function()
        return playerGui:WaitForChild("LobbyGUI", 5):WaitForChild("WorkSHOP", 5):WaitForChild("BuyItem", 5)
    end)
    if not success or not buyEvent then
        warn("Failed to find BuyItem RemoteEvent:", buyEvent)
        return
    end
    if not buyEvent:IsA("RemoteEvent") then
        warn("BuyItem is not a RemoteEvent!")
        return
    end
    if checkGreedy() == 0 then
        local successArgs, args = pcall(function()
            local upgradeGreedy = playerGui:WaitForChild("LobbyGUI"):WaitForChild("WorkSHOP"):WaitForChild("Upgrades"):WaitForChild("Greedy")
            print("Attempting to buy Greedy with args:", upgradeGreedy, 30, "Greedy")
            return {upgradeGreedy, 30, "Greedy"}
        end)
        if successArgs then
            print("Firing BuyItem RemoteEvent with args:", unpack(args))
            buyEvent:FireServer(unpack(args))
            wait(1) -- Даём игре время обработать покупку
            if checkGreedy() > 0 then
                print("Greedy successfully purchased!")
                Rayfield:Notify({
                    Title = "Авто-покупка",
                    Content = "Greedy успешно куплен!",
                    Duration = 3,
                    Image = "shopping-cart"
                })
            else
                warn("Greedy purchase failed - not detected after purchase attempt!")
            end
        else
            warn("Failed to create arguments for buying Greedy:", args)
        end
    else
        print("Greedy already owned, no purchase needed.")
        Rayfield:Notify({
            Title = "Авто-покупка",
            Content = "Greedy уже куплен!",
            Duration = 3,
            Image = "shopping-cart"
        })
    end
end

function autoBuyGreedy()
    while autoGreedyEnabled do
        upgradesFolder = localPlayer:FindFirstChild("Upgrades") -- Обновляем upgradesFolder на каждой итерации
        if upgradesFolder then
            local currentGreedyCount = checkGreedy()
            if currentGreedyCount == 0 then
                print("No Greedy found, attempting to buy...")
                buyGreedy()
            else
                print("Greedy exists, waiting for it to be spent...")
            end
        else
            warn("Upgrades folder not found during autoBuyGreedy loop!")
        end
        wait(5)
    end
end

-- Интерфейс Rayfield
local EnvironmentTab = Window:CreateTab("Внешняя среда", "eye")
local AutofarmTab = Window:CreateTab("Автофарм", "dollar-sign")
local BetaTab = Window:CreateTab("Бета-функции", "alert-triangle")

-- Вкладка "Внешняя среда"
EnvironmentTab:CreateToggle({
    Name = "Валл-хак",
    CurrentValue = false,
    Callback = function(value)
        toggleESP(value)
    end
})

EnvironmentTab:CreateButton({
    Name = "Полное освещение",
    Callback = function()
        setFullLighting()
        Rayfield:Notify({
            Title = "Успех",
            Content = "Освещение включено",
            Duration = 3,
            Image = "check-circle"
        })
    end
})

-- Вкладка "Автофарм"
AutofarmTab:CreateToggle({
	Name = "Авто-покупка Greedy",
	CurrentValue = false,
	Callback = function(value)
			autoGreedyEnabled = value
			if value then
					upgradesFolder = localPlayer:FindFirstChild("Upgrades") -- Обновляем перед проверкой
					local initialGreedyCount = checkGreedy()
					if initialGreedyCount > 0 then
							autoGreedyEnabled = false
							Rayfield:Notify({
									Title = "Авто-покупка",
									Content = "Greedy уже куплен! Авто-покупка не запущена.",
									Duration = 3,
									Image = "x-circle"
							})
							return
					end
					if not autoGreedyThread or coroutine.status(autoGreedyThread) == "dead" then
							autoGreedyThread = coroutine.create(autoBuyGreedy)
							coroutine.resume(autoGreedyThread)
					end
					Rayfield:Notify({
							Title = "Авто-покупка",
							Content = "Автоматическая покупка Greedy включена",
							Duration = 3,
							Image = "shopping-cart"
					})
			else
					Rayfield:Notify({
							Title = "Авто-покупка",
							Content = "Автоматическая покупка Greedy выключена",
							Duration = 3,
							Image = "x-circle"
					})
			end
	end
})

AutofarmTab:CreateButton({
    Name = "Максимум монет",
    Callback = function()
        setMaxCoins()
        Rayfield:Notify({
            Title = "Успех",
            Content = "Монеты установлены",
            Duration = 3,
            Image = "coins"
        })
    end
})

local antiAFK = createAntiAFK()
AutofarmTab:CreateToggle({
    Name = "Анти-АФК",
    CurrentValue = false,
    Callback = function(value)
        antiAFK(value)
        Rayfield:Notify({
            Title = "Анти-АФК",
            Content = value and "Анти-АФК включен" or "Анти-АФК выключен",
            Duration = 3,
            Image = value and "play" or "pause"
        })
    end
})

-- Вкладка "Бета-функции"
BetaTab:CreateButton({
    Name = "Макс стамина",
    Callback = function()
        setInfiniteStamina()
        Rayfield:Notify({
            Title = "Успех",
            Content = "Стамина установлена",
            Duration = 3,
            Image = "zap"
        })
    end
})

-- Уведомление о загрузке скрипта
Rayfield:Notify({
    Title = "DXSNDHUB",
    Content = "Скрипт успешно загружен!",
    Duration = 5,
    Image = "rocket"
})
