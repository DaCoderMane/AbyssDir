local players = game:GetService("Players")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Abyss",
    Text = "Successfully Injected. Enjoy, " .. players.LocalPlayer.DisplayName .. "!",
    Icon = "rbxthumb://type=AvatarHeadShot&id=" .. players.LocalPlayer.UserId .. "&w=180&h=180",
    Duration = 5
})
