local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MiniAccountUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== MAIN FRAME =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 110)
frame.Position = UDim2.new(0.5, -110, 0.5, -55)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 2
frameStroke.Color = Color3.fromRGB(0,255,200)
frameStroke.Parent = frame

-- ===== TITLE =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,0,26)
title.Position = UDim2.new(0,10,0,5)
title.BackgroundTransparency = 1
title.Text = "Menu"
title.TextColor3 = Color3.fromRGB(0,255,200)
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- ===== CLOSE BUTTON =====
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,22,0,22)
closeBtn.Position = UDim2.new(1,-28,0,5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.TextColor3 = Color3.fromRGB(255,80,80)
closeBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1,0)

-- ===== MASK USERNAME =====
local function maskName(name)
	if #name <= 7 then
		return name .. "***"
	else
		return string.sub(name,1,7) .. "***"
	end
end

local maskedName = maskName(player.Name)

-- ===== INFO BOX =====
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1,-16,0,55)
textBox.Position = UDim2.new(0,8,0,38)
textBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
textBox.TextColor3 = Color3.new(1,1,1)
textBox.Font = Enum.Font.GothamBold
textBox.TextSize = 16
textBox.TextWrapped = true
textBox.MultiLine = true
textBox.ClearTextOnFocus = false
textBox.Text = "👤 account: "..maskedName.."\n📌 đơn:"
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,8)

-- ===== OPEN BUTTON =====
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0,100,0,38)
openBtn.Position = UDim2.new(0,20,0.82,0)
openBtn.Text = "Open"
openBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
openBtn.TextColor3 = Color3.fromRGB(0,255,200)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 18
openBtn.TextStrokeTransparency = 1
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0,12)

local openStroke = Instance.new("UIStroke")
openStroke.Thickness = 2
openStroke.Color = Color3.fromRGB(0,255,200)
openStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
openStroke.Parent = openBtn

openBtn.Visible = false

-- ===== DRAG FUNCTION =====
local function enableDrag(object)
	local dragging = false
	local dragInput
	local dragStart
	local startPos

	object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - dragStart
			object.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

enableDrag(frame)
enableDrag(openBtn)

-- ===== OPEN / CLOSE =====
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	openBtn.Visible = false
end)
