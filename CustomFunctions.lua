local success, errorMessage
local errorCount = 0
local warningCount = 0

success, errorMessage = pcall(function()
    getgenv().abyss = {}

    -- Helper to count warnings
    local function warnHandler()
        warningCount += 1
    end

    -- Helper to count errors
    local function errorHandler()
        errorCount += 1
    end

    -- Gets a player by part of their display name or username
    getgenv().abyss.GetPlayerByName = function(name)
        local success, result = pcall(function()
            local players = game:GetService("Players"):GetPlayers()
            name = name:lower()
            for _, player in ipairs(players) do
                if player.Name:lower():find(name, 1, true) or player.DisplayName:lower():find(name, 1, true) then
                    return player
                end
            end
            return nil -- Return nil if no player is found
        end)
        if not success then
            errorHandler()
        end
        return result
    end

    -- Gets the HumanoidRootPart of a player
    getgenv().abyss.GetHRP = function(player)
        local success, result = pcall(function()
            if typeof(player) == "string" then
                player = abyss.GetPlayerByName(player)
            end
            if player and player.Character then
                return player.Character:FindFirstChild("HumanoidRootPart")
            end
            return nil
        end)
        if not success then
            errorHandler()
        end
        return result
    end

    -- Teleports the local player to a position
    getgenv().abyss.Teleport = function(position)
        local success = pcall(function()
            local localPlayer = game:GetService("Players").LocalPlayer
            if localPlayer and localPlayer.Character then
                local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(position)
                end
            end
        end)
        if not success then
            errorHandler()
        end
    end

    -- Checks if a player is alive
    getgenv().abyss.IsAlive = function(name)
        local success, result = pcall(function()
            local player = abyss.GetPlayerByName(name)
            if player and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                return humanoid and humanoid.Health > 0
            end
            return false
        end)
        if not success then
            errorHandler()
        end
        return result
    end

    -- Teleports the local player to the position of the target player
    getgenv().abyss.TeleportToPlayer = function(targetName)
        local success = pcall(function()
            local targetPlayer = abyss.GetPlayerByName(targetName)
            if targetPlayer then
                local targetHrp = abyss.GetHRP(targetPlayer)
                if targetHrp then
                    abyss.Teleport(targetHrp.Position)
                end
            end
        end)
        if not success then
            errorHandler()
        end
    end

    -- Calculates the distance between two players
    getgenv().abyss.GetDistance = function(player1Name, player2Name)
        local success, result = pcall(function()
            local player1 = abyss.GetPlayerByName(player1Name)
            local player2 = abyss.GetPlayerByName(player2Name)
            if player1 and player2 then
                local hrp1 = abyss.GetHRP(player1)
                local hrp2 = abyss.GetHRP(player2)
                if hrp1 and hrp2 then
                    return (hrp1.Position - hrp2.Position).Magnitude
                end
            end
            return nil -- Return nil if calculation is not possible
        end)
        if not success then
            errorHandler()
        end
        return result
    end
end)

-- Feedback
if success then
    print("Functions Loaded Successfully with "..errorCount.." error(s) and "..warningCount.." warning(s).")
else
    print("Functions Failed To Load: "..errorMessage)
end
