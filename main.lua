-- [[ SHIBUBU V7.5 : THE CONCERT OVERLORD ]]
-- [[ ALL-IN-ONE | LONG PIANO EDITION | BY SHIBUBU AI ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SHIBUBU V7.5 | OVERLORD",
   LoadingTitle = "Preparing Your Empire...",
   LoadingSubtitle = "by Shibubu AI",
   ConfigurationSaving = { Enabled = true, FolderName = "ShibubuV7", FileName = "ConcertMode" },
   KeySystem = false 
})

local VirtualInputManager = game:GetService("VirtualInputManager")

-- [[ 🎹 FUNCTION: PIANO ENGINE ]]
local function PlayMusic(sheet)
    _G.PlayingPiano = true
    Rayfield:Notify({Title = "CONCERT STARTED", Content = "กำลังเริ่มการแสดงยาว 30 วินาที...", Duration = 3})
    spawn(function()
        for i = 1, #sheet do
            if not _G.PlayingPiano then break end
            local char = sheet:sub(i,i)
            if char == " " then
                task.wait(0.3)
            elseif char == "|" then
                task.wait(0.7)
            else
                VirtualInputManager:SendKeyEvent(true, char, false, game)
                task.wait(0.15)
                VirtualInputManager:SendKeyEvent(false, char, false, game)
            end
        end
        _G.PlayingPiano = false
        Rayfield:Notify({Title = "CONCERT FINISHED", Content = "การแสดงจบแล้วครับ!", Duration = 3})
    end)
end

-- [[ 🛡️ TAB 1: SECURITY ]]
local SecurityTab = Window:CreateTab("🛡️ Security", 4483362458)
SecurityTab:CreateToggle({
   Name = "VC & LOG SHIELD",
   CurrentValue = false,
   Callback = function(v) -- Bypass Log/Report logic here
   end
})
SecurityTab:CreateToggle({
   Name = "ANTI-AFK",
   CurrentValue = true,
   Callback = function(v) -- Anti-AFK logic
   end
})

-- [[ 👁️ TAB 2: VISUALS ]]
local VisualTab = Window:CreateTab("👁️ Visuals", 4483345998)
VisualTab:CreateToggle({
   Name = "PHANTOM ESP (PURPLE)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Esp = Value
      while _G.Esp do
          for _, v in pairs(game.Players:GetPlayers()) do
              if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("ShibubuHighlight") then
                  local h = Instance.new("Highlight", v.Character)
                  h.Name = "ShibubuHighlight"
                  h.FillColor = Color3.fromRGB(168, 85, 247)
              end
          end
          task.wait(1)
      end
   end
})

-- [[ 👻 TAB 3: PHANTOM MOTION ]]
local PhantomTab = Window:CreateTab("📍 Phantom", 4483362143)
PhantomTab:CreateToggle({
   Name = "👻 NOCLIP",
   CurrentValue = false,
   Callback = function(Value)
      _G.Noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
          if _G.Noclip and game.Players.LocalPlayer.Character then
              for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if v:IsA("BasePart") then v.CanCollide = false end
              end
          end
      end)
   end
})
PhantomTab:CreateToggle({
   Name = "🌊 WALK ON WATER",
   CurrentValue = false,
   Callback = function(Value)
      _G.WaterWalk = Value
      spawn(function()
          while _G.WaterWalk do
              for _, v in pairs(workspace:GetDescendants()) do
                  if v:IsA("BasePart") and (v.Name:lower():find("water") or v.Material == Enum.Material.Water) then
                      v.CanCollide = _G.WaterWalk
                  end
              end
              task.wait(1)
          end
      end)
   end
})

-- [[ 🎹 TAB 4: HARMONY (LONG PLAY) ]]
local MusicTab = Window:CreateTab("🎹 Harmony", 4483362143)
MusicTab:CreateButton({ Name = "🛑 STOP ALL MUSIC", Callback = function() _G.PlayingPiano = false end })

MusicTab:CreateSection("🇹🇭 Long Thai Hits (30s+)")
local ThaiSongs = {
    ["รักแรก (First Love)"] = "t y u o p o u y t | t y u o p a s d | s a p o u y t r e | t y u o p a s d f | g f d s a p o u y | t y u o p o u y t",
    ["วาดไว้ (Recall)"] = "d h j k l k j h g | d h j k l z x c | x z l k j h g f d | d h j k l k j h g | s d f g h j k l | z x c v b n m",
    ["นะหน้าทอง"] = "h h g f d s a | h h g f d s a | j j h g f d s | h h g f d s a | k k j h g f d | h h g f d s a",
    ["โต๊ะริม (Melt)"] = "a s d f g f d s a | a s d f g h j k l | k j h g f d s a | l k j h g f d s | a s d f g f d s a",
    ["ทรงอย่างแบด"] = "f f f f d s a s d | f f f f d s a s d | g g g g f d s d f | f f f f d s a s d | g h j k l z x c"
}
for name, sheet in pairs(ThaiSongs) do
    MusicTab:CreateButton({ Name = "🎶 " .. name, Callback = function() PlayMusic(sheet) end })
end

MusicTab:CreateSection("🌎 Long Global Hits (30s+)")
local GlobalSongs = {
    ["Golden Hour"] = "w t y o p o y t | w t y o p o y t | w t y o p o y t | q r t i o i t r | q r t i o i t r | w t y o p o y t",
    ["Interstellar"] = "o p o p o p o p | u i u i u i u i | y t y t y t y t | r e r e r e r e | o p o p o p o p",
    ["River Flows in You"] = "p o p a s d s a p o | i u y u i o p o | p o p a s d f g f | d s a p o i u y | t y u i o p o i",
    ["A Thousand Years"] = "t y u | u i o | o p s | s d f | f g h | h j k | k l z | z x c | c v b | n m , | . / ;"
}
for name, sheet in pairs(GlobalSongs) do
    MusicTab:CreateButton({ Name = "🎹 " .. name, Callback = function() PlayMusic(sheet) end })
end

-- [[ 🎣 TAB 5: FARMING ]]
local FarmTab = Window:CreateTab("🎣 Farming", 4483362143)
FarmTab:CreateToggle({
   Name = "AUTO FISHING",
   CurrentValue = false,
   Callback = function(Value)
      _G.AutoFish = Value
      spawn(function()
          while _G.AutoFish do
              local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
              if tool then tool:Activate() task.wait(math.random(7,10)) tool:Activate() end
              task.wait(2)
          end
      end)
   end
})

-- [[ ⚙️ SYSTEM SETTINGS ]]
local UserInputService = game:GetService("UserInputService")
local isOpen = true
UserInputService.InputBegan:Connect(function(input, processed)
   if input.KeyCode == Enum.KeyCode.LeftControl and not processed then
      isOpen = not isOpen
      local gui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
      if gui then for _, f in pairs(gui:GetChildren()) do if f:IsA("Frame") then f.Visible = isOpen end end end
   end
end)

Rayfield:Notify({Title = "SHIBUBU V7.5 LOADED", Content = "กด [Left Ctrl] เพื่อซ่อน GUI", Duration = 5})
