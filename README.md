-- [[ PROJECT: THE PUNISHER V1.2 | GUI MASTER ]]
-- [[ EASY GUI | MOBILE FRIENDLY | PARRY & COUNTER ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "PUNISHER V1.2 | UI MASTER",
   LoadingTitle = "Shibubu Empire Loading...",
   LoadingSubtitle = "by Shibubu AI",
   ConfigurationSaving = { Enabled = true, FolderName = "PunisherGUI", FileName = "Config" },
   KeySystem = false 
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

-- [[ 📱 GUI TOGGLE BUTTON (ปุ่มเปิด/ปิดหน้าจอสำหรับมือถือ) ]]
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ToggleBtn = Instance.new("TextButton", ScreenGui)

ToggleBtn.Name = "ShibubuToggle"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(168, 85, 247) -- ม่วงนีออน
ToggleBtn.Text = "S"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 25
ToggleBtn.Font = Enum.Font.GothamBold

-- ตกแต่งปุ่มให้โค้งมน
local Corner = Instance.new("UICorner", ToggleBtn)
Corner.CornerRadius = UDim.new(0, 10)

-- ฟังชั่นเปิด-ปิด GUI
ToggleBtn.MouseButton1Click:Connect(function()
    local target = game:GetService("CoreGui"):FindFirstChild("Rayfield")
    if target then
        for _, frame in pairs(target:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = not frame.Visible
            end
        end
    end
end)

-- [[ 🛡️ TAB 1: SECURITY (LEGACY VC) ]]
local SecurityTab = Window:CreateTab("🛡️ Security", 4483362458)
SecurityTab:CreateToggle({
   Name = "LEGACY ANTI-VC",
   CurrentValue = true,
   Callback = function(Value)
      _G.AntiVC = Value
      task.spawn(function()
          while _G.AntiVC do
              pcall(function()
                  game:GetService("VoiceChatService"):SetServiceEnabled(false)
              end)
              task.wait(1)
          end
      end)
   end
})

-- [[ ⚔️ TAB 2: COMBAT (PARRY / COUNTER) ]]
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)

CombatTab:CreateToggle({
   Name = "AUTO PARRY (F)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Parry = Value
      task.spawn(function()
          while _G.Parry do
              -- Logic ตรวจจับลูกบอล/กระสุน (จาก V1.2)
              task.wait()
          end
      end)
   end
})

CombatTab:CreateToggle({
   Name = "AUTO COUNTER (E)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Counter = Value
      -- Logic ตรวจจับระยะประชิด (จาก V1.2)
   end
})

-- [[ 👁️ TAB 3: VISUALS ]]
local VisualTab = Window:CreateTab("👁️ Visuals", 4483345998)
VisualTab:CreateToggle({
   Name = "ESP NAME/DIST",
   CurrentValue = false,
   Callback = function(Value) _G.Esp = Value end
})

Rayfield:Notify({Title = "PROJECT PUNISHER", Content = "กดปุ่ม 'S' สีม่วงเพื่อ เปิด/ปิด เมนู", Duration = 5})
