loadstring(game:HttpGet("https://raw.githubusercontent.com/msang1412/SangHub/refs/heads/main/fastattack.lua"))()
--// Config
getgenv().AutoCyborg = true
getgenv().SelectWeapon = "Melee"
local TweenSpeed = 350
local HeightAboveOrder = 25
local hakiCooldown = 5
local lastHakiTime = 0

--// Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

--// Helper
local function SafeWaitForChild(parent, name)
    local success, result = pcall(function() return parent:WaitForChild(name) end)
    if success then return result else return nil end
end

--// Equip Weapon
local function EquipWeapon(toolName)
    local char = player.Character or player.CharacterAdded:Wait()
    local backpack = player:WaitForChild("Backpack")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    local function FindTool()
        for _, v in pairs(backpack:GetChildren()) do
            if v:IsA("Tool") and (string.find(v.Name:lower(), toolName:lower()) or (v:GetAttribute("WeaponType") == toolName)) then
                return v
            end
        end
        for _, v in pairs(char:GetChildren()) do
            if v:IsA("Tool") and (string.find(v.Name:lower(), toolName:lower()) or (v:GetAttribute("WeaponType") == toolName)) then
                return v
            end
        end
    end
    local tool = FindTool()
    if tool then humanoid:EquipTool(tool) end
end

--// Auto Haki
local function AutoHaki()
    if player.Character and not player.Character:FindFirstChild("HasBuso") then
        if tick() - lastHakiTime >= hakiCooldown then
            pcall(function() CommF:InvokeServer("Buso") end)
            lastHakiTime = tick()
        end
    end
end

--// Smooth Stay Above Target
local function SmoothStayAbove(targetHRP)
    if not targetHRP then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, HeightAboveOrder, 0))
end

--// Keep Player in Air
RunService.Heartbeat:Connect(function()
    if getgenv().AutoCyborg then
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.zero
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
    end
end)

--// Check Order
local function OrderExists()
    local enemies = Workspace:FindFirstChild("Enemies")
    if not enemies then return false end
    local order = enemies:FindFirstChild("Order")
    if order and order:FindFirstChild("Humanoid") and order.Humanoid.Health > 0 and order:FindFirstChild("HumanoidRootPart") then
        return true
    else
        return false
    end
end

local function GetOrder()
    local timer = 0
    local order
    repeat
        order = Workspace:FindFirstChild("Enemies") and Workspace.Enemies:FindFirstChild("Order")
        if order and order:FindFirstChild("HumanoidRootPart") and order:FindFirstChild("Humanoid") then
            return order
        end
        task.wait(0.1)
        timer = timer + 0.1
    until timer >= 5
    return nil
end

--// Startdutdit (nhét chip) - SPAM LIÊN TỤC
local function Startdutdit()
    local ok, btn = pcall(function()
        return workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
    end)
    if ok and btn then
        fireclickdetector(btn)
        print("✅ Đã nhét Core Brain!")
        return true
    else
        return false
    end
end

--// Check Core Brain và NHÉT LIÊN TỤC
local function CheckAndInsertChip()
    local backpack = player:WaitForChild("Backpack")
    local char = player.Character
    
    -- Kiểm tra trong Backpack
    if backpack:FindFirstChild("Core Brain") then
        print("Đã tìm thấy Core Brain trong Backpack, đang nhét chip...")
        Startdutdit()
        return true
    end
    
    -- Kiểm tra trong Character
    if char and char:FindFirstChild("Core Brain") then
        print("Đã tìm thấy Core Brain trong Character, đang nhét chip...")
        Startdutdit()
        return true
    end
    
    return false
end

--// TASK RIÊNG ĐỂ NHÉT CORE BRAIN - SPAM LIÊN TỤC
task.spawn(function()
    while true do
        if CheckAndInsertChip() then
            -- Nếu có Core Brain thì spam nhét mỗi 0.5 giây
            task.wait(0.5)
        else
            -- Nếu không có thì kiểm tra lại sau 1 giây
            task.wait(1)
        end
    end
end)

--// Main Loop
task.spawn(function()
    while task.wait(0.2) do
        if not getgenv().AutoCyborg then continue end
        
        local char = player.Character
        if not char then continue end
        
        EquipWeapon(getgenv().SelectWeapon)
        AutoHaki()

        local chip = player.Backpack:FindFirstChild("Microchip") or char:FindFirstChild("Microchip")
        local hasChip = chip ~= nil
        local order = GetOrder()
        local orderExists = order ~= nil

        if orderExists then
            repeat
                task.wait(0.15)
                AutoHaki()
                EquipWeapon(getgenv().SelectWeapon)
                order = GetOrder()
                if order and order:FindFirstChild("HumanoidRootPart") then
                    SmoothStayAbove(order.HumanoidRootPart)
                    order.HumanoidRootPart.CanCollide = false
                    order.HumanoidRootPart.Size = Vector3.new(120,120,120)
                end
            until not OrderExists() or not getgenv().AutoCyborg
            continue
        end

        if hasChip and not OrderExists() then
            local ok, btn = pcall(function()
                return Workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector
            end)
            if ok and btn then
                fireclickdetector(btn)
            end

            local order = GetOrder()
            if order then
                repeat
                    task.wait(0.15)
                    AutoHaki()
                    EquipWeapon(getgenv().SelectWeapon)
                    if order and order:FindFirstChild("HumanoidRootPart") then
                        SmoothStayAbove(order.HumanoidRootPart)
                        order.HumanoidRootPart.CanCollide = false
                        order.HumanoidRootPart.Size = Vector3.new(120,120,120)
                    end
                    order = GetOrder()
                until not OrderExists() or not getgenv().AutoCyborg
            end
            continue
        end

        if not hasChip and not OrderExists() then
            pcall(function()
                CommF:InvokeServer("BlackbeardReward", "Microchip", "1")
                task.wait(0.3)
                CommF:InvokeServer("BlackbeardReward", "Microchip", "2")
            end)
            task.wait(0.5)
        end
    end
end)
