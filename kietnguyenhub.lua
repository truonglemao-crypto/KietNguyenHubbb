local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")

local player = Players.LocalPlayer
local orderStore = DataStoreService:GetDataStore("OrderCountData")

-- Load dữ liệu
local orderValue = 0
local success, data = pcall(function()
	return orderStore:GetAsync(player.UserId)
end)

if success and data then
	orderValue = data
end

-- Tạo GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 260, 0, 130)
frame.Position = UDim2.new(0.5, -130, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- đổi màu ở đây
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local label = Instance.new("TextLabel")
label.Parent = frame
label.Size = UDim2.new(1, 0, 0.6, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.GothamBold
label.TextScaled = true

local plus = Instance.new("TextButton")
plus.Parent = frame
plus.Size = UDim2.new(0.3, 0, 0.4, 0)
plus.Position = UDim2.new(0.35, 0, 0.6, 0)
plus.Text = "+"
plus.TextScaled = true
plus.Font = Enum.Font.GothamBold
plus.BackgroundColor3 = Color3.fromRGB(0,170,0)
plus.TextColor3 = Color3.new(1,1,1)

local function updateText()
	label.Text = "Count đơn: "..orderValue
end

updateText()

plus.MouseButton1Click:Connect(function()
	orderValue += 1
	updateText()
end)

-- Lưu khi thoát
player.AncestryChanged:Connect(function()
	if not player:IsDescendantOf(game) then
		pcall(function()
			orderStore:SetAsync(player.UserId, orderValue)
		end)
	end
end)
