if getgenv().Nousigi then 
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name,  "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')
local T1UIColor = {
	["Border Color"] = Color3.fromRGB(60, 0, 100),
	["Click Effect Color"] = Color3.fromRGB(200, 200, 200),
	["Setting Icon Color"] = Color3.fromRGB(200, 200, 200),
	["Logo Image"] = "rbxassetid://133779423735605",
	["Search Icon Color"] = Color3.fromRGB(200, 200, 200),
	["Search Icon Highlight Color"] = Color3.fromRGB(60, 0, 100),
	["GUI Text Color"] = Color3.fromRGB(220, 220, 220),
	["Text Color"] = Color3.fromRGB(220, 220, 220),
	["Placeholder Text Color"] = Color3.fromRGB(110, 110, 110),
	["Title Text Color"] = Color3.fromRGB(190, 130, 255),
	["Background Main Color"] = Color3.fromRGB(0, 0, 0),
	["Background 1 Color"] = Color3.fromRGB(0, 0, 0),
	["Background 1 Transparency"] = 0,
	["Background 2 Color"] = Color3.fromRGB(0, 0, 0),
	["Background 3 Color"] = Color3.fromRGB(0, 0, 0),
	["Background Image"] = "",
	["Page Selected Color"] = Color3.fromRGB(70, 0, 120),
	["Section Text Color"] = Color3.fromRGB(200, 200, 200),
	["Section Underline Color"] = Color3.fromRGB(60, 0, 100),
	["Toggle Border Color"] = Color3.fromRGB(60, 0, 100),
	["Toggle Checked Color"] = Color3.fromRGB(180, 100, 255),
	["Toggle Desc Color"] = Color3.fromRGB(150, 150, 150),
	["Button Color"] = Color3.fromRGB(60, 0, 100),
	["Label Color"] = Color3.fromRGB(0, 0, 0),
	["Dropdown Icon Color"] = Color3.fromRGB(200, 200, 200),
	["Dropdown Selected Color"] = Color3.fromRGB(70, 0, 120),
	["Dropdown Selected Check Color"] = Color3.fromRGB(40, 0, 80),
	["Textbox Highlight Color"] = Color3.fromRGB(60, 0, 100),
	["Box Highlight Color"] = Color3.fromRGB(60, 0, 100),
	["Slider Line Color"] = Color3.fromRGB(60, 0, 100),
	["Slider Highlight Color"] = Color3.fromRGB(40, 0, 80),
	["Tween Animation 1 Speed"] = DisableAnimation and 0 or 0.25,
	["Tween Animation 2 Speed"] = DisableAnimation and 0 or 0.5,
	["Tween Animation 3 Speed"] = DisableAnimation and 0 or 0.1,
	["Text Stroke Transparency"] = 0.5
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = true

getgenv().FixLagEnabled = false
task.spawn(function()
	while true do
		task.wait(10)
		if not getgenv().FixLagEnabled then continue end
		pcall(function()
			local lighting = game:GetService("Lighting")
			lighting.GlobalShadows = false
			lighting.FogEnd = 9e9
			for _, v in ipairs(workspace:GetDescendants()) do
				if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
					v.Enabled = false
				end
			end
		end)
	end
end)
task.spawn(function()
	game:GetService("RunService").RenderStepped:Connect(function()
		if not getgenv().FixLagEnabled then return end
		pcall(function()
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		end)
	end)
end)


local currcolor = {}
local Library = {};
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not djtmemay and cac then
				TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not djtmemay and not cac then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end

Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'Nousigi Hub GUI'
Library_Function.Gui.Enabled = false

getgenv().ReadyForGuiLoaded = false
task.spawn(function()
	repeat
		task.wait()
	until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)


Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'Nousigi Hub Notification'

Library_Function.HideGui = Instance.new('ScreenGui')
Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name = 'Nousigi Hub Btn'


local btnHide = Instance.new('ImageButton', Library_Function.HideGui)
btnHide.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
btnHide.BackgroundTransparency = 0
btnHide.AnchorPoint = Vector2.new(0, 1)
btnHide.Size = UDim2.new(0, 60, 0, 60)
btnHide.Position = UDim2.new(0, 15, 1, -15)
btnHide.Image = "rbxassetid://117697087203604"
btnHide.ScaleType = Enum.ScaleType.Fit
btnHide.ImageColor3 = Color3.fromRGB(255, 255, 255)
btnHide.ClipsDescendants = true

local UICornerBtnHide = Instance.new("UICorner")
UICornerBtnHide.Parent = btnHide
UICornerBtnHide.CornerRadius = UDim.new(1, 0)

local btnStroke = Instance.new("UIStroke")
btnStroke.Parent = btnHide
btnStroke.Color = Color3.fromRGB(60, 0, 100)
btnStroke.Thickness = 2

local btnHideFrame = Instance.new('Frame', btnHide)
btnHideFrame.AnchorPoint = Vector2.new(0, 1)
btnHideFrame.Size = UDim2.new(0, 0, 0, 0)
btnHideFrame.Position = UDim2.new(0, 0, 1, 0)
btnHideFrame.Name = "dut dit"
btnHideFrame.BackgroundTransparency = 1

local imgHide = Instance.new('ImageLabel', btnHide)
imgHide.AnchorPoint = Vector2.new(0.5, 0.5)
imgHide.Image = ""
imgHide.BackgroundTransparency = 1
imgHide.Size = UDim2.new(0, 0, 0, 0)
imgHide.Position = UDim2.new(0.5, 0, 0.5, 0)

Library.ToggleUI = function()
	getgenv().UIToggled = not getgenv().UIToggled
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for a, b in ipairs(game.CoreGui:GetChildren()) do
			if b.Name == "Nousigi Hub GUI" then
				b.Enabled = getgenv().UIToggled
			end
		end
	end
end

Library.DestroyUI = function()
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end

Library.DestroyUI = function()
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name,  "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end

if true then
	local button = btnHide
	local UIS = game:GetService("UserInputService")
	
	local dragging = false
	local dragInput, dragStart, startPos
	local holdTime = 0.1
	local holdStarted = 0
	
	local function update(input)
		local delta = input.Position - dragStart
		button.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
	
	local function onInputBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			holdStarted = tick()
			dragStart = input.Position
			startPos = button.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
					holdStarted = 0
				end
			end)
		end
	end
	
	local function onInputEnded(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			holdStarted = 0
		end
	end
	
	local function onInputChanged(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end
	
	button.InputBegan:Connect(onInputBegan)
	button.InputEnded:Connect(onInputEnded)
	button.InputChanged:Connect(onInputChanged)
	
	RunService.RenderStepped:Connect(function()
		if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
			dragging = true
		end
	
		if dragging and dragInput then
			update(dragInput)
		end
	end)
		
end

btnHide.MouseButton1Click:Connect(function() 
	Library.ToggleUI()
end)

local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")

NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)

NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)


Library_Function.Gui.Parent = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

function Library_Function.Getcolor(color)
	return {
		math.floor(color.r * 255),
		math.floor(color.g * 255),
		math.floor(color.b * 255)
	}
end

local libCreateNoti = function(Setting)
	getgenv().TitleNameNoti = Setting.Title or ""; 
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""; 
	local Duration = Setting.Duration or Setting.Timeshow or Setting.Delay or 10;

	local NotiFrame = Instance.new("Frame")
	local Noticontainer = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Topnoti = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local RuafimgCorner = Instance.new("UICorner")
	local TextLabelNoti = Instance.new("TextLabel")
	local CloseContainer = Instance.new("Frame")
	local CloseImage = Instance.new("ImageLabel")
	local TextButton = Instance.new("TextButton")
	local TextLabelNoti2 = Instance.new("TextLabel")

	NotiFrame.Name = "NotiFrame"
	NotiFrame.Parent = NotiContainer
	NotiFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	NotiFrame.BackgroundTransparency = 1.000
	NotiFrame.ClipsDescendants = true
	NotiFrame.Position = UDim2.new(0, 0, 0, 0)
	NotiFrame.Size = UDim2.new(1, 0, 0, 0)
	NotiFrame.AutomaticSize = Enum.AutomaticSize.Y

	Noticontainer.Name = "Noticontainer"
	Noticontainer.Parent = NotiFrame
	Noticontainer.Position = UDim2.new(1, 0, 0, 0)
	Noticontainer.Size = UDim2.new(1, 0, 1, 6)
	Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
	Noticontainer.BackgroundColor3 = getgenv().UIColor["Background 3 Color"]
	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = Noticontainer

	Topnoti.Name = "Topnoti"
	Topnoti.Parent = Noticontainer
	Topnoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Topnoti.BackgroundTransparency = 1.000
	Topnoti.Position = UDim2.new(0, 0, 0, 5)
	Topnoti.Size = UDim2.new(1, 0, 0, 25)

	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = Topnoti
	Ruafimg.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, getgenv().T1 and 5 or 0)
	Ruafimg.Size = UDim2.new(0, getgenv().T1 and 30 or 25, 0, getgenv().T1 and 15 or 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	RuafimgCorner.CornerRadius = UDim.new(1, 0)
	RuafimgCorner.Name = "RuafimgCorner"
	RuafimgCorner.Parent = Ruafimg
	
	local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
	local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
	local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
	local color = colorR .. ',' .. colorG .. ',' .. colorB
    TextLabelNoti.Text = tostring(getgenv().TitleNameNoti or "")
    
	TextLabelNoti.Name = "TextLabelNoti"
	TextLabelNoti.Parent = Topnoti
	TextLabelNoti.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelNoti.BackgroundTransparency = 1.000
	TextLabelNoti.Position = UDim2.new(0, getgenv().T1 and 40 or 35, 0, 0)
	TextLabelNoti.Size = UDim2.new(1, getgenv().T1 and -40 or -35, 1, 0)
	TextLabelNoti.Font = Enum.Font.GothamBold
	TextLabelNoti.TextSize = 14.000
	TextLabelNoti.TextWrapped = true
	TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelNoti.RichText = true
	TextLabelNoti.TextColor3 = getgenv().UIColor["GUI Text Color"]

	CloseContainer.Name = "CloseContainer"
	CloseContainer.Parent = Topnoti
	CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
	CloseContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseContainer.BackgroundTransparency = 1.000
	CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
	CloseContainer.Size = UDim2.new(0, 22, 0, 22)

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = CloseContainer
	CloseImage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	CloseImage.BackgroundTransparency = 1.000
	CloseImage.Size = UDim2.new(1, 0, 1, 0)
	CloseImage.Image = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset = Vector2.new(284, 4)
	CloseImage.ImageRectSize = Vector2.new(24, 24)
	CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

	TextButton.Parent = CloseContainer
	TextButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextButton.BackgroundTransparency = 1.000
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14.000

	if Description then
		TextLabelNoti2.Name = 'TextColor'
		TextLabelNoti2.Parent = Noticontainer
		TextLabelNoti2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TextLabelNoti2.BackgroundTransparency = 1.000
		TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
		TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
		TextLabelNoti2.Font = Enum.Font.GothamBold
		TextLabelNoti2.Text = Description
		TextLabelNoti2.TextSize = 14.000
		TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText = true
		TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped = true
	end

	local function remove()
		TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		task.wait(0.25)
		NotiFrame:Destroy()
	end

	TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		}):Play()
	end)

	TextButton.MouseLeave:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		}):Play()
	end)

	TextButton.MouseButton1Click:Connect(function()
		task.wait(0.25)
		remove()
	end)

	task.spawn(function()
		task.wait(Duration)
		remove()
	end)

end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local s, e = pcall(function()
			libCreateNoti(Setting)
		end)
		if e then
			print(e)
		end
	end
end

function Library:CreateWindow(Setting)
    local TitleNameMain = Setting.Title or "Banana Cat Hub"
    getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
    
    if Setting.Image then
        getgenv().UIColor["Logo Image"] = Setting.Image
    end
    
	local djtmemay = false
	cac = false

	local Main = Instance.new("Frame")
	local maingui = Instance.new("ImageLabel")
	local MainCorner = Instance.new("UICorner")
	local TopMain = Instance.new("Frame")
	local Ruafimg = Instance.new("ImageLabel")
	local TextLabelMain = Instance.new("TextLabel")
	local PageControl = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local ControlList = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local ControlTitle = Instance.new("TextLabel")
	local MainPage = Instance.new("Frame")
	local UIPage = Instance.new("UIPageLayout")
	local Concacontainer = Instance.new("Frame")
	local Concacmain = Instance.new("Frame")
	local MainContainer

	Main.Name = "Main"
	Main.Parent = Library_Function.Gui
	Main.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
	Main.BackgroundTransparency = 1.000
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Size = UDim2.new(0, 629, 0, 359)

	makeDraggable(Main, Main)

	maingui.Name = "maingui"
	maingui.Parent = Main
	maingui.AnchorPoint = Vector2.new(0.5, 0.5)
	maingui.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	maingui.BackgroundTransparency = 1.000
	maingui.Position = UDim2.new(0.5, 0, 0.5, 0)
	maingui.Selectable = true
	maingui.Size = UDim2.new(1, 30, 1, 30)
	maingui.Image = "rbxassetid://8068653048"
	maingui.ScaleType = Enum.ScaleType.Slice
	maingui.SliceCenter = Rect.new(15, 15, 175, 175)
	maingui.SliceScale = 1.300
	maingui.ImageColor3 = getgenv().UIColor["Border Color"]
	maingui.ImageTransparency = 1

	maingui.ImageColor3 = getgenv().UIColor['Title Text Color']

	MainContainer = Instance.new("ImageLabel")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = Main
	MainContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainContainer.Size = UDim2.new(1, 0, 1, 0)

	local uistr = Instance.new("UIStroke", MainContainer);
	uistr.Thickness = 1;
	uistr.Color = Color3.fromRGB(60, 0, 100);


	getgenv().ReadyForGuiLoaded = true
	
	MainCorner.CornerRadius = UDim.new(0, 5)
	MainCorner.Name = "MainCorner"
	MainCorner.Parent = MainContainer

	Concacontainer.Name = "Concacontainer"
	Concacontainer.Parent = MainContainer
	Concacontainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacontainer.BackgroundTransparency = 1.000
	Concacontainer.ClipsDescendants = true
	Concacontainer.Position = UDim2.new(0, 0, 0, 30)
	Concacontainer.Size = UDim2.new(1, 0, 1, -30)
	
	Concacmain.Name = "Concacmain"
	Concacmain.Parent = Concacontainer
	Concacmain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Concacmain.BackgroundTransparency = 1.000
	Concacmain.Selectable = true
	Concacmain.Size = UDim2.new(1, 0, 1, 0)
	
	TopMain.Name = "TopMain"
	TopMain.Parent = MainContainer
	TopMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopMain.BackgroundTransparency = 1.000
	TopMain.Size = UDim2.new(1, 0, 0, 25)
	
	local TopStroke = Instance.new("Frame", TopMain)
	TopStroke.Name = "TopStroke"
	TopStroke.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
	TopStroke.BackgroundTransparency = 0.6
	TopStroke.BorderSizePixel = 0
	TopStroke.Position = UDim2.new(0, 0, 1, -1)
	TopStroke.Size = UDim2.new(1, 0, 0, 1)
	
	Ruafimg.Name = "Ruafimg"
	Ruafimg.Parent = TopMain
	Ruafimg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Ruafimg.BackgroundTransparency = 1.000
	Ruafimg.Position = UDim2.new(0, 5, 0, 0)
	Ruafimg.Size = UDim2.new(0, 25, 0, 25)
	Ruafimg.Image = getgenv().UIColor["Logo Image"]

	TextLabelMain.Name = "TextLabelMain"
	TextLabelMain.Parent = TopMain
	TextLabelMain.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	TextLabelMain.BackgroundTransparency = 1.000
	TextLabelMain.Position = UDim2.new(0, 35, 0, 0)
	TextLabelMain.Size = UDim2.new(1, -35, 1, 0)
	TextLabelMain.Font = Enum.Font.GothamBold
	TextLabelMain.RichText = true
	TextLabelMain.TextSize = 16.000
	TextLabelMain.TextWrapped = true
	TextLabelMain.TextXAlignment = Enum.TextXAlignment.Left
	TextLabelMain.TextColor3 = getgenv().UIColor["GUI Text Color"]

	local colorR = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[1])
	local colorG = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[2])
	local colorB = tostring(Library_Function.Getcolor(getgenv().UIColor['Title Text Color'])[3])
	local color = colorR .. ',' .. colorG .. ',' .. colorB
    TextLabelMain.Text = tostring(TitleNameMain or "TRon Void Hub - Blox Fruit")
	TextLabelMain.TextColor3 = Color3.fromRGB(190, 50, 255)
	TextLabelMain.TextStrokeTransparency = 0.3
	TextLabelMain.TextStrokeColor3 = Color3.fromRGB(140, 0, 255)

	PageControl.Name = "Background1"
	PageControl.Parent = Concacmain
	PageControl.Position = UDim2.new(0, 5, 0, 0)
	PageControl.Size = UDim2.new(0, 180, 0, 325)
	PageControl.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PageControl.BackgroundTransparency = 0

	local pageControlStroke = Instance.new("UIStroke", PageControl)
	pageControlStroke.Color = Color3.fromRGB(60, 0, 100)
	pageControlStroke.Thickness = 1


	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = PageControl

	ControlList.Name = "ControlList"
	ControlList.Parent = PageControl
	ControlList.Active = true
	ControlList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlList.BackgroundTransparency = 1.000
	ControlList.BorderColor3 = Color3.fromRGB(27, 42, 53)
	ControlList.BorderSizePixel = 0
	ControlList.Position = UDim2.new(0, 0, 0, 30)
	ControlList.Size = UDim2.new(1, -5, 1, -30)
	ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 5
	ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

	UIListLayout.Parent = ControlList
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	ControlTitle.Name = "GUITextColor"
	ControlTitle.Parent = PageControl
	ControlTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	ControlTitle.BackgroundTransparency = 1.000
	ControlTitle.Position = UDim2.new(0, 5, 0, 0)
	ControlTitle.Size = UDim2.new(1, 0, 0, 25)
	ControlTitle.Font = Enum.Font.GothamBold
	ControlTitle.Text = TitleNameMain
	ControlTitle.TextSize = 14.000
	ControlTitle.TextXAlignment = Enum.TextXAlignment.Left
	ControlTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

	local PageSearch = Instance.new("Frame")
	local PageSearchCorner = Instance.new("UICorner")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")

	PageSearch.Name = "PageSearch"
	PageSearch.Parent = PageControl
	PageSearch.AnchorPoint = Vector2.new(1, 0)
	PageSearch.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	PageSearch.Position = UDim2.new(1, -5, 0, 5)
	PageSearch.Size = UDim2.new(0, 170, 0, 25)
	PageSearch.ClipsDescendants = true

	PageSearchCorner.Parent = PageSearch
	PageSearchCorner.CornerRadius = UDim.new(0, 4)

	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = PageSearch
	SearchFrame.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchFrame.BackgroundTransparency = 1
	SearchFrame.Size = UDim2.new(0, 25, 1, 0)

	SearchIcon.Name = "SearchIcon"
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 16, 0, 16)
	SearchIcon.Image = "rbxassetid://8154282545"
	SearchIcon.ImageColor3 = Color3.fromRGB(240, 240, 230)

    SearchBox.Name = "SearchBox"
    SearchBox.Parent = PageSearch
    SearchBox.Active = true
    SearchBox.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
    SearchBox.BackgroundTransparency = 1
    SearchBox.CursorPosition = -1
    SearchBox.Position = UDim2.new(0, 30, 0, 0)
    SearchBox.Size = UDim2.new(1, -30, 1, 0)
    SearchBox.Font = Enum.Font.GothamBold
    SearchBox.PlaceholderColor3 = Color3.fromRGB(170, 170, 160)
    SearchBox.PlaceholderText = "Search section or Function..."
    SearchBox.Text = ""
    SearchBox.TextColor3 = Color3.fromRGB(235, 235, 230)
    SearchBox.TextSize = 14
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	MainPage.Name = "MainPage"
	MainPage.Parent = Concacmain
	MainPage.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
	MainPage.BackgroundTransparency = 1.000
	MainPage.ClipsDescendants = true
	MainPage.Position = UDim2.new(0, 190, 0, 0)
	MainPage.Size = UDim2.new(1, -195, 1, 0)

	UIPage.Name = "UIPage"
	UIPage.Parent = MainPage
	UIPage.FillDirection = Enum.FillDirection.Vertical
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle = Enum.EasingStyle.Quart
	UIPage.Padding = UDim.new(0, 10)
	UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
	end)

	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name = "Shadow"
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundColor3 = Color3.fromRGB(163, 162, 165)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 40, 1, 40)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5028857084"
	Shadow.ImageTransparency = 0.35
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

    local sectionInfo = {}
    
    if not GlobalSearch then
        GlobalSearch = function(searchText)
            searchText = string.lower(searchText)
            
            if searchText == "" then
                for _, control in pairs(getgenv().AllControls) do
                    control.TabButton.Visible = true
                    control.Section.Visible = true
                    control.Element.Visible = true
                end
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') then
                        tab.Visible = true
                    end
                end
                return
            end
            
            for _, control in pairs(getgenv().AllControls) do
                control.Section.Visible = false
                control.Element.Visible = false
            end
            
            for _, tab in pairs(ControlList:GetChildren()) do
                if not tab:IsA('UIListLayout') then
                    tab.Visible = false
                end
            end
            
            local sectionsWithElements = {}
            local elementsInSection = {}
            
            for _, control in pairs(getgenv().AllControls) do
                local elementName = string.lower(control.Name or "")
                local sectionName = string.lower(control.SectionName or "")
                
                local elementFound = string.find(elementName, searchText, 1, true) ~= nil
                local sectionFound = string.find(sectionName, searchText, 1, true) ~= nil
                
                if not elementsInSection[control.Section] then
                    elementsInSection[control.Section] = {}
                end
                table.insert(elementsInSection[control.Section], {
                    control = control,
                    elementFound = elementFound,
                    sectionFound = sectionFound
                })
                
                if elementFound then
                    sectionsWithElements[control.Section] = true
                end
            end
            
            local foundTabs = {}
            
            for section, elements in pairs(elementsInSection) do
                local shouldShowSection = false
                local hasElementMatch = false
                
                for _, elementInfo in ipairs(elements) do
                    if elementInfo.sectionFound then
                        shouldShowSection = true
                    end
                    if elementInfo.elementFound then
                        hasElementMatch = true
                    end
                end
                
                for _, elementInfo in ipairs(elements) do
                    local control = elementInfo.control
                    
                    if elementInfo.elementFound then
                        control.Element.Visible = true
                        
                        if elementInfo.sectionFound or hasElementMatch then
                            control.Section.Visible = true
                        end
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    elseif elementInfo.sectionFound and not hasElementMatch then
                        control.Section.Visible = true
                        control.Element.Visible = false
                        
                        foundTabs[control.TabName] = true
                        control.TabButton.Visible = true
                    end
                end
            end
            
            for tabName, _ in pairs(foundTabs) do
                for _, tab in pairs(ControlList:GetChildren()) do
                    if not tab:IsA('UIListLayout') and string.find(tab.Name, tabName, 1, true) then
                        tab.Visible = true
                    end
                end
            end
            
            if not next(foundTabs) then
            end
        end
    end
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        GlobalSearch(SearchBox.Text)
    end)

	local Main_Function = {}

	local LayoutOrderBut = -1
	local LayoutOrder = -1
	local PageCounter = 1

	function Main_Function:AddTab(PageName)

		local Page_Name = tostring(PageName)
		local Page_Title = Page_Name

		LayoutOrder = LayoutOrder + 1
		LayoutOrderBut = LayoutOrderBut + 1

		local PageName = Instance.new("Frame")
		local Frame = Instance.new("Frame")
		local TabNameCorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local InLine = Instance.new("Frame")
		local LineCorner = Instance.new("UICorner")
		local TabTitleContainer = Instance.new("Frame")
		local TabTitle = Instance.new("TextLabel")
		local PageButton = Instance.new("TextButton")


		PageName.Name = Page_Name .. "_Control"
		PageName.Parent = ControlList
		PageName.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageName.BackgroundTransparency = 1.000
		PageName.Size = UDim2.new(1, -10, 0, 25)
		PageName.LayoutOrder = LayoutOrderBut

		Frame.Parent = PageName
		Frame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Frame.BackgroundTransparency = 1.000
		Frame.Position = UDim2.new(0, 5, 0, 0)
		Frame.Size = UDim2.new(1, -5, 1, 0)

		TabNameCorner.CornerRadius = UDim.new(0, 4)
		TabNameCorner.Name = "TabNameCorner"
		TabNameCorner.Parent = Frame

		Line.Name = "Line"
		Line.Parent = Frame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		Line.BackgroundTransparency = 1.000
		Line.Position = UDim2.new(0, 0, 0.5, 0)
		Line.Size = UDim2.new(0, 14, 1, 0)

		InLine.Name = "PageInLine"
		InLine.Parent = Line
		InLine.AnchorPoint = Vector2.new(0.5, 0.5)
		InLine.BorderSizePixel = 0
		InLine.Position = UDim2.new(0.5, 0, 0.5, 0)
		InLine.Size = UDim2.new(1, -10, 1, -10)
		InLine.BackgroundColor3 = getgenv().UIColor["Page Selected Color"]
		InLine.BackgroundTransparency = 1.000

		LineCorner.Name = "LineCorner"
		LineCorner.Parent = InLine

		TabTitleContainer.Name = "TabTitleContainer"
		TabTitleContainer.Parent = Frame
		TabTitleContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitleContainer.BackgroundTransparency = 1.000
		TabTitleContainer.Position = UDim2.new(0, 15, 0, 0)
		TabTitleContainer.Size = UDim2.new(1, -15, 1, 0)

		TabTitle.Name = "GUITextColor"
		TabTitle.Parent = TabTitleContainer
		TabTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.BackgroundTransparency = 1.000
		TabTitle.Size = UDim2.new(1, 0, 1, 0)
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.Text = Page_Name
		TabTitle.TextColor3 = Color3.fromRGB(230, 230, 230)
		TabTitle.TextSize = 14.000
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageButton.Name = "PageButton"
		PageButton.Parent = PageName
		PageButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageButton.BackgroundTransparency = 1.000
		PageButton.Size = UDim2.new(1, 0, 1, 0)
		PageButton.Font = Enum.Font.SourceSans
		PageButton.Text = ""
		PageButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		PageButton.TextSize = 14.000


		local PageContainer = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local PageTitle = Instance.new("TextLabel")
		local PageList = Instance.new("ScrollingFrame")
		local Pagelistlayout = Instance.new("UIListLayout")

		local CurrentPage = PageCounter
		PageCounter = PageCounter + 1
		PageContainer.Name = "Page" .. CurrentPage
		PageContainer.Parent = MainPage
		PageContainer.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
		PageContainer.Position = UDim2.new(0, 0, 0, 0)
		PageContainer.Size = UDim2.new(1, 0, 1, 0)
		PageContainer.LayoutOrder = LayoutOrder
		PageContainer.BackgroundTransparency = 0

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = PageContainer

		PageTitle.Name = "GUITextColor"
		PageTitle.Parent = PageContainer
		PageTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageTitle.BackgroundTransparency = 1.000
		PageTitle.Position = UDim2.new(0, 5, 0, 0)
		PageTitle.Size = UDim2.new(1, 0, 0, 25)
		PageTitle.Font = Enum.Font.GothamBold
		PageTitle.Text = Page_Title
		PageTitle.TextSize = 16.000
		PageTitle.TextXAlignment = Enum.TextXAlignment.Left
		PageTitle.TextColor3 = getgenv().UIColor["GUI Text Color"]

		PageList.Name = "PageList"
		PageList.Parent = PageContainer
		PageList.Active = true
		PageList.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
		PageList.BackgroundTransparency = 1.000
		PageList.BorderColor3 = Color3.fromRGB(27, 42, 53)
		PageList.BorderSizePixel = 0
		PageList.Position = UDim2.new(0, 5, 0, 30)
		PageList.Size = UDim2.new(1, -10, 1, -30)
		PageList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollBarThickness = 5
		PageList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollingEnabled = true
		PageList.VerticalScrollBarInset = Enum.ScrollBarInset.Always

		Pagelistlayout.Name = "Pagelistlayout"
		Pagelistlayout.Parent = PageList
		Pagelistlayout.SortOrder = Enum.SortOrder.LayoutOrder
		Pagelistlayout.Padding = UDim.new(0, 5)
		Pagelistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageList.CanvasSize = UDim2.new(0, 0, 0, Pagelistlayout.AbsoluteContentSize.Y)
		end)

		local PageSearch = Instance.new("Frame")
		local PageSearchCorner = Instance.new("UICorner")
		local SearchFrame = Instance.new("Frame")
		local SearchIcon = Instance.new("ImageLabel")
		local SearchButton = Instance.new("TextButton")
		local SearchBox = Instance.new("TextBox")

		PageSearch.Name = "Page Search"
		PageSearch.Parent = PageContainer
		PageSearch.AnchorPoint = Vector2.new(1, 0)
		PageSearch.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
		PageSearch.Position = UDim2.new(1, -5, 0, 5)
		PageSearch.Size = UDim2.new(0, 20, 0, 20)
		PageSearch.ClipsDescendants = true

		PageSearchCorner.CornerRadius = UDim.new(0, 2)
		PageSearchCorner.Name = "PageSearchCorner"
		PageSearchCorner.Parent = PageSearch

		SearchFrame.Name = "SearchFrame"
		SearchFrame.Parent = PageSearch
		SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchFrame.BackgroundTransparency = 1.000
		SearchFrame.Size = UDim2.new(0, 20, 0, 20)

		SearchIcon.Name = "SearchIcon"
		SearchIcon.Parent = SearchFrame
		SearchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchIcon.BackgroundTransparency = 1.000
		SearchIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchIcon.Size = UDim2.new(0, 16, 0, 16)
		SearchIcon.Image = "rbxassetid://8154282545"
		SearchIcon.ImageColor3 = getgenv().UIColor["Search Icon Color"]

		SearchButton.Name = "Search Button"
		SearchButton.Parent = SearchFrame
		SearchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchButton.BackgroundTransparency = 1.000
		SearchButton.Size = UDim2.new(1, 0, 1, 0)
		SearchButton.Font = Enum.Font.SourceSans
		SearchButton.Text = ""
		SearchButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		SearchButton.TextSize = 14.000

		SearchBox.Name = "Search Box"
		SearchBox.Parent = PageSearch
		SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SearchBox.BackgroundTransparency = 1.000
		SearchBox.Position = UDim2.new(0, 30, 0, 0)
		SearchBox.Size = UDim2.new(1, -30, 1, 0)
		SearchBox.Font = Enum.Font.GothamBold
		SearchBox.Text = ""
		SearchBox.TextSize = 14.000
		SearchBox.TextXAlignment = Enum.TextXAlignment.Left
		SearchBox.PlaceholderText = "Search Section name"
		SearchBox.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		SearchBox.TextColor3 = getgenv().UIColor["Text Color"]
		
		local Openned = false 

		SearchButton.MouseEnter:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
			}):Play()
		end)

		SearchButton.MouseLeave:Connect(function()
			TweenService:Create(SearchIcon, TweenInfo.new(getgenv().UIColor["Tween Animation 3 Speed"]), {
				ImageColor3 = getgenv().UIColor["Search Icon Color"]
			}):Play()
		end)

		SearchButton.MouseButton1Click:Connect(function()
			Openned = not Openned
			local size = Openned and UDim2.new(0, 175, 0, 20) or  UDim2.new(0, 20, 0, 20)
			game.TweenService:Create(PageSearch, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
				Size = size
			}):Play()
		end)

		local function hideOtherFrame()
			for i, v in next, PageList:GetChildren() do 
				if not v:IsA('UIListLayout') then 
					v.Visible = false
				end
			end
		end
		
		local function showFrameName()
			for i, v in pairs(PageList:GetChildren()) do
				if not v:IsA('UIListLayout') then 
					if string.find(string.lower(v.Name), string.lower(SearchBox.Text)) then 
						v.Visible = true
					end
				end
			end
		end
		
		SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			hideOtherFrame()
			showFrameName()
		end)

		for i, v in pairs(ControlList:GetChildren()) do
			if not (v:IsA('UIListLayout')) then
				if i == 2 then 
					v.Frame.Line.PageInLine.BackgroundTransparency = 0
				end
			end
		end

		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then 
				return
			end

			for i, v in pairs(MainPage:GetChildren()) do
				if not (v:IsA('UIPageLayout')) and not (v:IsA('UICorner')) then
					v.Visible = false
				end
			end

			PageContainer.Visible = true 
			UIPage:JumpTo(PageContainer)

			for i, v in next, ControlList:GetChildren() do
				if not (v:IsA('UIListLayout')) then
					if v.Name == Page_Name .. "_Control" then 
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 0
						}):Play()
					else
						TweenService:Create(v.Frame.Line.PageInLine, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
							BackgroundTransparency = 1
						}):Play()
					end
				end
			end
		end)

		local pageFunction = {}

		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			local Toggleable = Toggleable or false
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Topsec = Instance.new("Frame")
			local Sectiontitle = Instance.new("TextLabel")
			local Linesec = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("UIListLayout")
			
			Section.Name = Section_Name .. "_Dot"
			Section.Parent = PageList
			Section.Size = UDim2.new(1, -5, 0, 35)
			Section.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			Section.BackgroundTransparency = 0
			Section.ClipsDescendants = false

			local sectionStroke = Instance.new("UIStroke", Section)
			sectionStroke.Color = Color3.fromRGB(90, 0, 160)
			sectionStroke.Thickness = 1


			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Section

			Topsec.Name = "Topsec"
			Topsec.Parent = Section
			Topsec.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Topsec.BackgroundTransparency = 1.000
			Topsec.Size = UDim2.new(1, 0, 0, 30)

			Sectiontitle.Name = "Sectiontitle"
			Sectiontitle.Parent = Topsec
			Sectiontitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
			Sectiontitle.BackgroundTransparency = 1.000
			Sectiontitle.Size = UDim2.new(1, 0, 1, 0)
			Sectiontitle.Font = Enum.Font.GothamBold
			Sectiontitle.Text = Section_Name
			Sectiontitle.TextSize = 14.000
			Sectiontitle.TextColor3 = getgenv().UIColor["Section Text Color"]

			Linesec.Name = "Linesec"
			Linesec.Parent = Topsec
			Linesec.AnchorPoint = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel = 0
			Linesec.Position = UDim2.new(0.5, 0, 1, -2)
			Linesec.Size = UDim2.new(1, -10, 0, 2)
			Linesec.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]

			local LineShadow = Instance.new("ImageLabel", Linesec)
			LineShadow.Name = "LineShadow"
			LineShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			LineShadow.BackgroundColor3 = Color3.fromRGB(163,162,165)
			LineShadow.BackgroundTransparency = 1
			LineShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			LineShadow.Size = UDim2.new(1, 8, 1, 8)
			LineShadow.ZIndex = 0
			LineShadow.Image = "rbxassetid://5028857084"
			LineShadow.ImageTransparency = 0.6
			LineShadow.ScaleType = Enum.ScaleType.Slice
			LineShadow.SliceCenter = Rect.new(24, 24, 276, 276)

			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.51, 0.02),
				NumberSequenceKeypoint.new(1, 1)
			}
			UIGradient.Parent = Linesec

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 5)

			local SizeSectionY
			local sectionIsVisible = false
			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame")
				local VisibilitySectionFrameCorner = Instance.new("UICorner")
				local visibility = Instance.new("ImageButton")
				local visibility_off = Instance.new("ImageButton")
				local VisibilityButton = Instance.new("TextButton")
				VisibilityButton.Name = "VisibilityButton"
				VisibilityButton.Parent = Topsec
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				VisibilityButton.BackgroundTransparency = 1.000
				VisibilityButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.BorderSizePixel = 0
				VisibilityButton.Font = Enum.Font.SourceSans
				VisibilityButton.Text = ""
				VisibilityButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				VisibilityButton.TextSize = 14.000
				VisibilityButton.ZIndex = 2
				VisibilityButton.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilityButton.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrame.Name = "VisibilitySectionFrame"
				VisibilitySectionFrame.Parent = Topsec
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				VisibilitySectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				VisibilitySectionFrame.BorderSizePixel = 0
				VisibilitySectionFrame.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilitySectionFrame.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 4)
				VisibilitySectionFrameCorner.Name = "VisibilitySectionFrameCorner"
				VisibilitySectionFrameCorner.Parent = VisibilitySectionFrame
				visibility.Name = "visibility"
				visibility.Parent = VisibilitySectionFrame
				visibility.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1.000
				visibility.LayoutOrder = 4
				visibility.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex = 2
				visibility.Image = "rbxassetid://3926307971"
				visibility.ImageRectOffset = Vector2.new(84, 44)
				visibility.ImageRectSize = Vector2.new(36, 36)
				visibility.ImageTransparency = 1
				visibility_off.Name = "visibility_off"
				visibility_off.Parent = VisibilitySectionFrame
				visibility_off.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1.000
				visibility_off.LayoutOrder = 4
				visibility_off.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex = 2
				visibility_off.Image = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset = Vector2.new(564, 44)
				visibility_off.ImageRectSize = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0
				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					TweenService:Create(visibility, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 0 or 1
					}):Play()
					task.wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					TweenService:Create(visibility_off, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 1 or 0
					}):Play()
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, (sectionIsVisible and SizeSectionY or 30))
					}):Play()
				end)
			end
			if SectionGap then
				local SectionGap = Instance.new("Frame")
				SectionGap.Name = "SectionGap"
				SectionGap.Parent = PageList
				SectionGap.Size = UDim2.new(1, -5, 0, 30)
				SectionGap.ClipsDescendants = true
				SectionGap.Transparency = 1
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SizeSectionY = SectionList.AbsoluteContentSize.Y + 35
				if not Toggleable then
					Section.Size = UDim2.new(1, -5, 0, SizeSectionY)
				elseif sectionIsVisible then
					Section.Size = UDim2.new(1, -5, 0, SizeSectionY)
				end
			end)
			local sectionFunction = {}
			function sectionFunction:AddToggle(idk,Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description
				local Default = Setting.Default
				if Default == nil then
					Default = false
				end
				local Callback = Setting.Callback
				local ToggleFrame = Instance.new("Frame")
				local TogFrame1 = Instance.new("Frame")
				local checkbox = Instance.new("ImageLabel")
				local check = Instance.new("Frame")
				local ToggleDesc = Instance.new("TextLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleBg = Instance.new("Frame")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleButton = Instance.new("TextButton")
				local ToggleList = Instance.new("UIListLayout")
				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Section
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleFrame.BackgroundTransparency = 1.000
				ToggleFrame.Position = UDim2.new(0, 0, 0.300000012, 0)
				ToggleFrame.Size = UDim2.new(1, 0 , 0, 0)
				ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
				TogFrame1.Name = "TogFrame1"
				TogFrame1.Parent = ToggleFrame
				TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
				TogFrame1.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				TogFrame1.BackgroundTransparency = 1.000
				TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
				TogFrame1.Size = UDim2.new(1, -10, 0, 0)
				TogFrame1.AutomaticSize = Enum.AutomaticSize.Y
				checkbox.Name = "checkbox"
				checkbox.Parent = TogFrame1
				checkbox.AnchorPoint = Vector2.new(1, 0.5)
				checkbox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				checkbox.BackgroundTransparency = 1.000
				checkbox.Position = UDim2.new(1, -5, 0.5, 3)
				checkbox.Size = UDim2.new(0, 25, 0, 25)
				checkbox.Image = "rbxassetid://4552505888"
				checkbox.ImageColor3 = getgenv().UIColor["Toggle Border Color"]
				check.Name = "check"
				check.Parent = checkbox
				check.AnchorPoint = Vector2.new(0.5, 0.5)
				check.BackgroundColor3 = Color3.fromRGB(130, 0, 200)
				check.Position = UDim2.new(0.5, 0, 0.5, 0)
				local cac = 5
				if Desc then
					cac = 0
					ToggleDesc.Name = "ToggleDesc"
					ToggleDesc.Parent = TogFrame1
					ToggleDesc.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
					ToggleDesc.BackgroundTransparency = 1.000
					ToggleDesc.Position = UDim2.new(0, 15, 0, 20)
					ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
					ToggleDesc.Font = Enum.Font.GothamBlack
					ToggleDesc.Text = Desc
					ToggleDesc.TextSize = 13.000
					ToggleDesc.TextWrapped = true
					ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
					ToggleDesc.RichText = true
					ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
					ToggleDesc.TextColor3 = getgenv().UIColor["Toggle Desc Color"]
				else
					ToggleDesc.Text = ''
				end
				ToggleTitle.Name = "TextColor"
				ToggleTitle.Parent = TogFrame1
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleTitle.BackgroundTransparency = 1.000
				ToggleTitle.Position = UDim2.new(0, 10, 0, cac)
				ToggleTitle.Size = UDim2.new(1, -10, 0, 20)
				ToggleTitle.Font = Enum.Font.GothamBlack
				ToggleTitle.Text = Title
				ToggleTitle.TextSize = 14.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
				ToggleTitle.RichText = true
				ToggleTitle.AutomaticSize = Enum.AutomaticSize.Y
				ToggleTitle.TextColor3 = getgenv().UIColor["Text Color"]
				ToggleBg.Name = "Background1"
				ToggleBg.Parent = TogFrame1
				ToggleBg.Size = UDim2.new(1, 0, 1, 6)
				ToggleBg.ZIndex = 0
				ToggleBg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ToggleCorner.CornerRadius = UDim.new(0, 4)
				ToggleCorner.Name = "ToggleCorner"
				ToggleCorner.Parent = ToggleBg
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = TogFrame1
				ToggleButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ToggleButton.BackgroundTransparency = 1.000
				ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
				ToggleButton.Size = UDim2.new(0, 25, 0, 25)
				ToggleButton.Position = UDim2.new(1, -5, 0.5, 3)
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleButton.TextSize = 14.000
				ToggleList.Name = "ToggleList"
				ToggleList.Parent = ToggleFrame
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
				ToggleList.Padding = UDim.new(0, 5)
				local function ChangeStage(val)
					local csize = val and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0, 0, 0, 0)
					local pos = val and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 0)
					local apos = val and Vector2.new(0.5, 0.5) or Vector2.new(0.5, 0.5)
					game.TweenService:Create(check, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = csize,
						Position = pos,
						AnchorPoint = apos
					}):Play()
				end
				ChangeStage(Default)
				local function ButtonClick()
					Default = not Default
				    ChangeStage(Default)
				    if Callback then
				        pcall(Callback, Default)
				    end
				end
				ToggleButton.MouseButton1Down:Connect(function()
					ButtonClick()
				end)
				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then
						ButtonClick()
					end
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = ToggleFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return toggleFunction
			end
        function sectionFunction:AddButton(Setting, Callback)
        	local Title = Setting.Title or Setting.Text or ""
        	local Callback = Setting.Callback or Setting.Func or function() end
            local Button = Instance.new("Frame")
            local RowBG_1 = Instance.new("Frame")
            local UICorner_1 = Instance.new("UICorner")
            local RowHover_1 = Instance.new("Frame")
            local UICorner_2 = Instance.new("UICorner")
            local TextColor_1 = Instance.new("TextLabel")
            local ClickArea_1 = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")
            local UIGradient_1 = Instance.new("UIGradient")
            local ImageLabel_1 = Instance.new("ImageLabel")
            local Frame_1 = Instance.new("Frame")
            local UICorner_4 = Instance.new("UICorner")
            local UIScale_1 = Instance.new("UIScale")
            local Button_1 = Instance.new("TextButton")
            
            Button.Name = "Button"
            Button.Parent = Section
            Button.BackgroundColor3 = Color3.fromRGB(163,162,165)
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0,0, 40)
             
            RowBG_1.Name = "RowBG"
            RowBG_1.Parent = Button
            RowBG_1.AnchorPoint = Vector2.new(0.5, 0.5)
            RowBG_1.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
            RowBG_1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
            RowBG_1.Position = UDim2.new(0.5, 0,0.5, 0)
            RowBG_1.Size = UDim2.new(1, -10,1, 0)
             
            UICorner_1.Parent = RowBG_1
            UICorner_1.CornerRadius = UDim.new(0,10)
             
            RowHover_1.Name = "RowHover"
            RowHover_1.Parent = RowBG_1
            RowHover_1.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
            RowHover_1.BackgroundTransparency = 1
            RowHover_1.Size = UDim2.new(1, 0,1, 0)
            RowHover_1.ZIndex = 2
             
            UICorner_2.Parent = RowHover_1
            UICorner_2.CornerRadius = UDim.new(0,10)
             
            TextColor_1.Name = "TextColor"
            TextColor_1.Parent = RowBG_1
             TextColor_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             TextColor_1.BackgroundTransparency = 1
             TextColor_1.Position = UDim2.new(0, 12,0, 0)
             TextColor_1.Size = UDim2.new(1, -110,1, 0)
             TextColor_1.Font = Enum.Font.GothamBold
             TextColor_1.Text = Title
             TextColor_1.TextColor3 = getgenv().UIColor["GUI Text Color"]
             TextColor_1.TextSize = 14
             TextColor_1.TextStrokeTransparency = 0.8500000238418579
             TextColor_1.TextXAlignment = Enum.TextXAlignment.Left
             
             ClickArea_1.Name = "ClickArea"
             ClickArea_1.Parent = RowBG_1
             ClickArea_1.AnchorPoint = Vector2.new(1, 0.5)
             ClickArea_1.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
             ClickArea_1.Position = UDim2.new(1, -8,0.5, 0)
             ClickArea_1.Size = UDim2.new(0, 94,0, 30)
             ClickArea_1.ClipsDescendants = true
             
             UICorner_3.Parent = ClickArea_1
             UICorner_3.CornerRadius = UDim.new(0,12)
             
             UIGradient_1.Parent = ClickArea_1
             UIGradient_1.Color = ColorSequence.new{
                 ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 20, 180)), 
                 ColorSequenceKeypoint.new(0.4, Color3.fromRGB(90, 0, 160)), 
                 ColorSequenceKeypoint.new(0.6, Color3.fromRGB(235, 186, 17)), 
                 ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 166, 7))
             }
             UIGradient_1.Rotation = 90
             
             ImageLabel_1.Parent = ClickArea_1
             ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
             ImageLabel_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             ImageLabel_1.BackgroundTransparency = 1
             ImageLabel_1.Position = UDim2.new(0.5, 0,0.5, 0)
             ImageLabel_1.Size = UDim2.new(1, 14,1, 14)
             ImageLabel_1.ZIndex = 0
             ImageLabel_1.Image = "rbxassetid://5028857084"
             ImageLabel_1.ImageTransparency = 0.7
             ImageLabel_1.ScaleType = Enum.ScaleType.Slice
             ImageLabel_1.SliceCenter = Rect.new(24, 24, 276, 276)
             
             Frame_1.Parent = ClickArea_1
             Frame_1.AnchorPoint = Vector2.new(0.5, 0)
             Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
             Frame_1.BackgroundTransparency = 0.8
             Frame_1.Position = UDim2.new(0.5, 0,0, 2)
             Frame_1.Size = UDim2.new(1, -6,0, 10)
             Frame_1.ZIndex = 2
             
             UICorner_4.Parent = Frame_1
             UICorner_4.CornerRadius = UDim.new(0,10)
             
             UIScale_1.Parent = ClickArea_1
             
             Button_1.Name = "Button"
             Button_1.Parent = ClickArea_1
             Button_1.Active = true
             Button_1.AutoButtonColor = false
             Button_1.BackgroundColor3 = Color3.fromRGB(163,162,165)
             Button_1.BackgroundTransparency = 1
             Button_1.Size = UDim2.new(1, 0,1, 0)
             Button_1.Font = Enum.Font.GothamBold
             Button_1.Text = "Click"
             Button_1.TextColor3 = Color3.fromRGB(240, 240, 240)
             Button_1.TextSize = 13

             UIScale_1.Scale = 1
             
             local scaleHover = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.05 })
             local scaleNormal = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1 })
             
             Button_1.MouseEnter:Connect(function()
             	scaleHover:Play()
             end)
             
             Button_1.MouseLeave:Connect(function()
             	scaleNormal:Play()
             end)
             
                Button_1.MouseButton1Down:Connect(function()
                    
                    local w = ClickArea_1.AbsoluteSize.X
                    local h = ClickArea_1.AbsoluteSize.Y
                    
                    local ripple = Instance.new("Frame")
                    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
                    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
                    ripple.Size = UDim2.new(0, 0, 0, 0)
                    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ripple.BackgroundTransparency = 0.6
                    ripple.ZIndex = 20
                    ripple.Parent = ClickArea_1
                    
                    local rippleCorner = Instance.new("UICorner")
                    rippleCorner.CornerRadius = UICorner_3.CornerRadius
                    rippleCorner.Parent = ripple
                    
                    local rippleTween = TweenService:Create(
                        ripple,
                        TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, 0, 0.5, 0)
                        }
                    )
                    
                    rippleTween:Play()
                    rippleTween.Completed:Connect(function()
                        ripple:Destroy()
                    end)
                    
                    Callback()
                end)
                local f = {}
                function f:SetTitle(vl)
                    TextColor_1.Text = vl
                end
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = Button,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return f
            end
        
			function sectionFunction:AddLabel(text)
				local Title = text
                local LabelFrame = Instance.new("Frame")
                local LabelBG = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextColor = Instance.new("TextLabel")
                
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Section
                LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
                LabelFrame.BackgroundColor3 = Color3.fromRGB(163,162,165)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0,0, 0)
                
                LabelBG.Name = "LabelBG"
                LabelBG.Parent = LabelFrame
                LabelBG.AnchorPoint = Vector2.new(0.5, 0)
                LabelBG.AutomaticSize = Enum.AutomaticSize.Y
                LabelBG.BackgroundColor3 = Color3.fromRGB(38,38,46)
                LabelBG.BackgroundTransparency = 0.25
                LabelBG.Position = UDim2.new(0.5, 0,0, 0)
                LabelBG.Size = UDim2.new(1, -10,0, -10)
                
                UICorner.Parent = LabelBG
                UICorner.CornerRadius = UDim.new(0,6)
                
                
                TextColor.Name = "TextColor"
                TextColor.Parent = LabelBG
                TextColor.AutomaticSize = Enum.AutomaticSize.Y
                TextColor.BackgroundColor3 = Color3.fromRGB(163,162,165)
                TextColor.BackgroundTransparency = 1
                TextColor.Position = UDim2.new(0, 12,0, 6)
                TextColor.Size = UDim2.new(1, -24,1, -12)
                TextColor.Font = Enum.Font.GothamMedium
                TextColor.Text = Title
                TextColor.TextColor3 = Color3.fromRGB(240,240,230)
                TextColor.TextSize = 14
                TextColor.TextStrokeTransparency = 0.8500000238418579
                TextColor.TextWrapped = true
                TextColor.TextXAlignment = Enum.TextXAlignment.Left
				local labelFunction = {}
				function labelFunction:SetText(text)
					TextColor.Text = text
				end
				function labelFunction.SetColor(color)
					TextColor.TextColor3 = color
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = LabelFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return labelFunction
			end
            function sectionFunction:AddDropdownSection(Setting)
                local Title = tostring(Setting.Text or Setting.Title or "")
                local Search = Setting.Search or false
              
                local DropdownFrame = Instance.new("Frame")
                local Dropdownbg = Instance.new("Frame")
                local Dropdowncorner = Instance.new("UICorner")
                local Topdrop = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ImgDrop = Instance.new("ImageLabel")
                local DropdownButton = Instance.new("TextButton")
                local Dropdownlisttt = Instance.new("Frame")
                local DropdownScroll = Instance.new("ScrollingFrame")
                local ScrollContainer = Instance.new("Frame")
                local ScrollContainerList = Instance.new("UIListLayout")
                
                DropdownFrame.Name = Title .. "DropdownSectionFrame"
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
                
                Dropdownbg.Name = "Background1"
                Dropdownbg.Parent = DropdownFrame
                Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
                Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
                Dropdownbg.ClipsDescendants = true
                Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
                Dropdownbg.BackgroundTransparency = 0
                
                Dropdowncorner.CornerRadius = UDim.new(0, 4)
                Dropdowncorner.Name = "Dropdowncorner"
                Dropdowncorner.Parent = Dropdownbg
                
                Topdrop.Name = "Background2"
                Topdrop.Parent = Dropdownbg
                Topdrop.Size = UDim2.new(1, 0, 0, 25)
                Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Topdrop
                
                local Dropdowntitle
                if Search then
                    Dropdowntitle = Instance.new("TextBox")
                    Dropdowntitle.PlaceholderText = Title
                    Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                else
                    Dropdowntitle = Instance.new("TextLabel")
                    Dropdowntitle.Text = Title
                end
                
                Dropdowntitle.Name = "TextColorPlaceholder"
                Dropdowntitle.Parent = Topdrop
                Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                Dropdowntitle.BackgroundTransparency = 1.000
                Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
                Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
                Dropdowntitle.Font = Enum.Font.GothamBlack
                Dropdowntitle.TextSize = 14.000
                Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
                Dropdowntitle.ClipsDescendants = true
                Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
                
                ImgDrop.Name = "ImgDrop"
                ImgDrop.Parent = Topdrop
                ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
                ImgDrop.BackgroundTransparency = 1.000
                ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
                ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
                ImgDrop.Size = UDim2.new(0, 15, 0, 15)
                ImgDrop.Image = "rbxassetid://6954383209"
                ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Topdrop
                DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.BackgroundTransparency = 1.000
                DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
                DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
                DropdownButton.Font = Enum.Font.GothamBold
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                DropdownButton.TextSize = 14.000
                
                Dropdownlisttt.Name = "Dropdownlisttt"
                Dropdownlisttt.Parent = Dropdownbg
                Dropdownlisttt.BackgroundTransparency = 1.000
                Dropdownlisttt.BorderSizePixel = 0
                Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
                Dropdownlisttt.Size = UDim2.new(1, 0, 0, 0)
                Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                
                DropdownScroll.Name = "DropdownScroll"
                DropdownScroll.Parent = Dropdownlisttt
                DropdownScroll.Active = true
                DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                DropdownScroll.BackgroundTransparency = 1.000
                DropdownScroll.BorderSizePixel = 0
                DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
                DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownScroll.ScrollBarThickness = 5
                DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.ScrollingEnabled = true
                DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                
                ScrollContainer.Name = "ScrollContainer"
                ScrollContainer.Parent = DropdownScroll
                ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                ScrollContainer.BackgroundTransparency = 1.000
                ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
                ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
                
                ScrollContainerList.Name = "ScrollContainerList"
                ScrollContainerList.Parent = ScrollContainer
                ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
                ScrollContainerList.Padding = UDim.new(0, 5)
                
                local InternalSection = Instance.new("Frame")
                InternalSection.Name = "InternalSection"
                InternalSection.Parent = ScrollContainer
                InternalSection.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                InternalSection.BackgroundTransparency = 1.000
                InternalSection.Size = UDim2.new(1, 0, 0, 0)
                InternalSection.AutomaticSize = Enum.AutomaticSize.Y
                
                local InternalList = Instance.new("UIListLayout")
                InternalList.Name = "InternalList"
                InternalList.Parent = InternalSection
                InternalList.SortOrder = Enum.SortOrder.LayoutOrder
                InternalList.Padding = UDim.new(0, 5)
                
                local isOpen = false
                
                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    
                    local listsize = isOpen and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, 230) or UDim2.new(1, 0, 0, 25)
                    local DropCRotation = isOpen and 90 or 0
                    
                    TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = listsize
                    }):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = mainsize
                    }):Play()
                    TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Rotation = DropCRotation
                    }):Play()
                end)
                
                ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
                end)
                
                InternalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = math.min(InternalList.AbsoluteContentSize.Y + 10, 300)
                    local listsize = isOpen and UDim2.new(1, 0, 0, contentHeight) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, contentHeight + 25) or UDim2.new(1, 0, 0, 25)
                    
                    if isOpen then
                        TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = listsize
                        }):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = mainsize
                        }):Play()
                    end
                end)
                
                local dropdownSectionFunction = {}
                
                function dropdownSectionFunction:AddSlider(Setting)
                    local TitleText = tostring(Setting.Text or Setting.Title) or ""
                    local minValue = tonumber(Setting.Min) or 0
                    local maxValue = tonumber(Setting.Max) or 100
                    local Precise = Setting.Precise or false
                    local DefaultValue = tonumber(Setting.Default) or 0
                    local Callback = Setting.Callback
                    local Rounding = Setting.Rouding or Setting.Rounding
                    
                    local SliderFrame = Instance.new("Frame")
                    local SliderCorner = Instance.new("UICorner")
                    local SliderBG = Instance.new("Frame")
                    local SliderBGCorner = Instance.new("UICorner")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderBar = Instance.new("Frame")
                    local SliderButton = Instance.new("TextButton")
                    local SliderBarCorner = Instance.new("UICorner")
                    local Bar = Instance.new("Frame")
                    local BarCorner = Instance.new("UICorner")
                    local Sliderboxframe = Instance.new("Frame")
                    local Sliderbox = Instance.new("UICorner")
                    local Sliderbox_2 = Instance.new("TextBox")
                    
                    SliderFrame.Name = TitleText
                    SliderFrame.Parent = InternalSection
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    SliderFrame.BackgroundTransparency = 1.000
                    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                    
                    SliderCorner.CornerRadius = UDim.new(0, 4)
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.Parent = SliderFrame
                    
                    SliderBG.Name = "Background1"
                    SliderBG.Parent = SliderFrame
                    SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
                    SliderBG.Size = UDim2.new(1, -5, 1, 0)
                    SliderBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    SliderBG.BackgroundTransparency = 0.25
                    
                    SliderBGCorner.CornerRadius = UDim.new(0, 4)
                    SliderBGCorner.Name = "SliderBGCorner"
                    SliderBGCorner.Parent = SliderBG
                    
                    SliderTitle.Name = "TextColor"
                    SliderTitle.Parent = SliderBG
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                    SliderTitle.Size = UDim2.new(0.65, -10, 0, 25)
                    SliderTitle.Font = Enum.Font.GothamBlack
                    SliderTitle.Text = TitleText
                    SliderTitle.TextSize = 14.000
                    SliderTitle.RichText = true
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderBar.Name = "SliderBar"
                    SliderBar.Parent = SliderFrame
                    SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBar.Position = UDim2.new(0.5, 0, 0.5, 14)
                    SliderBar.Size = UDim2.new(0.9, 0, 0, 6)
                    SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    SliderButton.Name = "SliderButton"
                    SliderButton.Parent = SliderBar
                    SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.BackgroundTransparency = 1.000
                    SliderButton.Size = UDim2.new(1, 0, 1, 0)
                    SliderButton.Font = Enum.Font.GothamBold
                    SliderButton.Text = ""
                    SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
                    SliderButton.TextSize = 14.000
                    
                    SliderBarCorner.CornerRadius = UDim.new(1, 0)
                    SliderBarCorner.Name = "SliderBarCorner"
                    SliderBarCorner.Parent = SliderBar
                    
                    Bar.Name = "Bar"
                    Bar.BorderSizePixel = 0
                    Bar.Parent = SliderBar
                    Bar.Size = UDim2.new(0, 0, 1, 0)
                    Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                    
                    BarCorner.CornerRadius = UDim.new(1, 0)
                    BarCorner.Name = "BarCorner"
                    BarCorner.Parent = Bar
                    
                    Sliderboxframe.Name = "Background2"
                    Sliderboxframe.Parent = SliderFrame
                    Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
                    Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
                    Sliderboxframe.Size = UDim2.new(0.25, 0, 0, 25)
                    Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
                    
                    Sliderbox.CornerRadius = UDim.new(0, 4)
                    Sliderbox.Name = "Sliderbox"
                    Sliderbox.Parent = Sliderboxframe
                    
                    Sliderbox_2.Name = "TextColor"
                    Sliderbox_2.Parent = Sliderboxframe
                    Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
                    Sliderbox_2.BackgroundTransparency = 1.000
                    Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
                    Sliderbox_2.Font = Enum.Font.GothamBold
                    Sliderbox_2.Text = ""
                    Sliderbox_2.TextSize = 14.000
                    Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
                    
                    SliderButton.MouseEnter:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
                        }):Play()
                    end)
                    
                    SliderButton.MouseLeave:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                        }):Play()
                    end)
                    
                    local callBackAndSetText = function(val)
                        Sliderbox_2.Text = tostring(val)
                        Callback(tonumber(val))
                    end
                    if DefaultValue then
                        if DefaultValue <= minValue then
                            DefaultValue = minValue
                        elseif DefaultValue >= maxValue then
                            DefaultValue = maxValue
                        end
                        Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                        Sliderbox_2.Text = tostring(DefaultValue)
                    end
                    
                    
                    local dragging = false
                    local dragInput
                    local holdTime = 0
                    local holdStarted = 0
                    
                    local function onInputBegan(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            holdStarted = tick()
                            
                            input.Changed:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    dragging = false
                                    holdStarted = 0
                                end
                            end)
                        end
                    end
                    
                    local function onInputEnded(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            holdStarted = 0
                        end
                    end
                    
                    local function onInputChanged(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            dragInput = input
                        end
                    end
                    
                    SliderButton.InputBegan:Connect(onInputBegan)
                    SliderButton.InputEnded:Connect(onInputEnded)
                    SliderButton.InputChanged:Connect(onInputChanged)
                    
                    RunService.RenderStepped:Connect(function()
                        if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
                            dragging = true
                        end
                        
                        if dragging and dragInput then
                            local barWidth = math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                            local percentage = barWidth / SliderBar.AbsoluteSize.X
                            local value = minValue + (maxValue - minValue) * percentage
                            
                            if Rounding then
                                value = tonumber(string.format("%.".. Rounding .."f", value))
                            elseif not Precise then
                                value = math.floor(value)
                            end
                            
                            value = math.clamp(value, minValue, maxValue)
                            
                            pcall(function()
                                callBackAndSetText(value)
                            end)
                            Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        end
                    end)
                    
                    local function GetSliderValue(Value)
                        Value = tonumber(Value) or minValue
                        Value = math.clamp(Value, minValue, maxValue)
                        
                        if Rounding then
                            Value = tonumber(string.format("%.".. Rounding .."f", Value))
                        elseif not Precise then
                            Value = math.floor(Value)
                        end
                        
                        local percentage = (Value - minValue) / (maxValue - minValue)
                        Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        callBackAndSetText(Value)
                    end
                    
                    Sliderbox_2.FocusLost:Connect(function()
                        GetSliderValue(Sliderbox_2.Text)
                    end)
                    
                    local slider_function = {}
                    function slider_function.SetValue(Value)
                        GetSliderValue(Value)
                    end
                    
                    function slider_function.GetValue()
                        return tonumber(Sliderbox_2.Text) or minValue
                    end
                    
                    return slider_function
                end
                
                function dropdownSectionFunction:SetOpen(state)
                    if state ~= isOpen then
                        DropdownButton.MouseButton1Click:Fire()
                    end
                end
                
                function dropdownSectionFunction:GetOpen()
                    return isOpen
                end
                
                function dropdownSectionFunction:SetTitle(newTitle)
                    if Search then
                        Dropdowntitle.PlaceholderText = newTitle
                    else
                        Dropdowntitle.Text = newTitle
                    end
                end
                
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownSectionFunction
            end
            
			function sectionFunction:AddDropdown(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local List = Setting.Values
				local Search = Setting.Search or false
				local Selected = Setting.Selected or Setting.Multi or false
				local Slider = Setting.Slider or false
				local SliderRelease = Setting.SliderRelease or false
				local Default = (function ()
                    if Setting.Default then
                        if type(Setting.Default) == "number" then
                            return List[Setting.Default]
                        elseif type(Setting.Default) == "string" then
                            return Setting.Default
                        end
                    end
                    return nil
                end)()
				local Callback = Setting.Callback
				local pairs = Setting.SortPairs or pairs
				local DropdownFrame = Instance.new("Frame")
				local Dropdownbg = Instance.new("Frame")
				local Dropdowncorner = Instance.new("UICorner")
				local Topdrop = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImgDrop = Instance.new("ImageLabel")
				local DropdownButton = Instance.new("TextButton")
				local Dropdownlisttt = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local ScrollContainer = Instance.new("Frame")
				local ScrollContainerList = Instance.new("UIListLayout")
				local dropdownLeave = false
				local Dropdowntitle;
				if Search then
					Dropdowntitle = Instance.new("TextBox")
				else
					Dropdowntitle = Instance.new("TextLabel")
				end
				DropdownFrame.Name = Title .. "DropdownFrame"
				DropdownFrame.Parent = Section
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownFrame.BackgroundTransparency = 1.000
				DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
				DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
				Dropdownbg.Name = "Background1"
				Dropdownbg.Parent = DropdownFrame
				Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants = true
				Dropdownbg.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				Dropdowncorner.CornerRadius = UDim.new(0, 4)
				Dropdowncorner.Name = "Dropdowncorner"
				Dropdowncorner.Parent = Dropdownbg
				Topdrop.Name = "Background2"
				Topdrop.Parent = Dropdownbg
				Topdrop.Size = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Topdrop
				Dropdowntitle.Name = "TextColorPlaceholder"
				Dropdowntitle.Parent = Topdrop
				Dropdowntitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Dropdowntitle.BackgroundTransparency = 1.000
				Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font = Enum.Font.GothamBlack
				Dropdowntitle.Text = ''
				Dropdowntitle.TextSize = 14.000
				Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants = true
				local Sel = Instance.new("StringValue", Dropdowntitle)
				Sel.Value = ""
				if Default and table.find(List, Default) then
					Sel.Value = Default
				end
				if not Selected then
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "");
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "");
					end
				else
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "");
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "");
					end
				end
				Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]
				ImgDrop.Name = "ImgDrop"
				ImgDrop.Parent = Topdrop
				ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1.000
				ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
				ImgDrop.Size = UDim2.new(0, 15, 0, 15)
				ImgDrop.Image = "rbxassetid://6954383209"
				ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = Topdrop
				DropdownButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
				DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
				DropdownButton.Font = Enum.Font.GothamBold
				DropdownButton.Text = ""
				DropdownButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				DropdownButton.TextSize = 14.000
				Dropdownlisttt.Name = "Dropdownlisttt"
				Dropdownlisttt.Parent = Dropdownbg
				Dropdownlisttt.BackgroundTransparency = 1.000
				Dropdownlisttt.BorderSizePixel = 0
				Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size = UDim2.new(1, 0, 0, 25)
				Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = Dropdownlisttt
				DropdownScroll.Active = true
				DropdownScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				DropdownScroll.BackgroundTransparency = 1.000
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 5
				DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.ScrollingEnabled = true
				DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
				ScrollContainer.Name = "ScrollContainer"
				ScrollContainer.Parent = DropdownScroll
				ScrollContainer.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				ScrollContainer.BackgroundTransparency = 1.000
				ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
				ScrollContainerList.Name = "ScrollContainerList"
				ScrollContainerList.Parent = ScrollContainer
				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding = UDim.new(0, 5)
				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)
				local isbusy = false
				local found = {}
				local searchtable = {}
				local function edit()
					for i in pairs(found) do
						found[i] = nil
					end
					for h, l in pairs(ScrollContainer:GetChildren()) do
						if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
							l.Visible = false
						end
					end
					Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
				end
				local function SearchDropdown()
					local Results = {}
					for i, v in pairs(searchtable) do
						if string.find(v, Dropdowntitle.Text) then
							table.insert(found, v)
						end
					end
					for a, b in pairs(ScrollContainer:GetChildren()) do
						for c, d in pairs(found) do
							if d == b.Name then
								b.Visible = true
							end
						end
					end
				end
				local function clear_object_in_list()
					for i, v in next, ScrollContainer:GetChildren() do
						if v:IsA('Frame') then
							v:Destroy()
						end
					end
				end
				local ListNew
                local OrderedList = {}
                if Selected then
                    ListNew = {}
                    for _, value in ipairs(List) do
                        ListNew[value] = (value == Default)
                        table.insert(OrderedList, value)
                    end
                else
                    ListNew = List
                end
				local function refreshlist(SortPairs)
					pairs = SortPairs or pairs
					clear_object_in_list()
					searchtable = {}
					for i, v in pairs(ListNew) do
						if Selected then
							table.insert(searchtable, string.lower(i))
						elseif Slider then
							table.insert(searchtable, string.lower(v['Title']))
						else
							table.insert(searchtable, string.lower(v))
						end
					end
					if Selected then
                        for _, i in ipairs(OrderedList) do
                            local v = ListNew[i]
							local SampleItem = Instance.new("Frame")
							local SampleItemCorner = Instance.new("UICorner")
							local SampleItemBG = Instance.new("Frame")
							local SampleItemBGCorner = Instance.new("UICorner")
							local SampleItemTitle = Instance.new("TextLabel")
							local SampleItemCheck = Instance.new("ImageButton")
							local SampleItemButton = Instance.new("TextButton")
							SampleItem.Name = string.lower(i)
							SampleItem.Parent = ScrollContainer
							SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SampleItem.BackgroundTransparency = 1.000
							SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItem.LayoutOrder = 1
							SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
							SampleItem.Size = UDim2.new(1, 0, 0, 25)
							SampleItemCorner.CornerRadius = UDim.new(0, 4)
							SampleItemCorner.Name = "SampleItemCorner"
							SampleItemCorner.Parent = SampleItem
							SampleItemBG.Name = "SampleItemBG"
							SampleItemBG.Parent = SampleItem
							SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SampleItemBG.BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
							SampleItemBG.BackgroundTransparency = v and .5 or 1
							SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
							SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
							SampleItemBGCorner.Name = "SampleItemBGCorner"
							SampleItemBGCorner.Parent = SampleItemBG
							SampleItemTitle.Name = "SampleItemTitle"
							SampleItemTitle.Parent = SampleItemBG
							SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.BackgroundTransparency = 1.000
							SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
							SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
							SampleItemTitle.Font = Enum.Font.GothamBlack
							SampleItemTitle.Text = tostring(i)
							SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemTitle.TextSize = 14.000
							SampleItemTitle.TextStrokeTransparency = 0.500
							SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
							SampleItemCheck.Name = "SampleItemCheck"
							SampleItemCheck.Parent = SampleItemBG
							SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
							SampleItemCheck.BackgroundTransparency = 1.000
							SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
							SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
							SampleItemCheck.ZIndex = 2
							SampleItemCheck.Image = "rbxassetid://3926305904"
							SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
							SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
							SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
							SampleItemCheck.ImageTransparency = v and 0 or 1
							SampleItemButton.Name = "SampleItemButton"
							SampleItemButton.Parent = SampleItem
							SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemButton.BackgroundTransparency = 1.000
							SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
							SampleItemButton.BorderSizePixel = 0
							SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
							SampleItemButton.Font = Enum.Font.SourceSans
							SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
							SampleItemButton.TextSize = 14.000
							SampleItemButton.TextTransparency = 1.000
							SampleItemButton.MouseEnter:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = .7
								}
										):Play()
							end)
							SampleItemButton.MouseLeave:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = 1
								}
										):Play()
							end)
							SampleItemButton.MouseButton1Click:Connect(function()
								v = not v
								TweenService:Create(
											SampleItemCheck,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									ImageTransparency = v and 0 or 1
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = v and .5 or 1
								}
										):Play()
								if Callback then
									Callback(i, v)
									ListNew[i] = v
								end
								if Search then
									Dropdowntitle.PlaceholderText = Title .. ': '
								else
									Dropdowntitle.Text = Title .. ': '
								end
							end)
						end
					elseif Slider then
						for i, v in pairs(ListNew) do
							local TitleText = tostring(v.Title) or ""
							local minValue = tonumber(v.Min) or 0
							local maxValue = tonumber(v.Max) or 100
							local Precise = v.Precise or false
							local DefaultValue = tonumber(v.Default) or minValue
							local SizeChia = 365;
							local SliderFrame = Instance.new("Frame")
							local SliderCorner = Instance.new("UICorner")
							local SliderBG = Instance.new("Frame")
							local SliderBGCorner = Instance.new("UICorner")
							local SliderTitle = Instance.new("TextLabel")
							local SliderBar = Instance.new("Frame")
							local SliderButton = Instance.new("TextButton")
							local SliderBarCorner = Instance.new("UICorner")
							local Bar = Instance.new("Frame")
							local BarCorner = Instance.new("UICorner")
							local Sliderboxframe = Instance.new("Frame")
							local Sliderbox = Instance.new("UICorner")
							local Sliderbox_2 = Instance.new("TextBox")
							SliderFrame.Name = string.lower(v['Title'])
							SliderFrame.Parent = ScrollContainer
							SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
							SliderFrame.BackgroundTransparency = 1.000
							SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							SliderFrame.Size = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius = UDim.new(0, 4)
							SliderCorner.Name = "SliderCorner"
							SliderCorner.Parent = SliderFrame
							SliderBG.Name = "Background1"
							SliderBG.Parent = SliderFrame
							SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							SliderBGCorner.CornerRadius = UDim.new(0, 4)
							SliderBGCorner.Name = "SliderBGCorner"
							SliderBGCorner.Parent = SliderBG
							SliderTitle.Name = "TextColor"
							SliderTitle.Parent = SliderBG
							SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderTitle.BackgroundTransparency = 1.000
							SliderTitle.Position = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font = Enum.Font.GothamBlack
							SliderTitle.Text = TitleText
							SliderTitle.TextSize = 14.000
							SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
							SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
							SliderBar.Name = "SliderBar"
							SliderBar.Parent = SliderFrame
							SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
							SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
							SliderBar.Size = UDim2.new(1, -20, 0, 6)
							SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							SliderButton.Name = "SliderButton "
							SliderButton.Parent = SliderBar
							SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.BackgroundTransparency = 1.000
							SliderButton.Size = UDim2.new(1, 0, 1, 0)
							SliderButton.Font = Enum.Font.GothamBold
							SliderButton.Text = ""
							SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
							SliderButton.TextSize = 14.000
							SliderBarCorner.CornerRadius = UDim.new(1, 0)
							SliderBarCorner.Name = "SliderBarCorner"
							SliderBarCorner.Parent = SliderBar
							Bar.Name = "Bar"
							Bar.BorderSizePixel = 0
							Bar.Parent = SliderBar
							Bar.Size = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
							BarCorner.CornerRadius = UDim.new(1, 0)
							BarCorner.Name = "BarCorner"
							BarCorner.Parent = Bar
							Sliderboxframe.Name = "Background2"
							Sliderboxframe.Parent = SliderFrame
							Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
							Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
							Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
							Sliderbox.CornerRadius = UDim.new(0, 4)
							Sliderbox.Name = "Sliderbox"
							Sliderbox.Parent = Sliderboxframe
							Sliderbox_2.Name = "TextColor"
							Sliderbox_2.Parent = Sliderboxframe
							Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
							Sliderbox_2.BackgroundTransparency = 1.000
							Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font = Enum.Font.GothamBold
							Sliderbox_2.Text = ""
							Sliderbox_2.TextSize = 14.000
							Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
							SliderButton.MouseEnter:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
								}):Play()
							end)
							SliderButton.MouseLeave:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
								}):Play()
							end)
							local callBackAndSetText = function(val)
								Sliderbox_2.Text = val
								ListNew[i].Default = val
								Callback(i, v)
							end
							if DefaultValue then
								if DefaultValue <= minValue then
									DefaultValue = minValue
								elseif DefaultValue >= maxValue then
									DefaultValue = maxValue
								end
								Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
								callBackAndSetText(DefaultValue)
							end
							if SliderRelease then
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							else
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							end
							local function GetSliderValue(Value)
								if tonumber(Value) <= minValue then
									Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
									callBackAndSetText(minValue)
								elseif tonumber(Value) >= maxValue then
									Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
									callBackAndSetText(maxValue)
								else
									Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
									callBackAndSetText(Value)
								end
							end
							Sliderbox_2.FocusLost:Connect(function()
								GetSliderValue(Sliderbox_2.Text)
							end)
						end
					else
						for i, v in pairs (ListNew) do
							if typeof(v) == "string" then
								local SampleItem = Instance.new("Frame")
								local SampleItemCorner = Instance.new("UICorner")
								local SampleItemBG = Instance.new("Frame")
								local SampleItemBGCorner = Instance.new("UICorner")
								local SampleItemTitle = Instance.new("TextLabel")
								local SampleItemCheck = Instance.new("ImageButton")
								local SampleItemButton = Instance.new("TextButton")
								SampleItem.Name = string.lower(v)
								SampleItem.Parent = ScrollContainer
								SampleItem.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
								SampleItem.BackgroundTransparency = 1.000
								SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItem.LayoutOrder = 1
								SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
								SampleItem.Size = UDim2.new(1, 0, 0, 25)
								SampleItemCorner.CornerRadius = UDim.new(0, 4)
								SampleItemCorner.Name = "SampleItemCorner"
								SampleItemCorner.Parent = SampleItem
								SampleItemBG.Name = "SampleItemBG"
								SampleItemBG.Parent = SampleItem
								SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
								SampleItemBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemBG.BackgroundTransparency = 1
								SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
								SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
								SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
								SampleItemBGCorner.Name = "SampleItemBGCorner"
								SampleItemBGCorner.Parent = SampleItemBG
								SampleItemTitle.Name = "SampleItemTitle"
								SampleItemTitle.Parent = SampleItemBG
								SampleItemTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.BackgroundTransparency = 1.000
								SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
								SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
								SampleItemTitle.Font = Enum.Font.GothamBlack
								SampleItemTitle.Text = v
								SampleItemTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemTitle.TextSize = 14.000
								SampleItemTitle.TextStrokeTransparency = 0.500
								SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
								SampleItemCheck.Name = "SampleItemCheck"
								SampleItemCheck.Parent = SampleItemBG
								SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
								SampleItemCheck.BackgroundTransparency = 1.000
								SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
								SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
								SampleItemCheck.ZIndex = 2
								SampleItemCheck.Image = "rbxassetid://3926305904"
								SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
								SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
								SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
								SampleItemCheck.ImageTransparency = 1
								SampleItemButton.Name = "SampleItemButton"
								SampleItemButton.Parent = SampleItem
								SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemButton.BackgroundTransparency = 1.000
								SampleItemButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
								SampleItemButton.BorderSizePixel = 0
								SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
								SampleItemButton.Font = Enum.Font.SourceSans
								SampleItemButton.TextColor3 = getgenv().UIColor["Text Color"]
								SampleItemButton.TextSize = 14.000
								SampleItemButton.TextTransparency = 1.000
								SampleItemButton.MouseEnter:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .7
									}
											):Play()
								end)
								SampleItemButton.MouseLeave:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = 1
									}
											):Play()
								end)
								SampleItemButton.MouseButton1Click:Connect(function()
									if Search then
										Dropdowntitle.PlaceholderText = Title .. ': ' .. v or ""
										Sel.Value = v
									else
										Dropdowntitle.Text = Title .. ': ' .. v or ""
										Sel.Value = v
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .5
									}
											):Play()
									if Callback then
										Callback(v)
									end
									if Search then
										Dropdowntitle.Text = ""
									end
									refreshlist()
								end)
								if Sel.Value == v then
									SampleItemBG.BackgroundTransparency = .5;
									SampleItemBG.BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									SampleItem.LayoutOrder = 0
								end
							end
						end
					end
				end
				if Search then
					Dropdowntitle.Changed:Connect(function()
						edit()
						SearchDropdown()
					end)
				end
				if typeof(Default) ~= 'table' then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				elseif Slider then
					Dropdowntitle.Text = ''
					Dropdowntitle.PlaceholderText = Title .. ': '
				elseif Selected then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
				DropdownButton.MouseButton1Click:Connect(function()
					refreshlist()
					isbusy = not isbusy
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
				end)
				local dropdownFunction = {
					rf = refreshlist
				}
				function dropdownFunction:ClearText(v)
					if not Selected then
						if Search then
							Dropdowntitle.PlaceholderText = Title .. ': ' .. (v or "")
						else
							Dropdowntitle.Text = Title .. ': ' .. (v or "")
						end
					else
						Dropdowntitle.Text = Title .. ': ' .. (v or "")
					end
				end
				function dropdownFunction:GetNewList(List)
					Sel.Value = ""
					isbusy = false
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
					ListNew = {}
					ListNew = List
					refreshlist()
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
                function dropdownFunction:SetValue(value)
                    if not Selected then
                        if table.find(ListNew, value) then
                            Sel.Value = value
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': ' .. value
                            else
                                Dropdowntitle.Text = Title .. ': ' .. value
                            end
                            if Callback then
                                Callback(value)
                            end
                            refreshlist()
                        end
                    else
                        if ListNew[value] ~= nil then
                            ListNew[value] = true
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': '
                            else
                                Dropdowntitle.Text = Title .. ': '
                            end
                            if Callback then
                                Callback(value, true)
                            end
                            refreshlist()
                        end
                    end
                end
                
                function dropdownFunction:GetValue()
                    if not Selected then
                        return Sel.Value
                    else
                        local result = {}
                        for key, val in pairs(ListNew) do
                            if val == true then
                                table.insert(result, key)
                            end
                        end
                        return result
                    end
                end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName,
                    SetValue = dropdownFunction.SetValue,
                    GetValue = dropdownFunction.GetValue
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownFunction
			end

function sectionFunction:AddKeyBind(Setting, Callback)
    local TitleText = tostring(Setting.Title or Setting.Text) or ""
    local Default = Setting.Default or Setting.Key or "F"
    local Mode = Setting.Mode or "Toggle"
    local Callback = Setting.Callback or Callback or function() end
    
    local function GetKeyString(key)
        local keyStr = tostring(key)
        keyStr = keyStr:gsub("Enum.UserInputType.", "")
        keyStr = keyStr:gsub("Enum.KeyCode.", "")
        return keyStr
    end
    
    local CurrentKey = GetKeyString(Default)
    local CurrentMode = Mode
    local Picking = false
    local ToggleState = false
    local HoldActive = false
    
    local BindFrame = Instance.new("Frame")
    local BindCorner = Instance.new("UICorner")
    local BindBG = Instance.new("Frame")
    local ButtonCorner = Instance.new("UICorner")
    local BindButtonTitle = Instance.new("TextLabel")
    local BindCor = Instance.new("Frame")
    local ButtonCorner_2 = Instance.new("UICorner")
    local Bindkey = Instance.new("TextButton")
    
    BindFrame.Name = TitleText .. "bguvl"
    BindFrame.Parent = Section
    BindFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    BindFrame.BackgroundTransparency = 1.000
    BindFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
    BindFrame.Size = UDim2.new(1, 0, 0, 35)
    
    BindCorner.CornerRadius = UDim.new(0, 4)
    BindCorner.Name = "BindCorner"
    BindCorner.Parent = BindFrame
    
    BindBG.Name = "Background1"
    BindBG.Parent = BindFrame
    BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
    BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
    BindBG.Size = UDim2.new(1, -10, 1, 0)
    BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
    
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Name = "ButtonCorner"
    ButtonCorner.Parent = BindBG
    
    BindButtonTitle.Name = "TextColor"
    BindButtonTitle.Parent = BindBG
    BindButtonTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    BindButtonTitle.BackgroundTransparency = 1.000
    BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
    BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
    BindButtonTitle.Font = Enum.Font.GothamBlack
    BindButtonTitle.Text = TitleText
    BindButtonTitle.TextSize = 14.000
    BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    BindButtonTitle.TextColor3 = getgenv().UIColor["Text Color"]
    
    BindCor.Name = "Background2"
    BindCor.Parent = BindBG
    BindCor.AnchorPoint = Vector2.new(1, 0.5)
    BindCor.Position = UDim2.new(1, -5, 0.5, 0)
    BindCor.Size = UDim2.new(0, 150, 0, 25)
    BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    
    ButtonCorner_2.CornerRadius = UDim.new(0, 4)
    ButtonCorner_2.Name = "ButtonCorner"
    ButtonCorner_2.Parent = BindCor
    
    Bindkey.Name = "Bindkey"
    Bindkey.Parent = BindCor
    Bindkey.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    Bindkey.BackgroundTransparency = 1.000
    Bindkey.Size = UDim2.new(1, 0, 1, 0)
    Bindkey.Font = Enum.Font.GothamBold
    Bindkey.Text = CurrentKey
    Bindkey.TextSize = 14.000
    Bindkey.TextColor3 = getgenv().UIColor["Text Color"]
    
    Bindkey.MouseButton1Click:Connect(function()
        if Picking then return end
        
        Picking = true
        Bindkey.Text = "..."
        
        task.wait(0.2)
        
        local Connection
        Connection = uis.InputBegan:Connect(function(input)
            if Picking then
                local Key
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    Key = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Key = "MouseLeft"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Key = "MouseRight"
                end
                
                if Key then
                    Picking = false
                    CurrentKey = Key
                    Bindkey.Text = Key
                    Connection:Disconnect()
                end
            end
        end)
    end)
    
    uis.InputBegan:Connect(function(input, gpe)
        if gpe or Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local pressedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            pressedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            pressedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            pressedKey = "MouseRight"
        end
        
        if pressedKey == CurrentKey then
            if CurrentMode == "Toggle" then
                ToggleState = not ToggleState
                pcall(Callback, ToggleState)
            elseif CurrentMode == "Hold" then
                HoldActive = true
                pcall(Callback, true)
            end
        end
    end)
    
    uis.InputEnded:Connect(function(input)
        if Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local releasedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            releasedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            releasedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            releasedKey = "MouseRight"
        end
        
        if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
            HoldActive = false
            pcall(Callback, false)
        end
    end)
    
    local controlData = {
        Name = TitleText,
        Section = Section,
        Element = BindFrame,
        SectionName = Section_Name,
        TabName = Page_Name,
        TabButton = PageName
    }
    table.insert(getgenv().AllControls, controlData)
    
    local keybindFunction = {}
    
    function keybindFunction:Set(newKey)
        CurrentKey = GetKeyString(newKey)
        Bindkey.Text = CurrentKey
    end
    
    function keybindFunction:Get()
        return CurrentKey
    end
    
    function keybindFunction:SetMode(mode)
        if mode == "Hold" or mode == "Toggle" then
            CurrentMode = mode
            ToggleState = false
            HoldActive = false
        end
    end
    
    function keybindFunction:GetMode()
        return CurrentMode
    end
    
    function keybindFunction:GetState()
        if CurrentMode == "Toggle" then
            return ToggleState
        elseif CurrentMode == "Hold" then
            return HoldActive
        end
        return false
    end
    
    return keybindFunction
end
			function sectionFunction:AddInput(idk, Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local Placeholder = tostring(Setting.Placeholder) or ""
				local Default = Setting.Default or false
				local Number_Only = Setting.Numeric or false
				local Callback = Setting.Callback
				local BoxFrame = Instance.new("Frame")
				local BoxCorner = Instance.new("UICorner")
				local BoxBG = Instance.new("Frame")
				local ButtonCorner = Instance.new("UICorner")
				local Boxtitle = Instance.new("TextLabel")
				local BoxCor = Instance.new("Frame")
				local ButtonCorner_2 = Instance.new("UICorner")
				local Boxxx = Instance.new("TextBox")
				local Lineeeee = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				BoxFrame.Name = "BoxFrame"
				BoxFrame.Parent = Section
				BoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				BoxFrame.BackgroundTransparency = 1.000
				BoxFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				BoxFrame.Size = UDim2.new(1, 0, 0, 60)
				BoxCorner.CornerRadius = UDim.new(0, 4)
				BoxCorner.Name = "BoxCorner"
				BoxCorner.Parent = BoxFrame
				BoxBG.Name = "Background1"
				BoxBG.Parent = BoxFrame
				BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
				BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				BoxBG.Size = UDim2.new(1, -10, 1, 0)
				BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ButtonCorner.CornerRadius = UDim.new(0, 4)
				ButtonCorner.Name = "ButtonCorner"
				ButtonCorner.Parent = BoxBG
				Boxtitle.Name = "TextColor"
				Boxtitle.Parent = BoxBG
				Boxtitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxtitle.BackgroundTransparency = 1.000
				Boxtitle.Position = UDim2.new(0, 10, 0, 0)
				Boxtitle.Size = UDim2.new(1, -10, 0.5, 0)
				Boxtitle.Font = Enum.Font.GothamBlack
				Boxtitle.Text = TitleText
				Boxtitle.TextSize = 14.000
				Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
				Boxtitle.TextColor3 = getgenv().UIColor["Text Color"]
				BoxCor.Name = "Background2"
				BoxCor.Parent = BoxBG
				BoxCor.AnchorPoint = Vector2.new(1, 0.5)
				BoxCor.ClipsDescendants = true
				BoxCor.Position = UDim2.new(1, -5, 0, 40)
				BoxCor.Size = UDim2.new(1, -10, 0, 25)
				BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				ButtonCorner_2.CornerRadius = UDim.new(0, 4)
				ButtonCorner_2.Name = "ButtonCorner"
				ButtonCorner_2.Parent = BoxCor
				Boxxx.Name = "TextColorPlaceholder"
				Boxxx.Parent = BoxCor
				Boxxx.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Boxxx.BackgroundTransparency = 1.000
				Boxxx.Position = UDim2.new(0, 5, 0, 0)
				Boxxx.Size = UDim2.new(1, -5, 1, 0)
				Boxxx.Font = Enum.Font.GothamBold
				Boxxx.PlaceholderText = Placeholder
				Boxxx.Text = ""
				Boxxx.TextSize = 14.000
				Boxxx.TextXAlignment = Enum.TextXAlignment.Left
				Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				Boxxx.TextColor3 = getgenv().UIColor["Text Color"]
				Lineeeee.Name = "TextNSBoxLineeeee"
				Lineeeee.Parent = BoxCor
				Lineeeee.BackgroundTransparency = 1.000
				Lineeeee.Position = UDim2.new(0, 0, 1, -2)
				Lineeeee.Size = UDim2.new(1, 0, 0, 6)
				Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Lineeeee
				Boxxx.Focused:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 0
					}):Play()
				end)
				if Number_Only then
					Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
						if tonumber(Boxxx.Text) then
						else
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ''
						end
					end)
				end
				Boxxx.FocusLost:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 1
					}):Play()
					if Boxxx.Text ~= '' then
						Callback(Boxxx.Text)
					end
				end)
				local textbox_function = {}
				if Default then
					Boxxx.Text = Default
				end
				function textbox_function.SetValue(Value)
					Boxxx.Text = Value
					Callback(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = BoxFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return textbox_function;
			end
			function sectionFunction:AddSlider(Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local minValue = tonumber(Setting.Min) or 0
				local maxValue = tonumber(Setting.Max) or 100
				local Precise = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback = Setting.Callback
				local SizeChia = 400;
				local SliderFrame = Instance.new("Frame")
				local SliderCorner = Instance.new("UICorner")
				local SliderBG = Instance.new("Frame")
				local SliderBGCorner = Instance.new("UICorner")
				local SliderTitle = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local SliderBarCorner = Instance.new("UICorner")
				local Bar = Instance.new("Frame")
				local BarCorner = Instance.new("UICorner")
				local Sliderboxframe = Instance.new("Frame")
				local Sliderbox = Instance.new("UICorner")
				local Sliderbox_2 = Instance.new("TextBox")
				SliderFrame.Name = TitleText .. 'buda'
				SliderFrame.Parent = Section
				SliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				SliderFrame.BackgroundTransparency = 1.000
				SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				SliderFrame.Size = UDim2.new(1, 0, 0, 50)
				SliderCorner.CornerRadius = UDim.new(0, 4)
				SliderCorner.Name = "SliderCorner"
				SliderCorner.Parent = SliderFrame
				SliderBG.Name = "Background1"
				SliderBG.Parent = SliderFrame
				SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size = UDim2.new(1, -10, 1, 0)
				SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				SliderBGCorner.CornerRadius = UDim.new(0, 4)
				SliderBGCorner.Name = "SliderBGCorner"
				SliderBGCorner.Parent = SliderBG
				SliderTitle.Name = "TextColor"
				SliderTitle.Parent = SliderBG
				SliderTitle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderTitle.BackgroundTransparency = 1.000
				SliderTitle.Position = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size = UDim2.new(1, -10, 0, 25)
				SliderTitle.Font = Enum.Font.GothamBlack
				SliderTitle.Text = TitleText
				SliderTitle.TextSize = 14.000
				SliderTitle.RichText = true
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextColor3 = getgenv().UIColor["Text Color"]
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderFrame
				SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
				SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
				SliderBar.Size = UDim2.new(0, 400, 0, 6)
				SliderBar.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				SliderButton.Name = "SliderButton "
				SliderButton.Parent = SliderBar
				SliderButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.BackgroundTransparency = 1.000
				SliderButton.Size = UDim2.new(1, 0, 1, 0)
				SliderButton.Font = Enum.Font.GothamBold
				SliderButton.Text = ""
				SliderButton.TextColor3 = Color3.fromRGB(230, 230, 230)
				SliderButton.TextSize = 14.000
				SliderBarCorner.CornerRadius = UDim.new(1, 0)
				SliderBarCorner.Name = "SliderBarCorner"
				SliderBarCorner.Parent = SliderBar
				Bar.Name = "Bar"
				Bar.BorderSizePixel = 0
				Bar.Parent = SliderBar
				Bar.Size = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
				BarCorner.CornerRadius = UDim.new(1, 0)
				BarCorner.Name = "BarCorner"
				BarCorner.Parent = Bar
				Sliderboxframe.Name = "Background2"
				Sliderboxframe.Parent = SliderFrame
				Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
				Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
				Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
				Sliderboxframe.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				Sliderbox.CornerRadius = UDim.new(0, 4)
				Sliderbox.Name = "Sliderbox"
				Sliderbox.Parent = Sliderboxframe
				Sliderbox_2.Name = "TextColor"
				Sliderbox_2.Parent = Sliderboxframe
				Sliderbox_2.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
				Sliderbox_2.BackgroundTransparency = 1.000
				Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font = Enum.Font.GothamBold
				Sliderbox_2.Text = ""
				Sliderbox_2.TextSize = 14.000
				Sliderbox_2.TextColor3 = getgenv().UIColor["Text Color"]
				SliderButton.MouseEnter:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"]
					}):Play()
				end)
				SliderButton.MouseLeave:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
					}):Play()
				end)
				local callBackAndSetText = function(val)
					Sliderbox_2.Text = val
					Callback(tonumber(val))
				end
				if DefaultValue then
					if DefaultValue <= minValue then
						DefaultValue = minValue
					elseif DefaultValue >= maxValue then
						DefaultValue = maxValue
					end
					Sliderbox_2.Text = tostring(DefaultValue)
					Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
				end
				local dragging = false
				local dragInput
				local holdTime = 0
				local holdStarted = 0

				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick()
						
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
								holdStarted = 0
							end
						end)
					end
				end
						
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
						holdStarted = 0
					end
				end

				local function onInputChanged(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end
						
				SliderButton.InputBegan:Connect(onInputBegan)
				SliderButton.InputEnded:Connect(onInputEnded)
				SliderButton.InputChanged:Connect(onInputChanged)
						
				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local value = Setting.Rouding and  tonumber(string.format("%.".. Setting.Rouding or 1 .."f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
						pcall(function()
							callBackAndSetText(value)
						end)
						Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
					end
				end)
				local function GetSliderValue(Value)
					if tonumber(Value) <= minValue then
						Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
						callBackAndSetText(minValue)
					elseif tonumber(Value) >= maxValue then
						Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
						callBackAndSetText(maxValue)
					else
						Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
						callBackAndSetText(Value)
					end
				end
				Sliderbox_2.FocusLost:Connect(function()
					GetSliderValue(Sliderbox_2.Text)
				end)
				local slider_function = {}
				function slider_function.SetValue(Value)
					GetSliderValue(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = SliderFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return slider_function
			end
			return sectionFunction
		end

        local _curSec = nil
        local function ensureSec()
            if not _curSec then
                _curSec = pageFunction:AddSection("")
            end
            return _curSec
        end

        local pagefunc = {}

        function pagefunc:AddSection(name)
            if type(name) == "table" then name = name[1] or "" end
            name = tostring(name or "")
            _curSec = pageFunction:AddSection(name)
            return _curSec
        end

        function pagefunc:AddToggle(setting)
            local sec = ensureSec()
            local id = tostring(setting.Name or setting.Title or "toggle")
            return sec:AddToggle(id, {
                Text     = setting.Name or setting.Title or "",
                Desc     = setting.Description or setting.Desc,
                Default  = setting.Default or setting.Value or false,
                Callback = setting.Callback,
            })
        end

        function pagefunc:AddButton(setting, cb)
            local sec = ensureSec()
            return sec:AddButton({
                Title    = setting.Name or setting.Title or "",
                Desc     = setting.Description or setting.Desc,
                Callback = setting.Callback or cb or function() end,
            })
        end

        function pagefunc:AddSlider(setting)
            local sec = ensureSec()
            local vt = setting.Value
            local minv = (type(vt) == "table" and vt.Min) or setting.Min or 0
            local maxv = (type(vt) == "table" and vt.Max) or setting.Max or 100
            local defv = (type(vt) == "table" and vt.Default) or setting.Default or minv
            return sec:AddSlider({
                Text     = setting.Name or setting.Title or "",
                Default  = defv,
                Min      = minv,
                Max      = maxv,
                Callback = setting.Callback,
            })
        end

        function pagefunc:AddInput(setting, cb)
            local sec = ensureSec()
            pcall(function()
                sec:AddInput(tostring(setting.Name or setting.Title or "input"), {
                    Name     = setting.Name or setting.Title or "",
                    Callback = setting.Callback or cb or function() end,
                })
            end)
        end

        function pagefunc:AddDropdown(setting)
            local sec = ensureSec()
            local id = tostring(setting.Name or setting.Title or "dropdown")
            local dd = sec:AddDropdown(id, {
                Text     = setting.Name or setting.Title or "",
                Values   = setting.Options or setting.Values or setting.List or {},
                Default  = setting.Default,
                Callback = setting.Callback,
            })
            if dd then
                function dd:Refresh(newList, _)
                    pcall(function()
                        if newList and #newList > 0 then
                            self:SetValue(newList[1])
                        end
                    end)
                end
            end
            return dd
        end

        function pagefunc:AddParagraph(setting)
            local prevSec = _curSec
            local sec = pageFunction:AddSection(setting.Title or "")
            local lbl = nil
            pcall(function() lbl = sec:AddLabel(setting.Desc or "") end)
            _curSec = prevSec
            local obj = {}
            function obj:SetDesc(text)
                pcall(function()
                    if lbl and lbl.SetText then lbl:SetText(tostring(text)) end
                end)
            end
            return obj
        end

        function pagefunc:AddTextBox(setting, cb)
            local sec = ensureSec()
            pcall(function()
                sec:AddInput(tostring(setting.Name or setting.Title or "input"), {
                    Name     = setting.Name or setting.Title or "",
                    Callback = setting.Callback or cb or function() end,
                })
            end)
        end

        function pagefunc:AddDiscordInvite(setting)
            local prevSec = _curSec
            local sec = pageFunction:AddSection(setting.Name or "Discord")
            pcall(function()
                sec:AddButton({
                    Title    = "Join Discord",
                    Callback = function()
                        pcall(function() setclipboard(setting.Invite or "") end)
                    end,
                })
            end)
            _curSec = prevSec
        end

        return pagefunc
        end

	return Main_Function
end

pcall(function()
	local Lighting = game:GetService("Lighting")
	local atmo = Lighting:FindFirstChildOfClass("Atmosphere")
	if atmo then atmo.Density = 0; atmo.Glare = 0; atmo.Haze = 0 end
	for _, eff in pairs(Lighting:GetChildren()) do
		if eff:IsA("BloomEffect") or eff:IsA("SunRaysEffect") or eff:IsA("DepthOfFieldEffect") then
			eff.Enabled = false
		end
	end
	pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
	for _, v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
	end
end)

local HttpService = game:GetService("HttpService")
local FolderName = "TR6.1"
local ABFileName = "AbacaxiSettings.json"
local ABFullPath = FolderName .. "/" .. ABFileName

if makefolder and not isfolder(FolderName) then makefolder(FolderName) end

_G.SaveData = _G.SaveData or {}

function SaveSettings()
	if not writefile then return false end
	local ok = pcall(function()
		local json = HttpService:JSONEncode(_G.SaveData)
		writefile(ABFullPath, json)
	end)
	return ok
end

function LoadSettings()
	if not (isfile and isfile(ABFullPath)) then return false end
	local ok, result = pcall(function()
		return HttpService:JSONDecode(readfile(ABFullPath))
	end)
	if ok and result then _G.SaveData = result; return true end
	return false
end

function GetSetting(name, default)
	return _G.SaveData[name] ~= nil and _G.SaveData[name] or default
end

LoadSettings()

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local plr = Players.LocalPlayer
local ply = Players
local replicated = ReplicatedStorage
local Lv = plr.Data.Level.Value
local TW = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Enemies = workspace.Enemies
local vim1 = game:GetService("VirtualInputManager")
local vim2 = game:GetService("VirtualUser")

local Boss = {}
local BringConnections = {}
local MaterialList = {}
local NPCList = {}

local shouldTween = false
local SoulGuitar = false
local KenTest = true
local debug_mode = false
local Sec = 0.1
local ClickState = 0
local Num_self = 25

local PosMon = nil
local MonFarm = nil
local _B = false
local MousePos = nil
local HealthM = 0
local SelectIsland = "Cake"
local SelectMaterial = nil

repeat
	local loading = plr.PlayerGui:FindFirstChild("Main")
	loading = loading and loading:FindFirstChild("Loading")
	task.wait()
until game:IsLoaded() and not (loading and loading.Visible)

local placeId = game.PlaceId
local World1, World2, World3 = false, false, false
if placeId == 2753915549 or placeId == 85211729168715 then
	World1 = true
elseif placeId == 4442272183 or placeId == 79091703265657 then
	World2 = true
elseif placeId == 7449423635 or placeId == 100117331123089 then
	World3 = true
end

local Sea = World1 or World2 or World3

Marines = function()
	replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end

Pirates = function()
	replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end

if World1 then
	Boss = {"The Gorilla King","Bobby","The Saw","Yeti","Mob Leader","Vice Admiral","Saber Expert","Warden","Chief Warden","Swan","Magma Admiral","Fishman Lord","Wysper","Thunder God","Cyborg","Ice Admiral","Greybeard"}
	MaterialList = {"Leather + Scrap Metal","Angel Wings","Magma Ore","Fish Tail"}
elseif World2 then
	Boss = {"Diamond","Jeremy","Fajita","Don Swan","Smoke Admiral","Awakened Ice Admiral","Tide Keeper","Darkbeard","Cursed Captain","Order"}
	MaterialList = {"Leather + Scrap Metal","Radioactive Material","Ectoplasm","Mystic Droplet","Magma Ore","Vampire Fang"}
elseif World3 then
	Boss = {"Stone","Hydra Leader","Kilo Admiral","Captain Elephant","Beautiful Pirate","Cake Queen","Longma","Soul Reaper"}
	MaterialList = {"Scrap Metal","Demonic Wisp","Conjured Cocoa","Dragon Scale","Gunpowder","Fish Tail","Mini Tusk"}
end

local X = {"Cookie Crafter","Head Baker","Baking Staff","Cake Guard"}
local P = {"Reborn Skeleton","Posessed Mummy","Demonic Soul","Living Zombie"}

pcall(function()
	local O = workspace:FindFirstChild("Rocks")
	if O then O:Destroy() end
end)

pcall(function()
	local I = game:GetService("Lighting")
	I.Ambient = Color3.new(0.695, 0.695, 0.695)
	I.ColorShift_Bottom = Color3.new(0.695, 0.695, 0.695)
	I.ColorShift_Top = Color3.new(0.695, 0.695, 0.695)
	I.Brightness = 2
	I.FogEnd = 1e10
	local K = workspace._WorldOrigin["Foam;"]
	if K then K:Destroy() end
end)

pcall(function()
	hookfunction(require((game:GetService("ReplicatedStorage")).Effect.Container.Death), function() end)
	hookfunction((require((game:GetService("ReplicatedStorage")):WaitForChild("GuideModule"))).ChangeDisplayedNPC, function() end)
	hookfunction(error, function() end)
	hookfunction(warn, function() end)
end)

EquipWeapon = function(I)
	if not I then return end
	if plr.Backpack:FindFirstChild(I) then
		plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(I))
	end
end

weaponSc = function(I)
	for _, K in pairs(plr.Backpack:GetChildren()) do
		if K:IsA("Tool") and K.ToolTip == I then
			EquipWeapon(K.Name)
		end
	end
end

function AutoHaki()
	if not plr.Character:FindFirstChild("HasBuso") then
		pcall(function() replicated.Remotes.CommF_:InvokeServer("Buso") end)
	end
end

Useskills = function(I, e)
	if I == "Melee" then
		weaponSc("Melee")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game)
		elseif e == "C" then vim1:SendKeyEvent(true, "C", false, game); vim1:SendKeyEvent(false, "C", false, game) end
	elseif I == "Sword" then
		weaponSc("Sword")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game) end
	elseif I == "Blox Fruit" then
		weaponSc("Blox Fruit")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game)
		elseif e == "C" then vim1:SendKeyEvent(true, "C", false, game); vim1:SendKeyEvent(false, "C", false, game)
		elseif e == "V" then vim1:SendKeyEvent(true, "V", false, game); vim1:SendKeyEvent(false, "V", false, game) end
	elseif I == "Gun" then
		weaponSc("Gun")
		if e == "Z" then vim1:SendKeyEvent(true, "Z", false, game); vim1:SendKeyEvent(false, "Z", false, game)
		elseif e == "X" then vim1:SendKeyEvent(true, "X", false, game); vim1:SendKeyEvent(false, "X", false, game) end
	end
end

statsSetings = function(I, e)
	if I == "Melee" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", e) end
	elseif I == "Defense" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", e) end
	elseif I == "Sword" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", e) end
	elseif I == "Gun" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", e) end
	elseif I == "Devil" then
		if plr.Data.Points.Value ~= 0 then replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", e) end
	end
end

pcall(function()
	local J = getrawmetatable(game)
	local i = J.__namecall
	setreadonly(J, false)
	J.__namecall = newcclosure(function(...)
		local I = getnamecallmethod()
		local e = {...}
		if tostring(I) == "FireServer" then
			if tostring(e[1]) == "RemoteEvent" then
				if tostring(e[2]) ~= "true" and tostring(e[2]) ~= "false" then
					if _G.FarmMastery_G and not SoulGuitar or _G.FarmMastery_Dev or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat then
						e[2] = MousePos
						return i(unpack(e))
					end
				end
			end
		end
		return i(...)
	end)
end)

GetConnectionEnemies = function(I)
	local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	local bestMob, bestDist = nil, math.huge
	local function checkMob(K)
		if not K:IsA("Model") then return end
		local match = (typeof(I) == "table") and table.find(I, K.Name) or (K.Name == I)
		if not match then return end
		local hum = K:FindFirstChild("Humanoid")
		local root = K:FindFirstChild("HumanoidRootPart")
		if not hum or not root or hum.Health <= 0 then return end
		local d = hrp and (root.Position - hrp.Position).Magnitude or 0
		if d < bestDist then bestDist = d; bestMob = K end
	end
	for _, K in pairs(workspace.Enemies:GetChildren()) do checkMob(K) end
	for _, K in pairs(replicated:GetChildren()) do checkMob(K) end
	return bestMob
end

GetBP = function(I)
	return plr.Backpack:FindFirstChild(I) or plr.Character:FindFirstChild(I)
end

GetIn = function(I)
	for _, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(K) == "table" then
			if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
				return true
			end
		end
	end
	return false
end

GetM = function(I)
	for _, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(K) == "table" and K.Type == "Material" and K.Name == I then
			return K.Count
		end
	end
	return 0
end

GetWP = function(I)
	for _, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(K) == "table" and K.Type == "Sword" then
			if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
				return true
			end
		end
	end
	return false
end

UpdStFruit = function()
	for _, e in next, plr.Backpack:GetChildren() do
		StoreFruit = e:FindFirstChild("EatRemote", true)
		if StoreFruit then
			replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(e.Name))
		end
	end
end

collectFruits = function(I)
	if I then
		local ch = plr.Character
		for _, K in pairs(workspace:GetChildren()) do
			if string.find(K.Name, "Fruit") then
				K.Handle.CFrame = ch.HumanoidRootPart.CFrame
			end
		end
	end
end

DropFruits = function()
	for _, e in next, plr.Backpack:GetChildren() do
		if string.find(e.Name, "Fruit") then
			EquipWeapon(e.Name); task.wait(.1)
			if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end
			EquipWeapon(e.Name)
			pcall(function() (plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop") end)
		end
	end
	for _, e in pairs(plr.Character:GetChildren()) do
		if string.find(e.Name, "Fruit") then
			EquipWeapon(e.Name); task.wait(.1)
			if plr.PlayerGui.Main.Dialogue.Visible == true then plr.PlayerGui.Main.Dialogue.Visible = false end
			EquipWeapon(e.Name)
			pcall(function() (plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop") end)
		end
	end
end

LowCpu = function()
	local e = game
	local K = e.Workspace
	local n = e.Lighting
	local d = K.Terrain
	d.WaterWaveSize = 0; d.WaterWaveSpeed = 0; d.WaterReflectance = 0; d.WaterTransparency = 0
	n.GlobalShadows = false; n.FogEnd = 9000000000.0; n.Brightness = 1
	pcall(function() settings().Rendering.QualityLevel = "Level01" end)
	for _, K in pairs(e:GetDescendants()) do
		pcall(function()
			if K:IsA("Part") or K:IsA("Union") or K:IsA("CornerWedgePart") or K:IsA("TrussPart") then
				K.Material = "Plastic"; K.Reflectance = 0
			elseif K:IsA("Decal") or K:IsA("Texture") then
				K.Transparency = 1
			elseif K:IsA("ParticleEmitter") or K:IsA("Trail") then
				K.Lifetime = NumberRange.new(0)
			elseif K:IsA("Fire") or K:IsA("SpotLight") or K:IsA("Smoke") or K:IsA("Sparkles") then
				K.Enabled = false
			end
		end)
	end
end

getInfinity_Ability = function(I, e)
	if not plr.Character:FindFirstChild("HumanoidRootPart") then return end
	if I == "Soru" and e then
		for _, K in next, getgc() do
			if plr.Character.Soru then
				if typeof(K) == "function" and (getfenv(K)).script == plr.Character.Soru then
					for _, K2 in next, getupvalues(K) do
						if typeof(K2) == "table" then
							repeat task.wait(Sec); K2.LastUse = 0 until not e or plr.Character.Humanoid.Health <= 0
						end
					end
				end
			end
		end
	elseif I == "Energy" and e then
		plr.Character.Energy.Changed:connect(function()
			if e then plr.Character.Energy.Value = plr.Character.Energy.Value end
		end)
	elseif I == "Observation" and e then
		local I2 = plr.VisionRadius
		I2.Value = math.huge
	end
end

Hop = function()
	pcall(function()
		for I = math.random(1, math.random(40, 75)), 100, 1 do
			local e = replicated.__ServerBrowser:InvokeServer(I)
			for _, sv in next, e do
				if tonumber(sv.Count) < 12 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, _)
				end
			end
		end
	end)
end

shouldRequestEntrance = function(pos, dist)
	pcall(function()
		if (pos - plr.Character.HumanoidRootPart.Position).Magnitude >= (dist or 1000) then
			replicated.Remotes.CommF_:InvokeServer("requestEntrance", pos)
		end
	end)
end

local C = Instance.new("Part", workspace)
C.Size = Vector3.new(1,1,1); C.Name = "TRonVoidFarmPart"; C.Anchored = true
C.CanCollide = false; C.CanTouch = false; C.Transparency = 1
local existC = workspace:FindFirstChild(C.Name)
if existC and existC ~= C then existC:Destroy() end

getgenv().TweenSpeedFar = 350
getgenv().TweenSpeedNear = 700

task.spawn(function()
	local I = plr
	repeat task.wait() until I.Character and I.Character.PrimaryPart
	C.CFrame = I.Character.PrimaryPart.CFrame
	while task.wait() do
		pcall(function()
			if shouldTween then
				if C and C.Parent == workspace then
					local e = I.Character and I.Character.PrimaryPart
					if e and (e.Position - C.Position).Magnitude <= 200 then
						e.CFrame = C.CFrame
					else
						C.CFrame = e.CFrame
					end
				end
				local e = I.Character
				if e then
					for _, v in pairs(e:GetChildren()) do
						if v:IsA("BasePart") then v.CanCollide = false end
					end
				end
			else
				local e = I.Character
				if e then
					for _, v in pairs(e:GetChildren()) do
						if v:IsA("BasePart") then v.CanCollide = true end
					end
				end
			end
		end)
	end
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if shouldTween then
				getgenv().OnFarm = true
			else
				getgenv().OnFarm = false
			end
		end)
	end
end)

local _currentTweenTarget = nil
local _currentTween       = nil
local _tpHB               = nil

local function _ensureTPHB()
	if _tpHB then return end
	_tpHB = game:GetService("RunService").Heartbeat:Connect(function()
		if not shouldTween then return end
		pcall(function()
			local ch = plr.Character; if not ch then return end
			local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return end
			if C and C.Parent then
				local gap = (hrp.Position - C.Position).Magnitude
				if gap <= 200 then hrp.CFrame = C.CFrame else C.CFrame = hrp.CFrame end
			end
			for _, v in pairs(ch:GetChildren()) do
				if v:IsA("BasePart") then v.CanCollide = false end
			end
		end)
	end)
end

_tp = function(I)
	local e = plr.Character
	if not e or not e:FindFirstChild("HumanoidRootPart") then return end
	local HRP = e.HumanoidRootPart
	shouldTween = true; getgenv().OnFarm = false
	if HRP.Anchored then HRP.Anchored = false; task.wait() end
	local dist = (I.Position - HRP.Position).Magnitude
	local speed = dist <= 15 and (getgenv().TweenSpeedNear or 700) or (getgenv().TweenSpeedFar or 350)
	local info = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
	local tween = game:GetService("TweenService"):Create(C, info, {CFrame = I})
	if e.Humanoid.Sit == true then
		C.CFrame = CFrame.new(C.Position.X, I.Y, C.Position.Z)
	end
	tween:Play()
	task.spawn(function()
		while tween.PlaybackState == Enum.PlaybackState.Playing do
			if not shouldTween then tween:Cancel(); break end
			task.wait(.1)
		end
		getgenv().OnFarm = true
	end)
end

function TweenPlayer(pos)
	local e = plr.Character
	if not e or not e:FindFirstChild("HumanoidRootPart") then return end
	local HRP = e.HumanoidRootPart
	local dist = (pos.Position - HRP.Position).Magnitude
	if dist < 5 then return end
	_ensureTPHB()
	shouldTween = true; _G.StopTween = false
	HRP.Anchored = false
	_currentTweenTarget = pos
	local tweenSpeed = getgenv().TweenSpeedFar or 350
	local info = TweenInfo.new(math.max(0.05, dist / tweenSpeed), Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	C.CFrame = HRP.CFrame
	local tween = game:GetService("TweenService"):Create(C, info, {CFrame = pos})
	_currentTween = tween
	tween:Play()
	task.spawn(function()
		while tween.PlaybackState == Enum.PlaybackState.Playing do
			if _G.StopTween then tween:Cancel(); break end
			task.wait(0.05)
		end
		_currentTween = nil; _currentTweenTarget = nil
		pcall(function()
			if e and e.Parent and HRP then
				HRP.Anchored = false
				local hum = e:FindFirstChildOfClass("Humanoid")
				if hum then
					if hum.WalkSpeed <= 0 then hum.WalkSpeed = 16 end
					if hum.JumpPower <= 0 then hum.JumpPower = 50 end
				end
			end
		end)
	end)
end

notween = function(I)
	plr.Character.HumanoidRootPart.CFrame = I
end

_G.BypassTeleportActive = false
function StopTween(State)
	if not State then
		if _G.BypassTeleportActive then return end
		_G.StopTween = true; shouldTween = false
		pcall(function() TweenPlayer(plr.Character.HumanoidRootPart.CFrame) end)
		pcall(function()
			if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
				plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
			end
		end)
		_G.StopTween = false
	end
end

local BossList = {"Darkbeard","Greybeard","Saber Expert","Don Swan","Wyspr","Rip_indra","Rip Indra","Island Empress","Cake Queen","Order","Cursed Captain"}
local _BringTweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local TweenService = game:GetService("TweenService")

local function IsRaidMob(mob)
	local n = mob.Name:lower()
	if n:find("raid") or n:find("microchip") or n:find("island") then return true end
	if mob:GetAttribute("IsRaid") or mob:GetAttribute("RaidMob") or mob:GetAttribute("IsBoss") then return true end
	local hum = mob:FindFirstChild("Humanoid")
	if hum and hum.WalkSpeed == 0 then return true end
	return false
end

_G.BringRange = _G.BringRange or 235
_G.MobM = _G.MobM or 10
_G.MaxBringMobs = _G.MaxBringMobs or 3
_G.MobHeight = _G.MobHeight or 20

BringEnemy = function()
	if not _B then return end
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge) end)
	local targetPos = (PosMon and typeof(PosMon)=="Vector3" and PosMon)
		or (PosMon and typeof(PosMon)=="CFrame" and PosMon.Position)
		or hrp.Position
	local count = 0
	for _, mob in ipairs(workspace.Enemies:GetChildren()) do
		if count >= (_G.MobM or 10) then break end
		local hum = mob:FindFirstChild("Humanoid")
		local root = mob:FindFirstChild("HumanoidRootPart")
		if not hum or not root or hum.Health <= 0 then continue end
		if IsRaidMob(mob) then continue end
		local isBoss = false
		for _, b in ipairs(BossList) do if mob.Name == b then isBoss = true; break end end
		if isBoss then continue end
		local dist = (root.Position - targetPos).Magnitude
		if dist > (_G.BringRange or 235) then continue end
		count = count + 1
		pcall(function()
			hum.WalkSpeed = 0
			root.CanCollide = false
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end)
		local destCF = CFrame.new(targetPos.X, root.Position.Y, targetPos.Z)
		local tween = TweenService:Create(root, _BringTweenInfo, {CFrame = destCF})
		tween:Play()
	end
end

local env = game.ReplicatedStorage
local rs = game:GetService("ReplicatedStorage")
local modules = rs:WaitForChild("Modules")
local net = modules:WaitForChild("Net")
local enemyFolder = workspace:WaitForChild("Enemies")
local AttackModule = {}
local RegisterAttack = net:WaitForChild("RE/RegisterAttack")
local RegisterHit = net:WaitForChild("RE/RegisterHit")

function AttackModule:AttackEnemy(EnemyHead, Table)
	if EnemyHead then
		RegisterAttack:FireServer(0)
		RegisterAttack:FireServer(1)
		RegisterAttack:FireServer(2)
		RegisterAttack:FireServer(3)
		RegisterHit:FireServer(EnemyHead, Table or {})
	end
end

function AttackModule:AttackNearest()
	local mon = {nil, {}}
	for _, Enemy in enemyFolder:GetChildren() do
		if not mon[1] and Enemy:FindFirstChild("HumanoidRootPart", true) and plr:DistanceFromCharacter(Enemy.HumanoidRootPart.Position) < 60 then
			mon[1] = Enemy:FindFirstChild("HumanoidRootPart")
		elseif Enemy:FindFirstChild("HumanoidRootPart", true) and plr:DistanceFromCharacter(Enemy.HumanoidRootPart.Position) < 60 then
			table.insert(mon[2], {[1] = Enemy, [2] = Enemy:FindFirstChild("HumanoidRootPart")})
		end
	end
	self:AttackEnemy(unpack(mon))
end

function AttackModule:BladeHits()
	self:AttackNearest()
end

function Attack()
	task.wait(0.1)
	AttackModule:BladeHits()
end

G = {}
G.Alive = function(I)
	if not I then return end
	local e = I:FindFirstChild("Humanoid")
	return e and e.Health > 0
end

G.Kill = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	local char = plr.Character
	if not char then return end
	local myHRP = char:FindFirstChild("HumanoidRootPart")
	if not myHRP then return end
	PosMon = hrp.Position
	MonFarm = I.Name
	_B = true
	BringEnemy()
	EquipWeapon(_G.SelectWeapon or "")
	pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge) end)
	pcall(function() hum.WalkSpeed = 0; hrp.CanCollide = false end)
	local dist = (hrp.Position - myHRP.Position).Magnitude
	if dist > (_G.MobHeight or 20) + 5 then
		local targetCF = hrp.CFrame * CFrame.new(0, _G.MobHeight or 20, 0)
		_tp(targetCF)
	end
	local head = I:FindFirstChild("Head") or hrp
	pcall(function() AttackModule:AttackEnemy(head, {}) end)
end

G.Kill2 = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	PosMon = hrp.Position; MonFarm = I.Name; _B = true
	BringEnemy()
	EquipWeapon(_G.SelectWeapon or "")
	local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
	if tool then
		local offset = tool.ToolTip == "Blox Fruit"
			and CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(90), 0)
			or CFrame.new(0, 20, 8) * CFrame.Angles(0, math.rad(180), 0)
		TweenPlayer(hrp.CFrame * offset)
	end
end

G.Mas = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	PosMon = hrp.Position; MonFarm = I.Name; _B = true
	BringEnemy()
	if hum.Health <= HealthM then
		_tp(hrp.CFrame * CFrame.new(0, 20, 0))
		if _G.FruitSkills then
			weaponSc("Blox Fruit")
			if _G.FruitSkills.Z then Useskills("Blox Fruit","Z") end
			if _G.FruitSkills.X then Useskills("Blox Fruit","X") end
			if _G.FruitSkills.C then Useskills("Blox Fruit","C") end
			if _G.FruitSkills.V then Useskills("Blox Fruit","V") end
			if _G.FruitSkills.F then vim1:SendKeyEvent(true,"F",false,game); vim1:SendKeyEvent(false,"F",false,game) end
		end
	else
		weaponSc("Melee")
		_tp(hrp.CFrame * CFrame.new(0, 30, 0))
	end
end

G.Masgun = function(I, e)
	if not (I and e) then return end
	local hrp = I:FindFirstChild("HumanoidRootPart")
	local hum = I:FindFirstChild("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	PosMon = hrp.Position; MonFarm = I.Name; _B = true
	BringEnemy()
	if hum.Health <= HealthM then
		_tp(hrp.CFrame * CFrame.new(0, 35, 8))
		Useskills("Gun","Z"); Useskills("Gun","X")
	else
		weaponSc("Melee")
		_tp(hrp.CFrame * CFrame.new(0, 30, 0))
	end
end

task.spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			if setscriptable then setscriptable(plr, "SimulationRadius", true) end
			if sethiddenproperty then sethiddenproperty(plr, "SimulationRadius", math.huge) end
		end)
	end)
end)

task.spawn(function()
	while task.wait(2) do
		pcall(function()
			local char = plr.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hrp or not hum then return end
			if hrp.Anchored then hrp.Anchored = false end
			if hum.WalkSpeed <= 0 then hum.WalkSpeed = 16 end
		end)
	end
end)

_G.FruitSkills = {Z=false, X=false, C=false, V=false, F=false}

_G.SelectWeapon = _G.SelectWeapon or nil

local function GetNearestMobFromList(list)
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end
	local nearest, dist2 = nil, math.huge
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if table.find(list, mob.Name)
		and mob:FindFirstChild("HumanoidRootPart")
		and mob:FindFirstChild("Humanoid")
		and mob.Humanoid.Health > 0 then
			local d = (mob.HumanoidRootPart.Position - root.Position).Magnitude
			if d < dist2 then dist2 = d; nearest = mob end
		end
	end
	return nearest
end

local function HasAliveMob(list)
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if table.find(list, mob.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
			return true
		end
	end
	return false
end

local function GetConnectionEnemies_Sea(name)
	return GetConnectionEnemies(name)
end

local Location = {}
for _, e in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
	table.insert(Location, e.Name)
end

local Location_Portal
if World1 then
	Location_Portal = {"Sky","UnderWater"}
elseif World2 then
	Location_Portal = {"SwanRoom","Cursed Ship"}
elseif World3 then
	Location_Portal = {"Castle On The Sea","Mansion Cafe","Hydra Teleport","Canvendish Room","Temple of Time"}
end

for _, e in pairs(replicated.NPCs:GetChildren()) do
	table.insert(NPCList, e.Name)
end

_G.Settings = {
	Main = {["Select Weapon"]="Melee",["Auto Farm"]=false},
	Farm = {["Auto Farm Chest Tween"]=false,["Auto Farm Chest Instant"]=false},
	Multi = {["Auto Fully Volcanic"]=false,["Auto Reset After Complete"]=false,["Auto Collect Egg"]=false,["Auto Collect Bone"]=false},
	Setting = {["Bring Mob"]=true,["Farm Distance"]=35,["Fast Attack"]=true,["Fast Attack New"]=false,["Player Tween Speed"]=350},
	SeaEvent = {["Selected Boat"]="Guardian",["Boat Tween Speed"]=300},
	Esp = {["ESP Player"]=false,["ESP Chest"]=false,["ESP DevilFruit"]=false,["ESP Island"]=false},
	DragonDojo = {["Auto Farm Blaze Ember"]=false},
	SeaStack = {},
	Race = {},
	Raid = {},
	FarmHop = {}
}

;(getgenv()).Load = function()
	if readfile and writefile and isfile and isfolder then
		if not isfolder("TR6.1") then makefolder("TR6.1") end
		if not isfolder("TR6.1/Blox Fruits/") then makefolder("TR6.1/Blox Fruits/") end
		local path = "TR6.1/Blox Fruits/" .. plr.Name .. ".json"
		if not isfile(path) then
			writefile(path, (game:GetService("HttpService")):JSONEncode(_G.Settings))
		else
			local ok, Decode = pcall(function()
				return (game:GetService("HttpService")):JSONDecode(readfile(path))
			end)
			if ok and Decode then
				for i, v in pairs(Decode) do _G.Settings[i] = v end
			end
		end
	end
end

;(getgenv()).SaveSetting = function()
	if readfile and writefile and isfile and isfolder then
		local path = "TR6.1/Blox Fruits/" .. plr.Name .. ".json"
		if not isfile(path) then
			(getgenv()).Load()
		else
			local Array = {}
			for i, v in pairs(_G.Settings) do Array[i] = v end
			writefile(path, (game:GetService("HttpService")):JSONEncode(Array))
		end
	end
end

pcall(function() (getgenv()).Load() end)

Number = math.random(1, 1000000)

local Pos = CFrame.new(0, _G.Settings.Setting["Farm Distance"] or 35, 0)
task.spawn(function()
	local angle = 0
	while task.wait(0.05) do
		Pos = CFrame.new(0, _G.Settings.Setting["Farm Distance"] or 35, 0)
	end
end)

local UIS2 = game:GetService("UserInputService")
local _movementKeys = {
	Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
	Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right,
	Enum.KeyCode.Space
}
UIS2.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	for _, key in ipairs(_movementKeys) do
		if input.KeyCode == key then
			shouldTween = false; _G.StopTween = false
			break
		end
	end
end)
UIS2.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.Touch then
		shouldTween = false; _G.StopTween = false
	end
end)
_G.FastAttackActive = false;
local _faRemote, _faIdRemote;
task.spawn(function()
	for _, v in next, ({game.ReplicatedStorage.Util, game.ReplicatedStorage.Common, game.ReplicatedStorage.Remotes,
		game.ReplicatedStorage.Assets, game.ReplicatedStorage.FX}) do
		pcall(function()
			for _, n in next, v:GetChildren() do
				if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
					_faRemote, _faIdRemote = n, n:GetAttribute("Id");
				end;
			end;
			v.ChildAdded:Connect(function(n)
				if n:IsA("RemoteEvent") and n:GetAttribute("Id") then
					_faRemote, _faIdRemote = n, n:GetAttribute("Id");
				end;
			end);
		end);
	end;
end);
task.spawn(function()
	repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character;
	while task.wait(0.05) do
		pcall(function()
			local farmActive = _G.Settings.Main["Auto Farm"]
				or _G.Settings.Main["Auto Farm Mon"]
				or _G.Settings.Main["Auto Farm Fast"]
				or _G.Settings.Main["Auto Farm All Boss"]
				or _G.Settings.Main["Auto Farm Boss"]
				or _G.Settings.Main["Auto Farm Fruit Mastery"]
				or _G.Settings.Main["Auto Farm Sword Mastery"]
				or _G.Settings.Main["Auto Farm Gun Mastery"]
				or _G.Settings.Farm["Auto Farm Bone"]
				or _G.Settings.Farm["Auto Farm Ectoplasm"]
				or _G.Settings.Farm["Auto Farm Katakuri"]
				or _G.Settings.Farm["Auto Farm Material"]
				or _G.EclipseStartFarm
				or _G.EclipseAutoTyrant;
			local fastAttackOn = _G.Settings.Setting["Fast Attack New"];
			if not (fastAttackOn or farmActive) then return; end;
			local char = game.Players.LocalPlayer.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");
			if not char or not root then return; end;
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hum or hum.Health <= 0 then return; end;
			local parts = {};
			for _, x in ipairs({workspace.Enemies, workspace.Characters}) do
				for _, v in ipairs(x and x:GetChildren() or {}) do
					local hrp = v:FindFirstChild("HumanoidRootPart");
					local vmhum = v:FindFirstChild("Humanoid");
					if v ~= char and hrp and vmhum and vmhum.Health > 0 and (hrp.Position - root.Position).Magnitude <= 60 then
						for _, _v in ipairs(v:GetChildren()) do
							if _v:IsA("BasePart") and (hrp.Position - root.Position).Magnitude <= 60 then
								parts[#parts + 1] = {v, _v};
							end;
						end;
					end;
				end;
			end;
			local tool = char:FindFirstChildOfClass("Tool");
			if #parts > 0 and tool and
				(tool:GetAttribute("WeaponType") == "Melee" or tool:GetAttribute("WeaponType") == "Sword") then
				pcall(function()
					require(game.ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true);
					game.ReplicatedStorage.Modules.Net["RE/RegisterAttack"]:FireServer();
					local head = parts[1][1]:FindFirstChild("Head");
					if not head then return; end;
					game.ReplicatedStorage.Modules.Net["RE/RegisterHit"]:FireServer(head, parts, {}, tostring(
						game.Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15));
					if _faRemote and _faIdRemote then
						cloneref(_faRemote):FireServer(string.gsub("RE/RegisterHit", ".", function(c)
							return string.char(
								bit32.bxor(string.byte(c), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1));
						end), bit32.bxor(_faIdRemote + 909090, game.ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), head, parts);
					end;
				end);
			end;
		end);
	end;
end);


pcall(function()
	local UIS = game:GetService("UserInputService");
	local _movementKeys = {
		Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
		Enum.KeyCode.Up, Enum.KeyCode.Down, Enum.KeyCode.Left, Enum.KeyCode.Right,
		Enum.KeyCode.Space
	};
	UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return; end;
		for _, key in ipairs(_movementKeys) do
			if input.KeyCode == key then
				if not _G.EclipseStartFarm and not _G.SailBoats and not _G.EclipseAutoTyrant then
					shouldTween = false;
					_G.StopTween = false;
				end;
				break;
			end;
		end;
	end);
	UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return; end;
		if input.UserInputType == Enum.UserInputType.Touch then
			if not _G.EclipseStartFarm and not _G.SailBoats and not _G.EclipseAutoTyrant then
				shouldTween = false;
				_G.StopTween = false;
			end;
		end;
	end);
	UIS.InputChanged:Connect(function(input, gpe)
		if gpe then return; end;
		if input.KeyCode == Enum.KeyCode.Thumbstick1 then
			local mag = Vector2.new(input.Position.X, input.Position.Y).Magnitude;
			if mag > 0.15 then
				if not _G.EclipseStartFarm and not _G.SailBoats and not _G.EclipseAutoTyrant then
					shouldTween = false;
					_G.StopTween = false;
				end;
			end;
		end;
	end);
end);

local Window = Library:CreateWindow({
    Title = "TRon Void Hub - Blox Fruit",
    SubTitle = "",
    SaveFolder = "TRonVoidHub.json",
    Image = "rbxassetid://133779423735605"
})

local InfoTab          = Window:AddTab("Tab | Discord")
local ServerTab        = Window:AddTab("Tab | Status and Server")
local SettingsTab      = Window:AddTab("Tab | Settings")
local HoldAndSkillTab  = Window:AddTab("Tab | Hold And Skill")
local MultiFarmTab     = Window:AddTab("Tab | Multi Farm")
local FarmingHopTab    = Window:AddTab("Tab | Farming and Hop")
local ShopTab          = Window:AddTab("Tab | Shop")
local MainTab          = Window:AddTab("Tab | Main Farm")
local FarmTab          = Window:AddTab("Tab | Farm Others")
local MaestryTab       = Window:AddTab("Tab | Mastery")
local OthersTab        = Window:AddTab("Tab | Others")
local EventTab         = Window:AddTab("Tab | Sea Event")
local RaceTab          = Window:AddTab("Tab | Race")
local DojoTab          = Window:AddTab("Tab | Dojo & Dragon")
local EspTab           = Window:AddTab("Tab | Esp & Stats")
local LocalPlayerTab   = Window:AddTab("Tab | Local Player")
local TeleportTab      = Window:AddTab("Tab | Teleport")
local GetTab           = Window:AddTab("Tab | Get Items")
local FruitTab         = Window:AddTab("Tab | Raid & Fruit")

task.delay(2, function()
    pcall(function()
        Library:Notify({
            Title = "TRon Void Hub",
            Content = "Script loaded! Welcome, " .. game.Players.LocalPlayer.Name,
            Icon = "rocket",
            Duration = 6
        })
    end)
end)

InfoTab:AddSection(" TRon Void Hub ");
InfoTab:AddParagraph({
	Title = "TRon Void Hub",
	Desc = "Version: R6.1 | Game: Blox Fruits\nMade for the TRon Void Community\nAll features are free to use."
});
InfoTab:AddParagraph({
	Title = " Discord Server",
	Desc = "Join our community for updates, support and more!\nLink: discord.gg/f4K5sDwKkn"
});
InfoTab:AddButton({
	Title = "Join TRon Void Community Discord",
	Desc = "Click to open the Discord invite link",
	Callback = function()
		setclipboard("https://discord.gg/f4K5sDwKkn");
		Library:Notify({Title = "TRon Void Hub", Content = "Discord link copied to clipboard!\ndiscord.gg/f4K5sDwKkn", Icon = "bell", Duration = 5});
	end
});
InfoTab:AddParagraph({
	Title = " Credits",
	Desc = "Owner: 4GIOT4\n\nTRon Void Hub R6.1 - Blox Fruits"
});
local function FHNotify(title, text, duration)
	pcall(function()
		Library:Notify({
			Title = title,
			Content = text,
			Icon = "bell",
			Duration = duration or 4
		});
	end);
end;

local Hop = function()
	FHNotify("Farm Hop", " Hoping Server...", 5);
	pcall(function()
		local TeleportService = game:GetService("TeleportService");
		local replicated = game:GetService("ReplicatedStorage");
		for i = math.random(1, math.random(40, 75)), 100, 1 do
			local e = replicated.__ServerBrowser:InvokeServer(i);
			for id, sv in next, e do
				if tonumber(sv.Count) < 12 then
					TeleportService:TeleportToPlaceInstance(game.PlaceId, id);
				end;
			end;
		end;
	end);
end;

local function SaveFH()
	pcall(function() (getgenv()).SaveSetting(); end);
end;

FarmingHopTab:AddSection(" Sea 1 Farms");

local _FHAutoSaw = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saw Sword"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Saw Sword [Sea 1]",
	Desc = "Auto kill The Saw boss para Saw Sword",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saw Sword"] or false,
	Callback = function(state)
		_FHAutoSaw = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Saw Sword"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			if _FHAutoSaw then
				local mob = GetConnectionEnemies("The Saw");
				if mob then
					FHNotify("Saw Sword", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHAutoSaw);
					until not _FHAutoSaw or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHAutoSaw then return end;
					FHNotify("Saw Sword", " Boss killed!", 3);
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906);
				end;
			end;
		end);
	end;
end);

local _FHAutoSaber = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saber Sword"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Saber Sword [Sea 1]",
	Desc = "Auto complete Saber Expert quest chain - Sea 1",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Saber Sword"] or false,
	Callback = function(state)
		_FHAutoSaber = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Saber Sword"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			local replicated = game:GetService("ReplicatedStorage");
			if _FHAutoSaber and World1 then
				local mob = GetConnectionEnemies("Saber Expert");
				if mob and G.Alive and G.Alive(mob) then
					FHNotify("Saber Sword", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHAutoSaber);
					until mob.Humanoid.Health <= 0 or not _FHAutoSaber;
					if mob.Humanoid.Health <= 0 then
						replicated.Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic");
						FHNotify("Saber Sword", " Quest step done!", 3);
					end;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1401.85046, 29.9773273, 8.81916237);
				end;
			end;
		end);
	end;
end);

local _FHAutoUsoap = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Usoap Hat"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Usoap's Hat [Sea 1]",
	Desc = "Auto kill players perto para Usoap Hat",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Usoap Hat"] or false,
	Callback = function(state)
		_FHAutoUsoap = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Usoap Hat"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			if _FHAutoUsoap then
				local Root = plr.Character.HumanoidRootPart;
				for _, e in pairs(workspace.Characters:GetChildren()) do
					if e.Name ~= plr.Name and e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") then
						if e.Humanoid.Health > 0 and (Root.Position - e.HumanoidRootPart.Position).Magnitude <= 230 then
							repeat task.wait(0.1);
								EquipWeapon(_G.Settings.Main["Selected Weapon"]);
								plr.Character.HumanoidRootPart.CFrame = e.HumanoidRootPart.CFrame * CFrame.new(1,1,2);
							until not _FHAutoUsoap or e.Humanoid.Health <= 0 or not e.Parent;
						end;
					end;
				end;
			end;
		end);
	end;
end);

local _FHobsFarm = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Observation"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Farm Observation [All Seas]",
	Desc = "Auto farm Observation Haki (Ken) - Sea 1, 2 e 3",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Observation"] or false,
	Callback = function(state)
		_FHobsFarm = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Observation"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _FHobsFarm then
				game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken",true);
				if game.Players.LocalPlayer:GetAttribute("KenDodgesLeft") == 0 then
					KenTest = false;
				elseif game.Players.LocalPlayer:GetAttribute("KenDodgesLeft") > 0 then
					KenTest = true;
				end;
			end;
		end);
	end;
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			if _FHobsFarm then
				local mobName = World1 and "Galley Captain" or World2 and "Lava Pirate" or "Venomous Assailant";
				local defaultPos = World1 and CFrame.new(5533.29785,88.1079102,4852.3916) or World2 and CFrame.new(-5478.39209,15.9775667,-5246.9126) or CFrame.new(4530.3540039063,656.75695800781,-131.60952758789);
				local mob = workspace.Enemies:FindFirstChild(mobName);
				if mob then
					repeat task.wait(0.1);
						plr.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * (KenTest and CFrame.new(3,0,0) or CFrame.new(0,50,0));
					until not _FHobsFarm or not mob.Parent;
				else
					plr.Character.HumanoidRootPart.CFrame = defaultPos;
				end;
			end;
		end);
	end;
end);

local _FHBones = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bones"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Random Bone [All Seas]",
	Desc = "Auto buy Bones aleatoriamente para invocar bosses",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bones"] or false,
	Callback = function(state)
		_FHBones = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Bones"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHBones then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1);
			end;
		end);
	end;
end);

local _FHBisento = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bisento"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Bisento V2 [Sea 1]",
	Desc = "Auto kill Greybeard para Bisento - Sea 1",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Bisento"] or false,
	Callback = function(state)
		_FHBisento = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Bisento"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		if _FHBisento then
			pcall(function()
				local replicated = game:GetService("ReplicatedStorage");
				replicated.Remotes.CommF_:InvokeServer("LoadItem","Bisento");
				local mob = GetConnectionEnemies("Greybeard");
				if mob then
					FHNotify("Bisento V2", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHBisento);
					until not _FHBisento or not mob.Parent or mob.Humanoid.Health <= 0;
					if mob and mob.Humanoid.Health <= 0 then
						FHNotify("Bisento V2", " Greybeard killed!", 3);
					end;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5023.3833007812, 28.652032852173, 4332.3818359375);
				end;
			end);
		end;
	end;
end);


FarmingHopTab:AddSection(" Sea 2 Farms");

local _FHDarkbeard = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Darkbeard"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Darkbeard [Sea 2 + Hop]",
	Desc = "Auto kill Darkbeard - hops server se nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Darkbeard"] or false,
	Callback = function(state)
		_FHDarkbeard = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Darkbeard"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHDarkbeard and World2 then
				local mob = GetConnectionEnemies("Darkbeard");
				if mob then
					FHNotify("Darkbeard", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHDarkbeard);
					until not _FHDarkbeard or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHDarkbeard then return end;
					FHNotify("Darkbeard", " Boss killed!", 3);
				else
					FHNotify("Darkbeard", " Hoping Server...", 4);
					TweenPlayer(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625));
					task.wait(1);
					if not GetConnectionEnemies("Darkbeard") then Hop(); end;
				end;
			end;
		end);
	end;
end);

local _FHWarden = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Warden"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Warden Sword [Sea 2]",
	Desc = "Auto kill Chief Warden para Warden Sword",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Warden"] or false,
	Callback = function(state)
		_FHWarden = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Warden"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.3) do
		pcall(function()
			if _FHWarden then
				local mob = GetConnectionEnemies("Chief Warden");
				if mob then
					FHNotify("Warden Sword", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHWarden);
					until not _FHWarden or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHWarden then return end;
					FHNotify("Warden Sword", " Boss killed!", 3);
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5206.92578, .997753382, 814.976746);
				end;
			end;
		end);
	end;
end);

FarmingHopTab:AddSection(" Sea 3 Farms");

local _FHEliteQuest = false;
FarmingHopTab:AddToggle({
	Title = "Auto Elite Quest [Sea 3]",
	Desc = "Vai ate Diablo/Urban/Deandre, mata o boss elite, hops se nao achar",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Elite Quest"] or false,
	Callback = function(state)
		_FHEliteQuest = state;
		_G.FarmEliteHunt = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then
			_G.Settings.FarmHop["Auto Elite Quest"] = state;
			(getgenv()).SaveSetting();
		end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.FarmEliteHunt then
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					local qt = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text;
					if string.find(qt, "Diablo") or string.find(qt, "Urban") or string.find(qt, "Deandre") then
						for _, e in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
							if string.find(e.Name,"Diablo") or string.find(e.Name,"Urban") or string.find(e.Name,"Deandre") then
								if e:FindFirstChild("HumanoidRootPart") then
									TweenPlayer(e.HumanoidRootPart.CFrame);
								end;
							end;
						end;
						for _, e in pairs(workspace.Enemies:GetChildren()) do
							if (string.find(e.Name,"Diablo") or string.find(e.Name,"Urban") or string.find(e.Name,"Deandre")) and G.Alive(e) then
								repeat
									task.wait(0.1);
									G.Kill(e, _G.FarmEliteHunt);
									TweenPlayer(e.HumanoidRootPart.CFrame * Pos);
								until not _G.FarmEliteHunt or not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible or not e.Parent or e.Humanoid.Health <= 0;
							end;
						end;
					end;
				else
					(game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("EliteHunter");
				end;
				if game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice")
				   or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice")
				   or game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") then
					_G.FarmEliteHunt = false;
					_FHEliteQuest = false;
					FHNotify("Elite Quest", " Got rare item! Stopping.", 5);
				end;
			end;
		end);
	end;
end);

local _FHCitizenQuest = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Citizen Quest"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Citizen Quest / Ken V2 [Sea 3]",
	Desc = "Auto Citizen Quest para desbloquear Ken V2",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Citizen Quest"] or false,
	Callback = function(state)
		_FHCitizenQuest = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Citizen Quest"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local replicated = game:GetService("ReplicatedStorage");
			if _FHCitizenQuest and World3 then
				replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen");
				task.wait(0.1);
				replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1);
				local mob = GetConnectionEnemies("Forest Pirate") or GetConnectionEnemies("Captain Elephant");
				if mob then
					repeat task.wait(0.1); G.Kill(mob, _FHCitizenQuest);
					until not _FHCitizenQuest or not mob.Parent or mob.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
				end;
			end;
		end);
	end;
end);

local _FHRipIndra = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Rip Indra"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Rip Indra [Sea 3 + Hop]",
	Desc = "Auto kill Rip Indra - hops server se nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Rip Indra"] or false,
	Callback = function(state)
		_FHRipIndra = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Rip Indra"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHRipIndra and World3 then
				local mob = GetConnectionEnemies("Rip_Indra");
				if mob then
					FHNotify("Rip Indra", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHRipIndra);
					until not _FHRipIndra or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHRipIndra then return end;
					FHNotify("Rip Indra", " Boss killed!", 3);
				else
					TweenPlayer(CFrame.new(-12386.9, 364.3, -7590.2));
					task.wait(1);
					if not GetConnectionEnemies("Rip_Indra") then
						FHNotify("Rip Indra", " Hoping Server...", 4);
						Hop();
					end;
				end;
			end;
		end);
	end;
end);

local _FHMarineCoat = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Marine Coat"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Marine Coat [Sea 1 + Hop]",
	Desc = "Auto farm Marine Coat - hops se Vice Admiral nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Marine Coat"] or false,
	Callback = function(state)
		_FHMarineCoat = state;
		_G.MarinesCoat = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Marine Coat"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHMarineCoat then
				local mob = GetConnectionEnemies("Vice Admiral") or GetConnectionEnemies("Fleet Admiral");
				if mob then
					FHNotify("Marine Coat", " Vice Admiral Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHMarineCoat);
					until not _FHMarineCoat or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHMarineCoat then return end;
					FHNotify("Marine Coat", " Boss killed! Restarting...", 3);
				else
					TweenPlayer(CFrame.new(-5039.58643, 27.3500385, 4324.68018));
					task.wait(1);
					if not GetConnectionEnemies("Vice Admiral") then
						FHNotify("Marine Coat", " Hoping Server...", 4);
						Hop();
					end;
				end;
			end;
		end);
	end;
end);

local _FHSwanCoat = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Swan Coat"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto Swan Coat [Sea 2 + Hop]",
	Desc = "Auto kill Don Swan para Swan Coat - Sea 2 Swan Room",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto Swan Coat"] or false,
	Callback = function(state)
		_FHSwanCoat = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Swan Coat"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHSwanCoat then
				local mob = GetConnectionEnemies("Don Swan");
				if mob then
					FHNotify("Swan Coat", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHSwanCoat);
					until not _FHSwanCoat or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHSwanCoat then return end;
					FHNotify("Swan Coat", " Boss killed!", 3);
				else
					pcall(function() (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2285, 15, 905)); end);
					task.wait(1);
					if not GetConnectionEnemies("Don Swan") then
						FHNotify("Swan Coat", " Hoping Server...", 4);
						Hop();
					end;
				end;
			end;
		end);
	end;
end);

local _FHGodChalice = (_G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto God Chalice"]) or false;
FarmingHopTab:AddToggle({
	Title = "Auto God Chalice [Sea 3 + Hop]",
	Desc = "Auto farm God Chalice - hops quando boss nao encontrado",
	Value = _G.Settings and _G.Settings.FarmHop and _G.Settings.FarmHop["Auto God Chalice"] or false,
	Callback = function(state)
		_FHGodChalice = state;
		if not state then StopTween(false); end;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto God Chalice"] = state; (getgenv()).SaveSetting(); end;
		SaveFH();
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _FHGodChalice then
				local mob = GetConnectionEnemies("Order") or GetConnectionEnemies("Cake Queen");
				if mob then
					FHNotify("God Chalice", " Boss Spawned! Killing...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHGodChalice);
					until not _FHGodChalice or not mob.Parent or mob.Humanoid.Health <= 0;
					if not _FHGodChalice then return end;
					FHNotify("God Chalice", " Boss killed!", 3);
				else
					FHNotify("God Chalice", " Hoping Server...", 4);
					task.wait(1);
					Hop();
				end;
			end;
		end);
	end;
end);

local _FHSkullGuitarMat = false;
FarmingHopTab:AddSection(" Material Farm");
FarmingHopTab:AddToggle({
	Title = "Auto Farm Material Skull Guitar",
	Desc = "Detecta e farma: 250 Ectoplasma (Haunted Ship Sea 2), 500 Bones (Haunted Castle Sea 2), 1 Dark Fragment (Darkbeard Sea 2). Ordem: Darkbeard > Ectoplasma > Ossos.",
	Value = false,
	Callback = function(state)
		_FHSkullGuitarMat = state;
		if _G.Settings and _G.Settings.FarmHop then _G.Settings.FarmHop["Auto Skull Guitar Mat"] = state; (getgenv()).SaveSetting(); end;
	end
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if not _FHSkullGuitarMat or not World2 then return; end;
			local plr = game.Players.LocalPlayer;
			local hasEcto  = CheckItemCount and CheckItemCount("Ectoplasm", 250);
			local hasBones = CheckItemCount and CheckItemCount("Bone", 500);
			local hasFrag  = CheckItemCount and CheckItemCount("Dark Fragment", 1);
			if not hasFrag then
				local mob = GetConnectionEnemies("Darkbeard");
				if mob then
					FHNotify("Skull Guitar", "Matando Darkbeard...", 3);
					repeat task.wait(0.1); G.Kill(mob, _FHSkullGuitarMat);
					until not _FHSkullGuitarMat or not mob.Parent or mob.Humanoid.Health <= 0;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625);
				end;
			elseif not hasEcto then
				local mob = workspace.Enemies:FindFirstChild("Zombie") or workspace.Enemies:FindFirstChild("Demonic Soul") or workspace.Enemies:FindFirstChild("Cursed Skeleton");
				if mob then
					repeat task.wait(0.1); G.Kill(mob, _FHSkullGuitarMat);
					until not _FHSkullGuitarMat or not mob.Parent or mob.Humanoid.Health <= 0;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3898, 22, -4100);
				end;
			elseif not hasBones then
				local mob = workspace.Enemies:FindFirstChild("Possessed Mummy") or workspace.Enemies:FindFirstChild("Reaper") or workspace.Enemies:FindFirstChild("Cursed Skeleton");
				if mob then
					repeat task.wait(0.1); G.Kill(mob, _FHSkullGuitarMat);
					until not _FHSkullGuitarMat or not mob.Parent or mob.Humanoid.Health <= 0;
				else
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5000, 22, -3200);
				end;
			else
				_FHSkullGuitarMat = false;
				FHNotify("Skull Guitar", "Todos os materiais coletados!", 6);
			end;
		end);
	end;
end);



local MMon = {}
local MPos = CFrame.new(0,0,0)
local CFrameQuest, CFrameMon, NameQuest, LevelQuest
local Mon, Qdata, Qname, PosQ, PosM, PosB, PosQBoss, bMon
local SelectWeaponG = nil

MaterialMon = function()
	local e = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not e then return end
	if World1 then
		if SelectMaterial == "Angel Wings" then
			MMon = {"Shanda","Royal Squad","Royal Soldier","Wysper","Thunder God"}
			MPos = CFrame.new(-4698,845,-1912)
			shouldRequestEntrance(Vector3.new(-4607.82,872.54,-1667.55),10000)
		elseif SelectMaterial == "Leather + Scrap Metal" then
			MMon = {"Brute","Pirate"}; MPos = CFrame.new(-1145,15,4350)
		elseif SelectMaterial == "Magma Ore" then
			MMon = {"Military Soldier","Military Spy","Magma Admiral"}; MPos = CFrame.new(-5815,84,8820)
		elseif SelectMaterial == "Fish Tail" then
			MMon = {"Fishman Warrior","Fishman Commando","Fishman Lord"}; MPos = CFrame.new(61123,19,1569)
			shouldRequestEntrance(Vector3.new(61163.85,5.34,1819.78),17000)
		end
	elseif World2 then
		if SelectMaterial == "Leather + Scrap Metal" then
			MMon = {"Marine Captain"}; MPos = CFrame.new(-2010.50,73.001,-3326.62)
		elseif SelectMaterial == "Magma Ore" then
			MMon = {"Magma Ninja","Lava Pirate"}; MPos = CFrame.new(-5428,78,-5959)
		elseif SelectMaterial == "Ectoplasm" then
			MMon = {"Ship Deckhand","Ship Engineer","Ship Steward","Ship Officer"}
			MPos = CFrame.new(911.35,125.95,33159.53)
			shouldRequestEntrance(Vector3.new(923.21,126.97,32852.83),1000)
		elseif SelectMaterial == "Mystic Droplet" then
			MMon = {"Water Fighter"}; MPos = CFrame.new(-3385,239,-10542)
		elseif SelectMaterial == "Radioactive Material" then
			MMon = {"Factory Staff"}; MPos = CFrame.new(295,73,-56)
		elseif SelectMaterial == "Vampire Fang" then
			MMon = {"Vampire"}; MPos = CFrame.new(-6033,7,-1317)
		end
	elseif World3 then
		if SelectMaterial == "Scrap Metal" then
			MMon = {"Jungle Pirate","Forest Pirate"}; MPos = CFrame.new(-11975.78,331.77,-10620.03)
		elseif SelectMaterial == "Fish Tail" then
			MMon = {"Fishman Raider","Fishman Captain"}; MPos = CFrame.new(-10993,332,-8940)
		elseif SelectMaterial == "Conjured Cocoa" then
			MMon = {"Chocolate Bar Battler","Cocoa Warrior"}; MPos = CFrame.new(620.63,78.93,-12581.36)
		elseif SelectMaterial == "Dragon Scale" then
			MMon = {"Dragon Crew Archer","Dragon Crew Warrior"}; MPos = CFrame.new(6594,383,139)
		elseif SelectMaterial == "Gunpowder" then
			MMon = {"Pistol Billionaire"}; MPos = CFrame.new(-84.85,85.62,6132.008)
		elseif SelectMaterial == "Mini Tusk" then
			MMon = {"Mythological Pirate"}; MPos = CFrame.new(-13545,470,-6917)
		elseif SelectMaterial == "Demonic Wisp" then
			MMon = {"Demonic Soul"}; MPos = CFrame.new(-9495.68,453.58,5977.34)
		end
	end
end

ShopTab:AddSection("Fighting Styles")
ShopTab:AddButton({Title="Black Leg",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg") end})
ShopTab:AddButton({Title="Fishman Karate",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate") end})
ShopTab:AddButton({Title="Electro",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyElectro") end})
ShopTab:AddButton({Title="Dragon Breath",Callback=function()
	replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
	replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
end})
ShopTab:AddButton({Title="SuperHuman",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuySuperhuman") end})
ShopTab:AddButton({Title="Death Step",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyDeathStep") end})
ShopTab:AddButton({Title="Sharkman Karate",Callback=function()
	replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
	replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
end})
ShopTab:AddButton({Title="Electric Claw",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw") end})
ShopTab:AddButton({Title="Dragon Talon",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon") end})
ShopTab:AddButton({Title="God Human",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyGodhuman") end})
ShopTab:AddButton({Title="Sanguine Art",Callback=function()
	replicated.Remotes.CommF_:InvokeServer("BuySanguineArt",true)
	replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
end})

ShopTab:AddSection("Swords")
ShopTab:AddButton({Title="Cutlass [1,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Cutlass") end})
ShopTab:AddButton({Title="Katana [1,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Katana") end})
ShopTab:AddButton({Title="Iron Mace [25,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Iron Mace") end})
ShopTab:AddButton({Title="Dual Katana [12,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Duel Katana") end})
ShopTab:AddButton({Title="Triple Katana [60,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Triple Katana") end})
ShopTab:AddButton({Title="Pipe [100,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Pipe") end})
ShopTab:AddButton({Title="Dual-Headed Blade [400,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade") end})
ShopTab:AddButton({Title="Bisento [1,200,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento") end})
ShopTab:AddButton({Title="Soul Cane [750,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Soul Cane") end})
ShopTab:AddButton({Title="Pole V2 [5,000 Fragments]",Callback=function() replicated.Remotes.CommF_:InvokeServer("ThunderGodTalk") end})

ShopTab:AddSection("Guns")
ShopTab:AddButton({Title="Slingshot [5,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Slingshot") end})
ShopTab:AddButton({Title="Musket [8,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Musket") end})
ShopTab:AddButton({Title="Flintlock [10,500 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Flintlock") end})
ShopTab:AddButton({Title="Refined Slingshot [30,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Refined Slingshot") end})
ShopTab:AddButton({Title="Refined Flintlock [65,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock") end})
ShopTab:AddButton({Title="Cannon [100,000 Beli]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Cannon") end})
ShopTab:AddButton({Title="Kabucha [1,500 Fragments]",Callback=function() replicated.Remotes.CommF_:InvokeServer("BuyItem","Kabucha") end})

ShopTab:AddSection("Codes")
ShopTab:AddButton({Title="Redeem All Codes",Callback=function()
	local Codes = {
		"KITT_RESET","Sub2UncleKizaru","SUB2GAMERROBOT_RESET1","Sub2Fer999","Enyu_is_Pro","JCWK",
		"StarcodeHEO","MagicBus","KittGaming","Sub2CaptainMaui","Sub2OfficalNoobie","TheGreatAce",
		"Sub2NoobMaster123","Sub2Daigrock","Axiore","StrawHatMaine","TantaiGaming","Bluxxy",
		"SUB2GAMERROBOT_EXP1","Chandler","NOMOREHACK","BANEXPLOIT","WildDares","BossBuild",
		"GetPranked","EARN_FRUITS","FIGHT4FRUIT","NOEXPLOITER","NOOB2ADMIN","CODESLIDE","ADMINHACKED",
		"ADMINDARES","fruitconcepts","krazydares","TRIPLEABUSE","SEATROLLING","24NOADMIN","REWARDFUN",
		"NEWTROLL","fudd10_v2","Fudd10","Bignews","SECRET_ADMIN"
	}
	for _, code in ipairs(Codes) do
		pcall(function() game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code) end)
	end
end})

ShopTab:AddSection("Team")
ShopTab:AddButton({Title="Set Pirate Team",Callback=function() Pirates() end})
ShopTab:AddButton({Title="Set Marine Team",Callback=function() Marines() end})

ShopTab:AddSection("Haki")
local HakiSt = {"State 0","State 1","State 2","State 3","State 4","State 5"}
ShopTab:AddDropdown({Title="Haki States",Options=HakiSt,CurrentOption={"State 0"},Callback=function(sel) _G.SelectStateHaki = sel[1] or sel end})
ShopTab:AddButton({Title="Change Haki",Callback=function()
	local st = _G.SelectStateHaki
	if st == "State 0" then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",0)
	elseif st == "State 1" then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",1)
	elseif st == "State 2" then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",2)
	elseif st == "State 3" then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",3)
	elseif st == "State 4" then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",4)
	elseif st == "State 5" then replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage",5) end
end})

ShopTab:AddSection("Others")
ShopTab:AddButton({Title="Nofog",Callback=function()
	if Lighting:FindFirstChild("LightingLayers") then Lighting.LightingLayers:Destroy() end
	if Lighting:FindFirstChild("SeaTerrorCC") then Lighting.SeaTerrorCC:Destroy() end
	if Lighting:FindFirstChild("FantasySky") then Lighting.FantasySky:Destroy() end
end})
ShopTab:AddToggle({Title="Walk on Water",Value=true,Callback=function(I)
	_G.WalkWater_Part = I
	local e = workspace.Map["WaterBase-Plane"]
	if _G.WalkWater_Part then e.Size = Vector3.new(1000,112,1000)
	else e.Size = Vector3.new(1000,80,1000) end
end})
ShopTab:AddButton({Title="Fps Boost",Callback=function() LowCpu() end})
ShopTab:AddButton({Title="Stretch Screen",Callback=function()
	getgenv().Resolution = {[".gg/scripters"]=0.65}
	local Camera = workspace.CurrentCamera
	if getgenv().gg_scripters == nil then
		game:GetService("RunService").RenderStepped:Connect(function()
			pcall(function()
				Camera.CFrame = Camera.CFrame * CFrame.new(0,0,0,1,0,0,0,getgenv().Resolution[".gg/scripters"],0,0,0,1)
			end)
		end)
	end
	getgenv().gg_scripters = "Aori0001"
end})

-- ===================== MAIN FARM TAB =====================
local function _vWalkToQuest()
	pcall(function()
		if CFrameQuest then
			TweenPlayer(CFrameQuest)
			task.wait(0.5)
			replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
			task.wait(0.1)
			replicated.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
		end
	end)
end

MainTab:AddSection("Auto Farm")
local _selectWeaponDropdown
_selectWeaponDropdown = MainTab:AddDropdown({
	Title="Select Weapon",
	Options={"Melee","Sword","Blox Fruit","Gun"},
	CurrentOption={"Melee"},
	Callback=function(sel)
		_G.SelectWeapon = sel[1] or sel
	end
})

MainTab:AddDropdown({
	Title="Select Boss",
	Options=Boss,
	CurrentOption={Boss[1] or ""},
	Callback=function(sel)
		_G.FindBoss = sel[1] or sel
	end
})

MainTab:AddToggle({
	Title="Auto Farm Level",
	Desc="Farm mobs por quest automaticamente",
	Value=false,
	Callback=function(state)
		_G.Level = state
	end
})

task.spawn(function()
	while task.wait(0.1) do
		pcall(function()
			if not _G.Level then return end
			if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then return end
			local qv = plr.PlayerGui.Main.Quest.Visible
			if not qv then
				_vWalkToQuest()
			else
				local mob = GetConnectionEnemies(MonFarm)
				if mob then
					repeat task.wait()
						G.Kill(mob,_G.Level)
					until not _G.Level or not mob.Parent or mob.Humanoid.Health <= 0
				else
					if CFrameMon then _tp(CFrameMon) end
				end
			end
		end)
	end
end)

MainTab:AddToggle({
	Title="Auto Farm Boss",
	Desc="Farm o boss selecionado",
	Value=false,
	Callback=function(state)
		_G.AutoFarmBoss = state
	end
})

task.spawn(function()
	while task.wait(0.1) do
		pcall(function()
			if not _G.AutoFarmBoss or not _G.FindBoss then return end
			local mob = GetConnectionEnemies(_G.FindBoss)
			if mob then
				repeat task.wait()
					G.Kill(mob,_G.AutoFarmBoss)
				until not _G.AutoFarmBoss or not mob.Parent or mob.Humanoid.Health <= 0
			else
				if PosB then _tp(PosB) end
			end
		end)
	end
end)

MainTab:AddToggle({
	Title="Kill Mobs Nearest",
	Desc="Mata o mob mais proximo automaticamente",
	Value=GetSetting("AutoFarmNear_Save",false),
	Callback=function(I)
		_G.AutoFarmNear = I
		_G.SaveData["AutoFarmNear_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait() do
		pcall(function()
			if not _G.AutoFarmNear then return end
			local char = plr.Character or plr.CharacterAdded:Wait()
			local Root2 = char:FindFirstChild("HumanoidRootPart")
			if not Root2 then return end
			local ClosestEnemy, ShortestDistance = nil, math.huge
			if workspace:FindFirstChild("Enemies") then
				for _, e in pairs(workspace.Enemies:GetChildren()) do
					if e:FindFirstChild("Humanoid") and e:FindFirstChild("HumanoidRootPart") and e.Humanoid.Health > 0 then
						local dist = (Root2.Position - e.HumanoidRootPart.Position).Magnitude
						if dist < ShortestDistance then ShortestDistance = dist; ClosestEnemy = e end
					end
				end
			end
			if ClosestEnemy then
				repeat task.wait()
					G.Kill(ClosestEnemy,_G.AutoFarmNear)
				until not _G.AutoFarmNear or not ClosestEnemy.Parent
					or (ClosestEnemy:FindFirstChild("Humanoid") and ClosestEnemy.Humanoid.Health <= 0)
					or not Root2.Parent
			end
		end)
	end
end)

if World2 then
MainTab:AddToggle({
	Title="Auto Factory Raid",
	Value=GetSetting("AutoFactory_Save",false),
	Callback=function(Value)
		_G.AutoFactory = Value
		_G.SaveData["AutoFactory_Save"] = Value
		SaveSettings()
	end
})

task.spawn(function()
	local FactoryPos = CFrame.new(448.46756,199.356781,-441.389252)
	while task.wait(0.5) do
		pcall(function()
			if not _G.AutoFactory then return end
			local Core = GetConnectionEnemies("Core")
			if Core and Core:FindFirstChild("Humanoid") and Core.Humanoid.Health > 0 then
				repeat task.wait()
					if not _G.AutoFactory then break end
					if not Core or not Core.Parent then break end
					if Core.Humanoid.Health <= 0 then break end
					if _G.SelectWeapon then EquipWeapon(_G.SelectWeapon) end
					_tp(FactoryPos)
				until Core.Humanoid.Health <= 0 or not _G.AutoFactory
			else
				_tp(FactoryPos)
			end
		end)
	end
end)
end

if World3 then
MainTab:AddToggle({
	Title="Auto Pirate Raid",
	Value=GetSetting("AutoRaidCastle_Save",false),
	Callback=function(I)
		_G.AutoRaidCastle = I
		_G.SaveData["AutoRaidCastle_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoRaidCastle then
			pcall(function()
				local TargetCFrame = CFrame.new(-5496.17432,313.768921,-2841.53027)
				local CheckCFrame = CFrame.new(-5539.3115234375,313.80053710938,-2972.3723144531)
				if (CheckCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 500 then
					for _, e in pairs(workspace.Enemies:GetChildren()) do
						if e:FindFirstChild("HumanoidRootPart") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
							if (e.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
								repeat task.wait()
									G.Kill(e,_G.AutoRaidCastle)
								until not _G.AutoRaidCastle or not e.Parent or e.Humanoid.Health <= 0
							end
						end
					end
				else
					_tp(TargetCFrame)
				end
			end)
		end
	end
end)
end

MainTab:AddSection("Collect")
MainTab:AddToggle({
	Title="Auto Collect Chest",
	Value=GetSetting("AutoFarmChest_Save",false),
	Callback=function(I)
		_G.AutoFarmChest = I
		_G.SaveData["AutoFarmChest_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoFarmChest then
			pcall(function()
				local plrChar = plr.Character or plr.CharacterAdded:Wait()
				local d = plrChar:GetPivot().Position
				local Chests = CollectionService:GetTagged("_ChestTagged")
				local minDist, nearestChest = math.huge, nil
				for _, chest in pairs(Chests) do
					local dist = (chest:GetPivot().Position - d).Magnitude
					if not chest:GetAttribute("IsDisabled") and dist < minDist then
						minDist = dist; nearestChest = chest
					end
				end
				if nearestChest then _tp(nearestChest:GetPivot()) end
			end)
		end
	end
end)

MainTab:AddToggle({
	Title="Auto Collect Berry",
	Value=GetSetting("AutoBerry_Save",false),
	Callback=function(I)
		_G.AutoBerry = I
		_G.SaveData["AutoBerry_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoBerry then
			local n = CollectionService:GetTagged("BerryBush")
			for i = 1, #n do
				local e = n[i]
				for _, K in pairs(e:GetAttributes()) do
					_tp(e.Parent:GetPivot())
					for j = 1, #n do
						local e2 = n[j]
						for _, e3 in pairs(e2:GetChildren()) do
							pcall(function()
								_tp(e3.WorldPivot)
								fireproximityprompt(e3.ProximityPrompt, math.huge)
							end)
						end
					end
				end
			end
		end
	end
end)

MainTab:AddSection("Materials")
local MatDropdown = MainTab:AddDropdown({
	Title="Select Material",
	Options=MaterialList,
	CurrentOption={},
	Callback=function(sel)
		SelectMaterial = sel[1] or sel
		_G.SaveData["SelectMaterial_Save"] = SelectMaterial
		SaveSettings()
	end
})

MainTab:AddToggle({
	Title="Auto Farm Material",
	Value=GetSetting("AutoMaterial_Save",false),
	Callback=function(I)
		getgenv().AutoMaterial = I
		_G.SaveData["AutoMaterial_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait() do
		if getgenv().AutoMaterial then
			pcall(function()
				if SelectMaterial then
					MaterialMon(SelectMaterial)
					_tp(MPos)
				end
				for _, K in ipairs(MMon or {}) do
					for _, n in pairs(workspace.Enemies:GetChildren()) do
						if n:FindFirstChild("Humanoid") and n:FindFirstChild("HumanoidRootPart") and n.Humanoid.Health > 0 then
							if n.Name == K then
								repeat task.wait()
									G.Kill(n,getgenv().AutoMaterial)
								until not getgenv().AutoMaterial or not n.Parent or n.Humanoid.Health <= 0
							end
						end
					end
				end
			end)
		end
	end
end)

if World3 then
MainTab:AddSection("Bones")
MainTab:AddToggle({
	Title="Auto Random Bone",
	Value=false,
	Callback=function(v)
		_G.Auto_Random_Bone = v
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.Auto_Random_Bone then
			replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
		end
	end
end)

MainTab:AddToggle({
	Title="Auto Soul Reaper",
	Value=false,
	Callback=function(v)
		_G.AutoHytHallow = v
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoHytHallow then
			pcall(function()
				local mob = GetConnectionEnemies("Soul Reaper")
				if mob then
					repeat task.wait()
						G.Kill(mob,_G.AutoHytHallow)
					until mob.Humanoid.Health <= 0 or not _G.AutoHytHallow
				else
					if not GetBP("Hallow Essence") then
						repeat task.wait(0.1)
							replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
						until not _G.AutoHytHallow or GetBP("Hallow Essence")
					else
						local pos = CFrame.new(-8932.32,146.83,6062.55)
						repeat task.wait(0.1)
							_tp(pos)
						until not _G.AutoHytHallow
						EquipWeapon("Hallow Essence")
					end
				end
			end)
		end
	end
end)
end

-- ===================== MASTERY TAB =====================
MaestryTab:AddSection("Farm Mastery")
local MasteryIslands = {"Cake","Bone"}
MaestryTab:AddDropdown({
	Title="Select Method",
	Options=MasteryIslands,
	CurrentOption={"Cake"},
	Callback=function(I) SelectIsland = I[1] or I end
})

MaestryTab:AddToggle({
	Title="Auto Farm Mastery Fruit",
	Value=GetSetting("FarmMastery_Dev",false),
	Callback=function(I)
		_G.FarmMastery_Dev = I
		_G.SaveData["FarmMastery_Dev"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.1) do
		if _G.FarmMastery_Dev then
			pcall(function()
				local list = (SelectIsland == "Cake" and X or P)
				local mob = GetNearestMobFromList(list)
				if mob then
					HealthM = mob.Humanoid.MaxHealth * 0.7
					repeat task.wait()
						if not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 or not mob:FindFirstChild("HumanoidRootPart") then
							mob = GetNearestMobFromList(list)
							if not mob then break end
						end
						MousePos = mob.HumanoidRootPart.Position
						G.Mas(mob,_G.FarmMastery_Dev)
						if not HasAliveMob(list) then break end
					until not _G.FarmMastery_Dev
				else
					if SelectIsland == "Cake" then _tp(CFrame.new(-1943.6765,251.5095,-12337.8808))
					else _tp(CFrame.new(-9495.6806,453.5862,5977.3486)) end
				end
			end)
		end
	end
end)

MaestryTab:AddToggle({
	Title="Auto Farm Mastery Gun",
	Value=false,
	Callback=function(I)
		_G.FarmMastery_G = I
	end
})

task.spawn(function()
	while task.wait(0.1) do
		if _G.FarmMastery_G then
			pcall(function()
				local list = (SelectIsland == "Cake" and X or P)
				local mob = GetNearestMobFromList(list)
				if mob then
					HealthM = mob.Humanoid.MaxHealth * 0.7
					repeat task.wait()
						if not mob.Parent or not mob:FindFirstChild("Humanoid") or mob.Humanoid.Health <= 0 then
							mob = GetNearestMobFromList(list)
							if not mob then break end
						end
						MousePos = mob.HumanoidRootPart.Position
						G.Masgun(mob,_G.FarmMastery_G)
						local Net2 = replicated:FindFirstChild("Modules") and replicated.Modules:FindFirstChild("Net")
						local shoot = Net2 and Net2:FindFirstChild("RE/ShootGunEvent")
						local tool = plr.Character:FindFirstChildOfClass("Tool")
						if tool and tool.Name == "Skull Guitar" then
							SoulGuitar = true
							tool.RemoteEvent:FireServer("TAP",MousePos)
						elseif tool and shoot then
							SoulGuitar = false
							shoot:FireServer(MousePos,{mob.HumanoidRootPart})
						end
						if not HasAliveMob(list) then break end
					until not _G.FarmMastery_G
					SoulGuitar = false
				else
					if SelectIsland == "Cake" then _tp(CFrame.new(-1943.6765,251.5095,-12337.8808))
					else _tp(CFrame.new(-9495.6806,453.5862,5977.3486)) end
				end
			end)
		end
	end
end)

MaestryTab:AddSection("Fruit Skills for Mastery")
MaestryTab:AddToggle({Title="Fruit Skill Z",Value=false,Callback=function(v) _G.FruitSkills.Z = v end})
MaestryTab:AddToggle({Title="Fruit Skill X",Value=false,Callback=function(v) _G.FruitSkills.X = v end})
MaestryTab:AddToggle({Title="Fruit Skill C",Value=false,Callback=function(v) _G.FruitSkills.C = v end})
MaestryTab:AddToggle({Title="Fruit Skill V",Value=false,Callback=function(v) _G.FruitSkills.V = v end})
MaestryTab:AddToggle({Title="Fruit Skill F",Value=false,Callback=function(v) _G.FruitSkills.F = v end})

-- ===================== OTHERS TAB =====================
OthersTab:AddSection("Observation Haki")
OthersTab:AddToggle({
	Title="Auto Observation V1",
	Value=true,
	Callback=function(I)
		_G.AutoKen = I
		if I then
			task.spawn(function()
				while _G.AutoKen do
					task.wait(0.2)
					pcall(function()
						local char = plr.Character
						if char and not CollectionService:HasTag(char,"Ken") then
							replicated.Remotes.CommE:FireServer("Ken",true)
						end
					end)
				end
			end)
		end
	end
})

if World3 then
OthersTab:AddToggle({
	Title="Auto Observation V2",
	Value=GetSetting("AutoKenV2_Save",false),
	Callback=function(I)
		_G.AutoKenVTWO = I
		_G.SaveData["AutoKenV2_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoKenVTWO then
			pcall(function()
				local I = CFrame.new(-12444.78515625,332.40396118164,-7673.1806640625)
				local n = CFrame.new(-13277.568359375,370.34185791016,-7821.1572265625)
				local d = CFrame.new(-13493.12890625,318.89553833008,-8373.7919921875)
				if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Defeat 50 Forest Pirates") then
					local I2 = GetConnectionEnemies("Forest Pirate")
					if I2 then
						repeat task.wait(); G.Kill(I2,_G.AutoKenVTWO)
						until not _G.AutoKenVTWO or I2.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Quest.Visible
					else _tp(n) end
				elseif plr.PlayerGui.Main.Quest.Visible == true then
					local I2 = GetConnectionEnemies("Captain Elephant")
					if I2 then
						repeat task.wait(); G.Kill(I2,_G.AutoKenVTWO)
						until not _G.AutoKenVTWO or I2.Humanoid.Health <= 0
					else _tp(d) end
				else
					replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen")
					task.wait(0.1)
					replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
				end
			end)
		end
	end
end)

OthersTab:AddToggle({
	Title="Auto Citizen Quest",
	Value=false,
	Callback=function(I) _G.CitizenQuest = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.CitizenQuest then
				local lv = plr.Data.Level.Value
				if lv >= 1800 and not replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress","Citizen") then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Forest Pirate") and plr.PlayerGui.Main.Quest.Visible then
						local I = GetConnectionEnemies("Forest Pirate")
						if I then
							repeat task.wait(); G.Kill(I,_G.CitizenQuest)
							until not _G.CitizenQuest or not I.Parent or I.Humanoid.Health <= 0
						else _tp(CFrame.new(-13206.452148438,425.89199829102,-7964.5537109375)) end
					else
						_tp(CFrame.new(-12443.8671875,332.40396118164,-7675.4892578125))
						task.wait(1.5)
						replicated.Remotes.CommF_:InvokeServer("StartQuest","CitizenQuest",1)
					end
				end
			end
		end)
	end
end)

OthersTab:AddSection("Cursed Swords")
local elitesPara = OthersTab:AddParagraph({Title="Elite Progress",Desc=""})
task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local prog = replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress")
			elitesPara:SetDesc("Elite Progress: "..tostring(prog))
		end)
	end
end)

OthersTab:AddToggle({
	Title="Auto Elite Quest",
	Value=GetSetting("AutoEliteQuest_Save",false),
	Callback=function(I)
		_G.FarmEliteHunt = I
		_G.SaveData["AutoEliteQuest_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.FarmEliteHunt then
				if plr.PlayerGui.Main.Quest.Visible then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") then
						for _, e in pairs(workspace.Enemies:GetChildren()) do
							if (string.find(e.Name,"Diablo") or string.find(e.Name,"Urban") or string.find(e.Name,"Deandre")) and G.Alive(e) then
								repeat task.wait(); G.Kill(e,_G.FarmEliteHunt)
								until not _G.FarmEliteHunt or not e.Parent or e.Humanoid.Health <= 0
							end
						end
					end
				else
					replicated.Remotes.CommF_:InvokeServer("EliteHunter")
				end
			end
		end)
	end
end)

OthersTab:AddToggle({
	Title="Stop when got God Chalice",
	Value=GetSetting("StopChalice_Save",true),
	Callback=function(I)
		_G.StopWhenChalice = I
		_G.SaveData["StopChalice_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.2) do
		if _G.StopWhenChalice and _G.FarmEliteHunt then
			pcall(function()
				if GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
					_G.FarmEliteHunt = false
				end
			end)
		end
	end
end)

OthersTab:AddToggle({
	Title="Auto Tushita Sword",
	Value=false,
	Callback=function(I) _G.Auto_Tushita = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Tushita then
				if workspace.Map.Turtle:FindFirstChild("TushitaGate") then
					if not GetBP("Holy Torch") then
						_tp(CFrame.new(5148.03613,162.352493,910.548218))
					else
						EquipWeapon("Holy Torch"); task.wait(1)
						local positions = {
							CFrame.new(-10752,417,-9366), CFrame.new(-11672,334,-9474),
							CFrame.new(-12132,521,-10655), CFrame.new(-13336,486,-6985), CFrame.new(-13489,332,-7925)
						}
						for _, cf in ipairs(positions) do
							repeat task.wait(); _tp(cf)
							until not _G.Auto_Tushita or (cf.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10
							task.wait(0.7)
						end
					end
				else
					local I = GetConnectionEnemies("Longma")
					if I then
						repeat task.wait(); G.Kill(I,_G.Auto_Tushita)
						until I.Humanoid.Health <= 0 or not _G.Auto_Tushita
					else
						if replicated:FindFirstChild("Longma") then
							_tp(replicated:FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0,40,0))
						end
					end
				end
			end
		end)
	end
end)

OthersTab:AddToggle({
	Title="Auto Yama Sword",
	Value=GetSetting("AutoYama_Save",false),
	Callback=function(I)
		_G.Auto_Yama = I
		_G.SaveData["AutoYama_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Yama then
				local prog = replicated.Remotes.CommF_:InvokeServer("EliteHunter","Progress")
				if prog < 30 then
					_G.FarmEliteHunt = true
				else
					_G.FarmEliteHunt = false
					if (workspace.Map.Waterfall.SealedKatana.Handle.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
						_tp(workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
						local I = GetConnectionEnemies("Ghost")
						if I then
							repeat task.wait(); G.Kill(I,_G.Auto_Yama)
							until I.Humanoid.Health <= 0 or not I.Parent or not _G.Auto_Yama
							fireclickdetector(workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
						end
					end
				end
			end
		end)
	end
end)
end

if World2 or World3 then
OthersTab:AddSection("Buso/Aura Colors")
OthersTab:AddToggle({
	Title="Teleport Barista Haki",
	Value=GetSetting("TpBarista_Save",false),
	Callback=function(I)
		_G.Tp_MasterA = I
		_G.SaveData["TpBarista_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait() do
		if _G.Tp_MasterA then
			pcall(function()
				for _, e in pairs(replicated.NPCs:GetChildren()) do
					if e.Name == "Barista Cousin" then _tp(e.HumanoidRootPart.CFrame) end
				end
			end)
		end
	end
end)

OthersTab:AddButton({Title="Buy Buso Colors",Callback=function()
	replicated.Remotes.CommF_:InvokeServer("ColorsDealer","2")
end})
end

if World3 then
OthersTab:AddToggle({
	Title="Auto Rainbow Haki",
	Value=GetSetting("AutoRainbowHaki_Save",false),
	Callback=function(I)
		_G.Auto_Rainbow_Haki = I
		_G.SaveData["AutoRainbowHaki_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Rainbow_Haki then
				replicated.Remotes.CommF_:InvokeServer("UnlockHaki","Buy")
				replicated.Remotes.CommF_:InvokeServer("UnlockHaki","Check")
			end
		end)
	end
end)

OthersTab:AddToggle({
	Title="Auto Kill Rip Indra",
	Value=GetSetting("AutoRipIndra_Save",false),
	Callback=function(I)
		_G.AutoRipIngay = I
		_G.SaveData["AutoRipIndra_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.AutoRipIngay then
				local I = GetConnectionEnemies("rip_indra")
				if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and I then
					repeat task.wait(); G.Kill(I,_G.AutoRipIngay)
					until not _G.AutoRipIngay or not I.Parent or I.Humanoid.Health <= 0
				end
			end
		end)
	end
end)
end

-- ===================== SEA EVENT TAB =====================
if World2 or World3 then
EventTab:AddSection("Prehistoric Island")
EventTab:AddButton({Title="Remove Lava",Callback=function()
	for _, v in pairs(workspace:GetDescendants()) do
		if v.Name == "Lava" then pcall(function() v:Destroy() end) end
	end
	for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
		if v.Name == "Lava" then pcall(function() v:Destroy() end) end
	end
	Library:Notify({Title="TRon Void Hub",Content="Lava removida!",Icon="check",Duration=3})
end})

EventTab:AddToggle({
	Title="Auto Collect Dino Bones",
	Value=GetSetting("DinoBones_Save",false),
	Callback=function(I)
		_G.Prehis_DB = I
		_G.SaveData["DinoBones_Save"] = I
		SaveSettings()
	end
})

EventTab:AddToggle({
	Title="Auto Collect Dragon Eggs",
	Value=GetSetting("DragonEggs_Save",false),
	Callback=function(I)
		_G.Prehis_DE = I
		_G.SaveData["DragonEggs_Save"] = I
		SaveSettings()
	end
})

EventTab:AddToggle({
	Title="Auto Reset When Complete Volcano",
	Value=GetSetting("ResetVolcano_Save",false),
	Callback=function(I)
		_G.ResetPH = I
		_G.SaveData["ResetVolcano_Save"] = I
		SaveSettings()
	end
})

EventTab:AddToggle({
	Title="Auto Prehistoric Skills",
	Value=false,
	Callback=function(I)
		_G.Prehis_Skills = I
	end
})

task.spawn(function()
	while task.wait() do
		if _G.Prehis_Skills then
			pcall(function()
				if workspace.Enemies:FindFirstChild("Lava Golem") then
					local enemy = GetConnectionEnemies("Lava Golem")
					if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
						repeat task.wait()
							if enemy:FindFirstChild("HumanoidRootPart") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
								_tp(enemy.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
								plr.Character.HumanoidRootPart.Velocity = Vector3.zero
							end
							G.Kill(enemy,_G.Prehis_Skills)
						until not _G.Prehis_Skills or not enemy.Parent or enemy.Humanoid.Health <= 0
					end
				end
				local core = workspace.Map:FindFirstChild("PrehistoricIsland") and workspace.Map.PrehistoricIsland:FindFirstChild("Core")
				if core and core:FindFirstChild("VolcanoRocks") then
					for _, rock in pairs(core.VolcanoRocks:GetChildren()) do
						if rock:FindFirstChild("VFXLayer") then
							local layer = rock.VFXLayer
							if layer:FindFirstChild("At0") and layer.At0:FindFirstChild("Glow") and layer.At0.Glow.Enabled then
								repeat task.wait()
									if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
										local safePos = layer.CFrame * CFrame.new(0,30,0) * CFrame.Angles(math.rad(-90),0,0)
										_tp(safePos)
										plr.Character.HumanoidRootPart.Velocity = Vector3.zero
									end
									if plr:DistanceFromCharacter(layer.CFrame.Position) <= 200 then
										local VIM = game:GetService("VirtualInputManager")
										VIM:SendKeyEvent(true,"Z",false,game)
										VIM:SendKeyEvent(true,"X",false,game)
										VIM:SendKeyEvent(true,"C",false,game)
									end
								until not _G.Prehis_Skills or layer.At0.Glow.Enabled == false or not rock.Parent
							end
						end
					end
				end
			end)
		else
			task.wait(1)
		end
	end
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			local FoundTarget = false
			if _G.Prehis_DE then
				local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland")
				if MapIsland and MapIsland.Core:FindFirstChild("SpawnedDragonEggs") then
					local Egg = MapIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg")
					if Egg and Egg:FindFirstChild("Molten") then
						FoundTarget = true; _G.Collecting = true
						_tp(Egg.Molten.CFrame)
						if (plr.Character.HumanoidRootPart.Position - Egg.Molten.Position).Magnitude <= 15 then
							fireproximityprompt(Egg.Molten.ProximityPrompt,30)
						end
					end
				end
			end
			if _G.Prehis_DB and not FoundTarget then
				local Bone = workspace:FindFirstChild("DinoBone")
				if Bone then
					FoundTarget = true; _G.Collecting = true
					_tp(Bone.CFrame)
				end
			end
			if not FoundTarget then _G.Collecting = false end
		end)
	end
end)

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			if _G.ResetPH then
				local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland")
				local EventEnded = MapIsland and MapIsland:FindFirstChild("TrialTeleport") and MapIsland.TrialTeleport:FindFirstChild("TouchInterest")
				if EventEnded then
					task.wait(4.5)
					while true do
						local ShouldWait = false
						if _G.Prehis_DE and MapIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then ShouldWait = true end
						if _G.Prehis_DB and workspace:FindFirstChild("DinoBone") then ShouldWait = true end
						if _G.Collecting then ShouldWait = true end
						if ShouldWait then task.wait(0.5) else break end
					end
					plr.Character.Humanoid.Health = 0
					task.wait(8)
				end
			end
		end)
	end
end)
end

-- ===================== RACE TAB =====================
if World2 then
RaceTab:AddSection("Race Upgrade")
RaceTab:AddToggle({
	Title="Auto Mink V2/V3",
	Value=false,
	Callback=function(I) _G.Auto_Mink = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Auto_Mink then
				if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") ~= 2 then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist","2")
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
						if not plr.Backpack:FindFirstChild("Flower 1") then
							_tp(workspace.Flower1.CFrame)
						elseif not plr.Backpack:FindFirstChild("Flower 2") then
							_tp(workspace.Flower2.CFrame)
						end
					end
				end
			end
		end)
	end
end)
end

RaceTab:AddSection("Race Trials")
RaceTab:AddButton({Title="Teleport to Ancient One",Callback=function()
	notween(CFrame.new(28981.552734375,14888.426757812,-120.24584960938))
end})
RaceTab:AddButton({Title="Teleport to Ancient Clock",Callback=function()
	notween(CFrame.new(29549,15069,-88))
end})

RaceTab:AddToggle({
	Title="Auto Teleport to Race Doors",
	Value=false,
	Callback=function(I) _G.TPDoor = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.TPDoor then
				local race = tostring(plr.Data.Race.Value)
				if race == "Mink" then _tp(CFrame.new(29020.66015625,14889.426757812,-379.2682800293))
				elseif race == "Fishman" then _tp(CFrame.new(28224.056640625,14889.426757812,-210.58720397949))
				elseif race == "Cyborg" then _tp(CFrame.new(28492.4140625,14894.426757812,-422.11001586914))
				elseif race == "Skypiea" then _tp(CFrame.new(28967.408203125,14918.075195312,234.31198120117))
				elseif race == "Ghoul" then _tp(CFrame.new(28672.720703125,14889.127929688,454.59616088867))
				elseif race == "Human" then _tp(CFrame.new(29237.294921875,14889.426757812,-206.94955444336)) end
			end
		end)
	end
end)

RaceTab:AddToggle({
	Title="Auto Complete Trial Race",
	Value=false,
	Callback=function(I) _G.Complete_Trials = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Complete_Trials then
				local race = tostring(plr.Data.Race.Value)
				if race == "Mink" then notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0,-20,0))
				elseif race == "Cyborg" then _tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0,500,0))
				elseif race == "Skypiea" then notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
				elseif race == "Human" or race == "Ghoul" then
					local I = GetConnectionEnemies({"Ancient Vampire","Ancient Zombie"})
					if I then
						repeat task.wait(); G.Kill(I,_G.Complete_Trials)
						until not _G.Complete_Trials or I.Humanoid.Health <= 0 or not I.Parent
					end
				end
			end
		end)
	end
end)

RaceTab:AddToggle({
	Title="Auto Kill Player After Trial",
	Value=false,
	Callback=function(I) _G.Defeating = I end
})

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Defeating then
				for _, e in pairs(workspace.Characters:GetChildren()) do
					if e.Name ~= plr.Name and e.Humanoid.Health > 0 and e:FindFirstChild("HumanoidRootPart") then
						if (plr.Character.HumanoidRootPart.Position - e.HumanoidRootPart.Position).Magnitude <= 250 then
							repeat task.wait()
								EquipWeapon(_G.SelectWeapon or "")
								_tp(e.HumanoidRootPart.CFrame * CFrame.new(0,0,15))
								pcall(function() sethiddenproperty(plr,"SimulationRadius",math.huge) end)
							until not _G.Defeating or e.Humanoid.Health <= 0 or not e.Parent
						end
					end
				end
			end
		end)
	end
end)

-- ===================== DOJO TAB =====================
if World3 then
DojoTab:AddSection("Dojo Trainer")
DojoTab:AddToggle({
	Title="Auto Dojo Trainer",
	Value=false,
	Callback=function(I) _G.Dojoo = I end
})

task.spawn(function()
	while task.wait(0.5) do
		if _G.Dojoo then
			pcall(function()
				local I = {{NPC="Dojo Trainer",Command="RequestQuest"}}
				local e = (replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest")):InvokeServer(unpack(I))
				local K = (type(e)=="table" and e.Quest and e.Quest.BeltName) or nil
				if not e or not K then
					_tp(CFrame.new(5865.0234375,1208.3154296875,871.15185546875))
				elseif K == "White" then
					local I2 = GetConnectionEnemies("Skull Slayer")
					if I2 then
						repeat task.wait(); G.Kill(I2,_G.Dojoo)
						until not e or not _G.Dojoo or I2.Humanoid.Health <= 0
					else _tp(CFrame.new(-16759.58984375,71.283767700195,1595.3399658203)) end
				elseif K == "Purple" then
					_G.FarmEliteHunt = true
				elseif K == "Black" then
					_G.Prehis_Find = true
				end
			end)
		end
	end
end)
end

-- ===================== ESP & STATS TAB =====================
EspTab:AddSection("ESP")

local BerryEsp, PlayerEsp, ChestESP, DevilFruitESP, _G_IslandESP = false, false, false, false, false

EspTab:AddToggle({Title="Esp Berries",Value=false,Callback=function(I)
	BerryEsp = I
	task.spawn(function()
		while BerryEsp do
			task.wait(1)
			pcall(function()
				local n = CollectionService:GetTagged("BerryBush")
				for _, e in ipairs(n) do
					local pos = e.Parent:GetPivot().Position
					for _, attr in pairs(e:GetAttributes()) do
						local name = "BerryEspPart_"..tostring(pos)
						local d = workspace:FindFirstChild(name)
						if not d then
							d = Instance.new("Part",workspace)
							d.Name = name; d.Transparency = 1; d.Anchored = true; d.CanCollide = false
							d.CFrame = CFrame.new(pos)
						end
						if not d:FindFirstChild("NameEsp") then
							local gui = Instance.new("BillboardGui",d)
							gui.Name = "NameEsp"; gui.Size = UDim2.new(0,200,0,30); gui.AlwaysOnTop = true
							local txt = Instance.new("TextLabel",gui)
							txt.Font = Enum.Font.Code; txt.TextColor3 = Color3.new(1,1,1)
							txt.BackgroundTransparency = 1; txt.Size = UDim2.new(1,0,1,0)
						end
						local dist = (plr.Character.Head.Position - pos).Magnitude / 3
						d.NameEsp.TextLabel.Text = "["..tostring(attr).."] "..math.round(dist).." M"
					end
				end
			end)
		end
		for _, e in ipairs(workspace:GetChildren()) do
			if e.Name:match("BerryEspPart_") then e:Destroy() end
		end
	end)
end})

EspTab:AddToggle({Title="Esp Players",Value=false,Callback=function(I)
	PlayerEsp = I
	task.spawn(function()
		while PlayerEsp do task.wait(0.5)
			pcall(function()
				for _, v in pairs(Players:GetChildren()) do
					if v.Character and v.Character:FindFirstChild("Head") then
						if not v.Character.Head:FindFirstChild("EspPlayer"..Number) then
							local bill = Instance.new("BillboardGui",v.Character.Head)
							bill.Name = "EspPlayer"..Number; bill.Size = UDim2.new(1,200,1,30); bill.AlwaysOnTop = true
							local name2 = Instance.new("TextLabel",bill)
							name2.Font = Enum.Font.GothamSemibold; name2.TextWrapped = true
							name2.Size = UDim2.new(1,0,1,0); name2.BackgroundTransparency = 1; name2.TextStrokeTransparency = 0.5
							name2.TextColor3 = v.Team == plr.Team and Color3.fromRGB(50,200,50) or Color3.fromRGB(200,50,50)
						end
						pcall(function()
							local dist = math.floor((plr.Character.Head.Position - v.Character.Head.Position).Magnitude/3)
							v.Character.Head["EspPlayer"..Number].TextLabel.Text = v.Name.." | "..dist.." M\nHP: "..math.round(v.Character.Humanoid.Health*100/v.Character.Humanoid.MaxHealth).."%"
						end)
					end
				end
			end)
		end
	end)
end})

EspTab:AddToggle({Title="Esp Chests",Value=false,Callback=function(I)
	ChestESP = I
	task.spawn(function()
		while ChestESP do task.wait(1)
			pcall(function()
				for _, v in pairs(workspace.ChestModels:GetChildren()) do
					if v.Name:find("Chest") and v:FindFirstChild("RootPart") then
						if not v:FindFirstChild("EspChest"..Number) then
							local bill = Instance.new("BillboardGui",v)
							bill.Name = "EspChest"..Number; bill.Size = UDim2.new(1,200,1,30); bill.AlwaysOnTop = true
							local name2 = Instance.new("TextLabel",bill)
							name2.Font = Enum.Font.Nunito; name2.TextWrapped = true
							name2.Size = UDim2.new(1,0,1,0); name2.BackgroundTransparency = 1
							name2.TextColor3 = Color3.fromRGB(173,158,21)
						end
						pcall(function()
							v["EspChest"..Number].TextLabel.Text = v.Name.." "..math.floor((plr.Character.Head.Position - v.RootPart.Position).Magnitude/3).." M"
						end)
					end
				end
			end)
		end
	end)
end})

EspTab:AddToggle({Title="Esp Fruits",Value=false,Callback=function(I)
	DevilFruitESP = I
	task.spawn(function()
		while DevilFruitESP do task.wait(1)
			pcall(function()
				for _, v in pairs(workspace:GetChildren()) do
					if v.Name and v.Name:find("Fruit") and v:FindFirstChild("Handle") then
						if not v.Handle:FindFirstChild("EspDevilFruit"..Number) then
							local bill = Instance.new("BillboardGui",v.Handle)
							bill.Name = "EspDevilFruit"..Number; bill.Size = UDim2.new(1,200,1,30); bill.AlwaysOnTop = true
							local name2 = Instance.new("TextLabel",bill)
							name2.Font = Enum.Font.GothamSemibold; name2.TextWrapped = true
							name2.Size = UDim2.new(1,0,1,0); name2.BackgroundTransparency = 1
							name2.TextColor3 = Color3.fromRGB(255,255,255)
						end
						pcall(function()
							v.Handle["EspDevilFruit"..Number].TextLabel.Text = v.Name.." "..math.floor((plr.Character.Head.Position - v.Handle.Position).Magnitude/3).." M"
						end)
					end
				end
			end)
		end
	end)
end})

EspTab:AddToggle({Title="Esp Island",Value=false,Callback=function(I)
	_G_IslandESP = I
	task.spawn(function()
		while true do task.wait(2)
			for _, island in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
				pcall(function()
					if island.Name ~= "Sea" then
						if _G_IslandESP then
							if not island:FindFirstChild("IslandESP") then
								local billboard = Instance.new("BillboardGui",island)
								billboard.Name = "IslandESP"; billboard.Size = UDim2.new(0,150,0,35)
								billboard.StudsOffset = Vector3.new(0,35,0); billboard.AlwaysOnTop = true
								local text = Instance.new("TextLabel",billboard)
								text.Size = UDim2.new(1,0,1,0); text.BackgroundTransparency = 1
								text.Text = island.Name; text.TextColor3 = Color3.fromRGB(255,255,255)
								text.TextStrokeTransparency = 0; text.TextScaled = true
								text.Font = Enum.Font.Cartoon
							end
						else
							if island:FindFirstChild("IslandESP") then island.IslandESP:Destroy() end
						end
					end
				end)
			end
			if not _G_IslandESP then break end
		end
	end)
end})

EspTab:AddSection("Stats")
EspTab:AddToggle({
	Title="Add Points Melee",
	Value=GetSetting("AutoMelee_Save",false),
	Callback=function(I)
		_G.Auto_Melee = I
		_G.SaveData["AutoMelee_Save"] = I
		SaveSettings()
	end
})
EspTab:AddToggle({
	Title="Add Points Sword",
	Value=GetSetting("AutoSword_Save",false),
	Callback=function(I)
		_G.Auto_Sword = I
		_G.SaveData["AutoSword_Save"] = I
		SaveSettings()
	end
})
EspTab:AddToggle({
	Title="Add Points Gun",
	Value=GetSetting("AutoGun_Save",false),
	Callback=function(I)
		_G.Auto_Gun = I
		_G.SaveData["AutoGun_Save"] = I
		SaveSettings()
	end
})
EspTab:AddToggle({
	Title="Add Points Fruit",
	Value=GetSetting("AutoFruit_Save",false),
	Callback=function(I)
		_G.Auto_Blox = I
		_G.SaveData["AutoFruit_Save"] = I
		SaveSettings()
	end
})
EspTab:AddToggle({
	Title="Add Points Defense",
	Value=GetSetting("AutoDefense_Save",false),
	Callback=function(I)
		_G.Auto_Defense = I
		_G.SaveData["AutoDefense_Save"] = I
		SaveSettings()
	end
})

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			local remote = replicated.Remotes.CommF_
			if _G.Auto_Melee then remote:InvokeServer("AddPoint","Melee",3) end
			if _G.Auto_Sword then remote:InvokeServer("AddPoint","Sword",3) end
			if _G.Auto_Gun then remote:InvokeServer("AddPoint","Gun",3) end
			if _G.Auto_Blox then remote:InvokeServer("AddPoint","Demon Fruit",3) end
			if _G.Auto_Defense then remote:InvokeServer("AddPoint","Defense",3) end
		end)
	end
end)

-- ===================== LOCAL PLAYER TAB =====================
LocalPlayerTab:AddSection("PvP / Aimbot")
local O5 = {}
for _, p in pairs(Players:GetPlayers()) do
	if p.Name ~= plr.Name then table.insert(O5, p.Name) end
end
local PlayerDropdown2 = LocalPlayerTab:AddDropdown({
	Title="Select Player",
	Options=O5,
	CurrentOption={},
	Callback=function(I) _G.PlayersList = I[1] or I end
})
LocalPlayerTab:AddButton({Title="Refresh Player List",Callback=function()
	local NewPlayers = {}
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name ~= plr.Name then table.insert(NewPlayers, p.Name) end
	end
	pcall(function() PlayerDropdown2:Refresh(NewPlayers, true) end)
end})

LocalPlayerTab:AddToggle({
	Title="Teleport to Player",
	Value=false,
	Callback=function(I)
		_G.TpPly = I
		task.spawn(function()
			while _G.TpPly do task.wait()
				pcall(function()
					_tp(Players[_G.PlayersList].Character.HumanoidRootPart.CFrame)
				end)
			end
		end)
	end
})

LocalPlayerTab:AddToggle({
	Title="Spectate Player",
	Value=false,
	Callback=function(I)
		SpectatePlys = I
		task.spawn(function()
			repeat task.wait(0.1)
				pcall(function()
					workspace.Camera.CameraSubject = Players:FindFirstChild(_G.PlayersList).Character.Humanoid
				end)
			until not SpectatePlys
			pcall(function() workspace.Camera.CameraSubject = plr.Character.Humanoid end)
		end)
	end
})

LocalPlayerTab:AddSection("Aimbot")
LocalPlayerTab:AddToggle({
	Title="Aimbot Cam Lock",
	Value=false,
	Callback=function(I) _G.AimCam = I end
})

LocalPlayerTab:AddToggle({
	Title="Aimbot Skills",
	Value=false,
	Callback=function(state)
		_G.SilentAim = state
	end
})

LocalPlayerTab:AddSection("Movement")
local desiredSpeed = 24
local desiredJump = 50
local SpeedEnabled = false
local JumpEnabled = false

local function applyStats()
	pcall(function()
		local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
		if not hum then return end
		if SpeedEnabled then hum.WalkSpeed = desiredSpeed end
		if JumpEnabled then hum.JumpPower = desiredJump end
	end)
end

LocalPlayerTab:AddToggle({
	Title="Set WalkSpeed",
	Value=false,
	Callback=function(Value) SpeedEnabled = Value; applyStats() end
})
LocalPlayerTab:AddInput({
	Title="WalkSpeed Value",
	Placeholder="24",
	Callback=function(Value)
		local num = tonumber(Value)
		if num then desiredSpeed = num; applyStats() end
	end
})
LocalPlayerTab:AddToggle({
	Title="Set JumpPower",
	Value=false,
	Callback=function(Value) JumpEnabled = Value; applyStats() end
})
LocalPlayerTab:AddInput({
	Title="JumpPower Value",
	Placeholder="50",
	Callback=function(Value)
		local num = tonumber(Value)
		if num then desiredJump = num; applyStats() end
	end
})

plr.CharacterAdded:Connect(function()
	task.wait(1)
	applyStats()
end)

LocalPlayerTab:AddSection("Abilities")
LocalPlayerTab:AddToggle({
	Title="Infinite Energy",
	Value=false,
	Callback=function(I)
		infEnergy = I
		if I then getInfinity_Ability("Energy",infEnergy) end
	end
})
LocalPlayerTab:AddToggle({
	Title="Infinite Soru",
	Value=false,
	Callback=function(I)
		_G.InfSoru = I
		if I then getInfinity_Ability("Soru",_G.InfSoru) end
	end
})
LocalPlayerTab:AddToggle({
	Title="Infinite Observation Range",
	Value=false,
	Callback=function(I)
		_G.InfiniteObRange = I
		if I then getInfinity_Ability("Observation",_G.InfiniteObRange) end
	end
})
LocalPlayerTab:AddToggle({
	Title="Instance Mink V3 [INF]",
	Value=false,
	Callback=function(I)
		InfAblities = I
		task.spawn(function()
			while task.wait(0.2) do
				pcall(function()
					if InfAblities then
						if not plr.Character.HumanoidRootPart:FindFirstChild("Agility") then
							local I2 = replicated.FX.Agility:Clone()
							I2.Name = "Agility"; I2.Parent = plr.Character.HumanoidRootPart
						end
					else
						if plr.Character.HumanoidRootPart:FindFirstChild("Agility") then
							plr.Character.HumanoidRootPart.Agility:Destroy()
						end
					end
				end)
			end
		end)
	end
})

LocalPlayerTab:AddSection("Accept Ally")
LocalPlayerTab:AddToggle({
	Title="Accept Allies",
	Value=false,
	Callback=function(I)
		_G.AcceptAlly = I
		task.spawn(function()
			while task.wait(0.5) do
				if _G.AcceptAlly then
					pcall(function()
						for _, e in pairs(ply:GetChildren()) do
							if e.Name ~= plr.Name and e:FindFirstChild("HumanoidRootPart") then
								replicated.Remotes.CommF_:InvokeServer("AcceptAlly",e.Name)
							end
						end
					end)
				end
			end
		end)
	end
})

-- ===================== TELEPORT TAB =====================
TeleportTab:AddSection("Travel - Worlds")
TeleportTab:AddButton({Title="Teleport Sea 1",Callback=function() replicated.Remotes.CommF_:InvokeServer("TravelMain") end})
TeleportTab:AddButton({Title="Teleport Sea 2",Callback=function() replicated.Remotes.CommF_:InvokeServer("TravelDressrosa") end})
TeleportTab:AddButton({Title="Teleport Sea 3",Callback=function() replicated.Remotes.CommF_:InvokeServer("TravelZou") end})

TeleportTab:AddSection("Travel - Island")
TeleportTab:AddDropdown({
	Title="Select Island",
	Options=Location,
	CurrentOption={},
	Callback=function(I) _G.Island = I[1] or I end
})
TeleportTab:AddToggle({
	Title="Auto Travel to Island",
	Value=false,
	Callback=function(Value)
		_G.Teleport = Value
		if Value then
			task.spawn(function()
				pcall(function()
					local targetIsland = workspace._WorldOrigin.Locations:FindFirstChild(_G.Island)
					if targetIsland then
						local Root2 = plr.Character.HumanoidRootPart
						Root2.CFrame = Root2.CFrame * CFrame.new(0,700,0)
						task.wait(0.1)
						local destination = targetIsland.CFrame * CFrame.new(0,700,0)
						repeat task.wait(); _tp(destination)
						until not _G.Teleport or (Root2.Position - destination.p).Magnitude < 10
						if _G.Teleport then Root2.CFrame = targetIsland.CFrame * CFrame.new(0,5,0) end
						_G.Teleport = false
					end
				end)
			end)
		end
	end
})

TeleportTab:AddSection("Travel - Portal")
TeleportTab:AddDropdown({
	Title="Select Portal",
	Options=Location_Portal or {},
	CurrentOption={},
	Callback=function(I) _G.Island_PT = I[1] or I end
})
TeleportTab:AddButton({Title="Enter Portal",Callback=function()
	local pt = _G.Island_PT
	if pt == "Sky" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894,5547,-380))
	elseif pt == "UnderWater" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163,11,1819))
	elseif pt == "SwanRoom" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(2285,15,905))
	elseif pt == "Cursed Ship" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923,126,32852))
	elseif pt == "Castle On The Sea" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-5097.93164,316.447021,-3142.66602))
	elseif pt == "Mansion Cafe" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875,374.94024658203,-7551.677734375))
	elseif pt == "Hydra Teleport" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5643.4526367188,1013.0858154297,-340.51025390625))
	elseif pt == "Canvendish Room" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(5314.5463867188,22.562219619751,-127.06755065918))
	elseif pt == "Temple of Time" then replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(28310.0234,14895.1123,109.456741)) end
end})

TeleportTab:AddSection("Travel - NPCs")
TeleportTab:AddDropdown({
	Title="Select NPC",
	Options=NPCList,
	CurrentOption={},
	Callback=function(I) NPClist = I[1] or I end
})
TeleportTab:AddToggle({
	Title="Auto Tween to NPC",
	Value=false,
	Callback=function(I)
		_G.TPNpc = I
		task.spawn(function()
			while task.wait(0.5) do
				if _G.TPNpc then
					pcall(function()
						for _, e in pairs(replicated.NPCs:GetChildren()) do
							if e.Name == NPClist and e:FindFirstChild("HumanoidRootPart") then
								_tp(e.HumanoidRootPart.CFrame)
							end
						end
					end)
				end
			end
		end)
	end
})

-- ===================== GET ITEMS TAB =====================
GetTab:AddSection("All Seas")
GetTab:AddToggle({Title="Teleport Legendary Sword Dealer",Value=GetSetting("TpLegendarySword_Save",false),Callback=function(I)
	_G.Tp_LgS = I
	_G.SaveData["TpLegendarySword_Save"] = I
	SaveSettings()
end})
task.spawn(function()
	while task.wait(0.5) do
		if _G.Tp_LgS then
			pcall(function()
				for _, e in pairs(replicated.NPCs:GetChildren()) do
					if e.Name == "Legendary Sword Dealer " then _tp(e.HumanoidRootPart.CFrame) end
				end
			end)
		end
	end
end)

if World2 then
GetTab:AddSection("Law Raid")
GetTab:AddToggle({Title="Auto Law Raid",Value=false,Callback=function(state) _G.AutoLawKak = state end})
task.spawn(function()
	while task.wait(0.5) do
		if _G.AutoLawKak then
			pcall(function()
				replicated.Remotes.CommF_:InvokeServer("BlackbeardReward","Microchip","2")
				fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
				local enemy = GetConnectionEnemies("Order")
				if enemy then
					repeat task.wait(); G.Kill(enemy,_G.AutoLawKak)
					until not _G.AutoLawKak or not enemy.Parent or enemy.Humanoid.Health <= 0
				else _tp(CFrame.new(-6217.2021484375,28.047645568848,-5053.1357421875)) end
			end)
		end
	end
end)
end

if World1 then
GetTab:AddSection("Sea 1 Items")
GetTab:AddToggle({Title="Auto Saw Sword",Value=false,Callback=function(I) _G.AutoSaw = I end})
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.AutoSaw then
				local I = GetConnectionEnemies("The Saw")
				if I then
					repeat task.wait(); G.Kill(I,_G.AutoSaw)
					until not _G.AutoSaw or I.Humanoid.Health <= 0
				else _tp(CFrame.new(-784.89715576172,72.427383422852,1603.5822753906)) end
			end
		end)
	end
end)

GetTab:AddToggle({Title="Auto Usoap Hat",Value=false,Callback=function(I) _G.AutoGetUsoap = I end})
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.AutoGetUsoap then
				for _, e in pairs(workspace.Characters:GetChildren()) do
					if e.Name ~= plr.Name and e.Humanoid.Health > 0 and e:FindFirstChild("HumanoidRootPart") then
						if (plr.Character.HumanoidRootPart.Position - e.HumanoidRootPart.Position).Magnitude <= 230 then
							repeat task.wait()
								EquipWeapon(_G.SelectWeapon or "")
								_tp(e.HumanoidRootPart.CFrame * CFrame.new(1,1,2))
							until not _G.AutoGetUsoap or e.Humanoid.Health <= 0 or not e.Parent
						end
					end
				end
			end
		end)
	end
end)

GetTab:AddToggle({Title="Auto Bisento V2",Value=false,Callback=function(I) _G.Greybeard = I end})
task.spawn(function()
	while task.wait(0.5) do
		if _G.Greybeard then
			pcall(function()
				if not GetWP("Bisento") then
					replicated.Remotes.CommF_:InvokeServer("BuyItem","Bisento")
				else
					replicated.Remotes.CommF_:InvokeServer("LoadItem","Bisento")
					local I = GetConnectionEnemies("Greybeard")
					if I then
						repeat task.wait(); G.Kill(I,_G.Greybeard)
						until not _G.Greybeard or not I.Parent or I.Humanoid.Health <= 0
					else _tp(CFrame.new(-5023.3833007812,28.652032852173,4332.3818359375)) end
				end
			end)
		end
	end
end)

GetTab:AddToggle({Title="Auto Warden Sword",Value=false,Callback=function(I) _G.WardenBoss = I end})
task.spawn(function()
	while task.wait(0.2) do
		if _G.WardenBoss then
			pcall(function()
				local I = GetConnectionEnemies("Chief Warden")
				if I then
					repeat task.wait(); G.Kill(I,_G.WardenBoss)
					until not _G.WardenBoss or not I.Parent or I.Humanoid.Health <= 0
				else _tp(CFrame.new(5206.92578,.997753382,814.976746)) end
			end)
		end
	end
end)

GetTab:AddToggle({Title="Auto Marine Coat",Value=false,Callback=function(I) _G.MarinesCoat = I end})
task.spawn(function()
	while task.wait(0.2) do
		if _G.MarinesCoat then
			pcall(function()
				local I = GetConnectionEnemies("Vice Admiral")
				if I then
					repeat task.wait(); G.Kill(I,_G.MarinesCoat)
					until not _G.MarinesCoat or not I.Parent or I.Humanoid.Health <= 0
				else _tp(CFrame.new(-5006.5454101563,88.032081604004,4353.162109375)) end
			end)
		end
	end
end)

GetTab:AddToggle({Title="Auto Swan Coat",Value=false,Callback=function(I) _G.SwanCoat = I end})
task.spawn(function()
	while task.wait(0.2) do
		if _G.SwanCoat then
			pcall(function()
				local I = GetConnectionEnemies("Swan")
				if I then
					repeat task.wait(); G.Kill(I,_G.SwanCoat)
					until not _G.SwanCoat or not I.Parent or I.Humanoid.Health <= 0
				else _tp(CFrame.new(5325.09619,7.03906584,719.570679)) end
			end)
		end
	end
end)
end

if World2 then
GetTab:AddSection("Sea 2 Items")
GetTab:AddToggle({Title="Auto Rengoku Sword",Value=false,Callback=function(I) _G.AutoKeyRen = I end})
task.spawn(function()
	local K = {"Snow Lurker","Arctic Warrior","Hidden Key","Awakened Ice Admiral"}
	while task.wait(0.2) do
		pcall(function()
			if _G.AutoKeyRen then
				if plr.Backpack:FindFirstChild(K[3]) or plr.Character:FindFirstChild(K[3]) then
					EquipWeapon(K[3]); task.wait(0.1)
					_tp(CFrame.new(6571.1201171875,299.23028564453,-6967.841796875))
				else
					local enemy = GetConnectionEnemies("Awakened Ice Admiral")
					if enemy then
						repeat task.wait(); G.Kill(enemy,_G.AutoKeyRen)
						until plr.Backpack:FindFirstChild(K[3]) or not enemy.Parent or enemy.Humanoid.Health <= 0 or not _G.AutoKeyRen
					else _tp(CFrame.new(5439.716796875,84.420944213867,-6715.1635742188)) end
				end
			end
		end)
	end
end)

GetTab:AddToggle({Title="Auto Dragon Trident",Value=false,Callback=function(I) _G.AutoTridentW2 = I end})
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.AutoTridentW2 then
				local I = GetConnectionEnemies("Tide Keeper")
				if I then
					repeat task.wait(); G.Kill(I,_G.AutoTridentW2)
					until not _G.AutoTridentW2 or not I.Parent or I.Humanoid.Health <= 0
				else _tp(CFrame.new(-3795.6423339844,105.88877105713,-11421.307617188)) end
			end
		end)
	end
end)

GetTab:AddToggle({Title="Auto Long Sword (Diamond)",Value=false,Callback=function(I) _G.LongsWord = I end})
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if _G.LongsWord then
				local I = GetConnectionEnemies("Diamond")
				if I then
					repeat task.wait(); G.Kill(I,_G.LongsWord)
					until not _G.LongsWord or not I.Parent or I.Humanoid.Health <= 0
				else _tp(CFrame.new(-1576.7166748047,198.59265136719,13.724286079407)) end
			end
		end)
	end
end)

GetTab:AddToggle({Title="Auto Black Spikey (Jeremy)",Value=false,Callback=function(I) _G.BlackSpikey = I end})
task.spawn(function()
	while task.wait(0.2) do
		if _G.BlackSpikey then
			pcall(function()
				local I = GetConnectionEnemies("Jeremy")
				if I then
					repeat task.wait(); G.Kill(I,_G.BlackSpikey)
					until not _G.BlackSpikey or not I.Parent or I.Humanoid.Health <= 0
				else _tp(CFrame.new(2006.9261474609,448.95666503906,853.98284912109)) end
			end)
		end
	end
end)

GetTab:AddToggle({Title="Auto Midnight Blade (Ectoplasm)",Value=false,Callback=function(I) _G.AutoEcBoss = I end})
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.AutoEcBoss then
				if GetM("Ectoplasm") >= 99 then
					replicated.Remotes.CommF_:InvokeServer("Ectoplasm","Buy",3)
				else
					local I = GetConnectionEnemies("Cursed Captain")
					if I then
						repeat task.wait(); G.Kill(I,_G.AutoEcBoss)
						until not _G.AutoEcBoss or not I.Parent or I.Humanoid.Health <= 0
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406,126.9760055542,32852.83203125))
						task.wait(0.5)
						_tp(CFrame.new(916.928589,181.092773,33422))
					end
				end
			end
		end)
	end
end)

GetTab:AddToggle({Title="Auto Darkbeard Coat",Value=false,Callback=function(I) _G.Auto_Def_DarkCoat = I end})
task.spawn(function()
	while task.wait(0.2) do
		if _G.Auto_Def_DarkCoat then
			pcall(function()
				if GetBP("Fist of Darkness") and not workspace.Enemies:FindFirstChild("Darkbeard") then
					_tp(CFrame.new(3677.08203125,62.751937866211,-3144.8332519531))
				elseif GetConnectionEnemies("Darkbeard") then
					local I = GetConnectionEnemies("Darkbeard")
					if I then
						repeat task.wait(); G.Kill(I,_G.Auto_Def_DarkCoat)
						until not _G.Auto_Def_DarkCoat or not I.Parent or I.Humanoid.Health <= 0
					end
				end
			end)
		end
	end
end)
end

-- ===================== RAID & FRUIT TAB =====================
FruitTab:AddSection("Raid")

local function IsIslandRaid(cu)
	local locs = workspace._WorldOrigin.Locations
	for _, v in ipairs(locs:GetChildren()) do
		if v.Name == "Island "..cu then
			local dist = (v.Position - plr.Character.HumanoidRootPart.Position).Magnitude
			if dist <= 4500 then return v end
		end
	end
end

local function attackNearbyEnemies()
	for _, mob in pairs(workspace.Enemies:GetChildren()) do
		if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") then
			if mob.Humanoid.Health > 0 then
				local dist = (mob.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
				if dist <= 1000 then
					repeat G.Kill(mob,_G.Raiding); task.wait()
					until not _G.Raiding or not mob.Parent or mob.Humanoid.Health <= 0
				end
			end
		end
	end
end

FruitTab:AddToggle({Title="Auto Complete Raid",Value=false,Callback=function(I) _G.Raiding = I end})
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			if _G.Raiding then
				if plr.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
					attackNearbyEnemies()
					for _, id in ipairs({5,4,3,2,1}) do
						local island = IsIslandRaid(id)
						if island then
							_tp(island.CFrame * CFrame.new(0,50,0))
							NextIs = true; break
						end
					end
				else NextIs = false end
			end
		end)
	end
end)

FruitTab:AddToggle({Title="Auto Awakening",Value=false,Callback=function(I) _G.Auto_Awakener = I end})
task.spawn(function()
	while task.wait(0.5) do
		if _G.Auto_Awakener then
			pcall(function()
				replicated.Remotes.CommF_:InvokeServer("Awakener","Check")
				replicated.Remotes.CommF_:InvokeServer("Awakener","Awaken")
			end)
		end
	end
end)

FruitTab:AddSection("Devil Fruits")
local J5 = {}
local C5 = {}
pcall(function()
	for _, e in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits",false)) do
		if e.OnSale then table.insert(C5, e.Name) end
	end
	for _, e in pairs(replicated.Remotes.CommF_:InvokeServer("GetFruits",true)) do
		if e.OnSale then table.insert(J5, e.Name) end
	end
end)

FruitTab:AddDropdown({Title="Select Fruit Stock",Options=C5,CurrentOption={},Callback=function(I) _G.SelectFruit = I[1] or I end})
FruitTab:AddButton({Title="Buy Basic Stock",Callback=function() replicated.Remotes.CommF_:InvokeServer("PurchaseRawFruit",_G.SelectFruit) end})
FruitTab:AddDropdown({Title="Select Mirage Fruit",Options=J5,CurrentOption={},Callback=function(I) SelectF_Adv = I[1] or I end})
FruitTab:AddButton({Title="Buy Mirage Stock",Callback=function() replicated.Remotes.CommF_:InvokeServer("PurchaseRawFruit",SelectF_Adv) end})

FruitTab:AddToggle({
	Title="Auto Random Fruit",
	Value=GetSetting("AutoRandomFruit_Save",false),
	Callback=function(I)
		_G.Random_Auto = I
		_G.SaveData["AutoRandomFruit_Save"] = I
		SaveSettings()
	end
})
task.spawn(function()
	while task.wait(0.5) do
		if _G.Random_Auto then pcall(function() replicated.Remotes.CommF_:InvokeServer("Cousin","Buy") end) end
	end
end)

FruitTab:AddToggle({
	Title="Auto Drop Fruit",
	Value=false,
	Callback=function(I) _G.DropFruit = I end
})
task.spawn(function()
	while task.wait(0.5) do
		if _G.DropFruit then pcall(function() DropFruits() end) end
	end
end)

FruitTab:AddToggle({
	Title="Auto Store Fruit",
	Value=GetSetting("AutoStoreFruit_Save",false),
	Callback=function(I)
		_G.StoreF = I
		_G.SaveData["AutoStoreFruit_Save"] = I
		SaveSettings()
	end
})
task.spawn(function()
	while task.wait(0.5) do
		if _G.StoreF then pcall(function() UpdStFruit() end) end
	end
end)

FruitTab:AddToggle({
	Title="Auto Tween to Fruit",
	Value=GetSetting("AutoTweenFruit_Save",false),
	Callback=function(I)
		_G.TwFruits = I
		_G.SaveData["AutoTweenFruit_Save"] = I
		SaveSettings()
	end
})
task.spawn(function()
	while task.wait(0.5) do
		if _G.TwFruits then
			pcall(function()
				for _, e in pairs(workspace:GetChildren()) do
					if e.Name:find("Fruit") then _tp(e.Handle.CFrame) end
				end
			end)
		end
	end
end)

FruitTab:AddToggle({
	Title="Auto Collect Fruit",
	Value=GetSetting("AutoCollectFruit_Save",false),
	Callback=function(I)
		_G.InstanceF = I
		_G.SaveData["AutoCollectFruit_Save"] = I
		SaveSettings()
	end
})
task.spawn(function()
	while task.wait(0.5) do
		if _G.InstanceF then pcall(function() collectFruits(_G.InstanceF) end) end
	end
end)
_G.VolcanicAutoReset   = false;
_G.VolcanicCollectEgg  = false;
_G.VolcanicCollectBone = false;
_G._volcanicPhase      = "idle";
_G.VolcanicSelectedBoat = _G.VolcanicSelectedBoat or "Guardian";

local _V = {};

_V.TIKI_CF         = CFrame.new(-16927.451, 9.086, 433.864);
_V.DRAGON_CF       = CFrame.new(5864.86377, 1209.55066, 812.775024);
_V.JUNGLE_QUEST_CF = CFrame.new(-12680, 389, -9902);
_V.JUNGLE_MOB_CF   = CFrame.new(-11778, 426, -10592);
_V.VSLT_CF         = CFrame.new(4789.29639, 1078.59082, 962.764099);
_V.HYDRA_CF        = CFrame.new(4620.6157, 1002.2954, 399.0868);
_V.SAIL_CF         = CFrame.new(-148073.359, 9.0, 7721.051);
_V.BOAT_SPEED      = 300;

_V.TREE_CFS = {
	CFrame.new(5260.28223, 1004.24329, 347.062622),
	CFrame.new(5237.94775, 1004.24329, 429.596344),
	CFrame.new(5320.87793, 1004.24329, 439.152954),
	CFrame.new(5346.70752, 1004.24329, 359.389008),
};

_V.GOLEM_NAMES = {"Lava Golem","Aura Golem","Stone Golem","Rock Golem"};

local _vTweenPart = nil;
local _vTweenObj  = nil;
local _vMoving    = false;
local _vHB        = nil;

local function _vEnsureHB()
	if _vHB then return; end;
	if not _vTweenPart or not _vTweenPart.Parent then
		local p = Instance.new("Part");
		p.Name="__VP"; p.Size=Vector3.new(1,1,1); p.Anchored=true;
		p.CanCollide=false; p.CanTouch=false; p.Transparency=1; p.Parent=workspace;
		_vTweenPart = p;
	end;
	local plr = game.Players.LocalPlayer;
	_vHB = game:GetService("RunService").Heartbeat:Connect(function()
		if not _vMoving then return; end;
		pcall(function()
			local ch = plr.Character; if not ch then return; end;
			local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return; end;
			if _vTweenPart and _vTweenPart.Parent then
				hrp.CFrame = _vTweenPart.CFrame;
			end;
		end);
	end);
end;

local function _vStopTween()
	_vMoving = false;
	if _vTweenObj then pcall(function() _vTweenObj:Cancel(); end); _vTweenObj = nil; end;
end;

local function _vStartTween(cf)
	shouldTween = false; _G.StopTween = true;
	local plr = game.Players.LocalPlayer;
	local ch  = plr.Character; if not ch then return; end;
	local hrp = ch:FindFirstChild("HumanoidRootPart"); if not hrp then return; end;
	local dist = (cf.Position - hrp.Position).Magnitude; if dist < 3 then return; end;
	_vEnsureHB();
	if _vTweenObj then pcall(function() _vTweenObj:Cancel(); end); _vTweenObj = nil; end;
	_vTweenPart.CFrame = hrp.CFrame;
	local speed = ((_G.Settings and _G.Settings.Setting and tonumber(_G.Settings.Setting["Player Tween Speed"])) or getgenv().TweenSpeedFar or 350);
	local ts = game:GetService("TweenService");
	_vTweenObj = ts:Create(_vTweenPart, TweenInfo.new(math.max(0.1, dist/speed), Enum.EasingStyle.Linear), {CFrame=cf});
	_vMoving = true;
	_vTweenObj:Play();
end;

local function _vWalkTo(cf, thr, timeout)
	thr=thr or 15; timeout=timeout or 90;
	local elapsed=0; local stuckT=0; local lastPos=nil;
	_vStartTween(cf);
	while _G.FullyVolcanicActive do
		task.wait(0.2); elapsed=elapsed+0.2;
		local ch  = game.Players.LocalPlayer.Character;
		local hrp = ch and ch:FindFirstChild("HumanoidRootPart");
		if not hrp then
			task.wait(1); elapsed=elapsed+1;
			_vStartTween(cf); continue;
		end;
		local d = (hrp.Position - cf.Position).Magnitude;
		if d <= thr then _vStopTween(); return true; end;
		if elapsed >= timeout then _vStopTween(); return false; end;
		if lastPos then
			if (hrp.Position - lastPos).Magnitude < 3 then
				stuckT=stuckT+0.2;
				if stuckT >= 1.0 then
					stuckT=0;
					if _vTweenObj then pcall(function() _vTweenObj:Cancel(); end); _vTweenObj=nil; end;
					_vTweenPart.CFrame = hrp.CFrame;
					local speed = ((_G.Settings and _G.Settings.Setting and tonumber(_G.Settings.Setting["Player Tween Speed"])) or getgenv().TweenSpeedFar or 350);
					local dist2 = (cf.Position - hrp.Position).Magnitude;
					local ts = game:GetService("TweenService");
					_vTweenObj = ts:Create(_vTweenPart, TweenInfo.new(math.max(0.1, dist2/speed), Enum.EasingStyle.Linear), {CFrame=cf});
					_vMoving = true;
					_vTweenObj:Play();
				end;
			else stuckT=0; end;
		end;
		lastPos = hrp.Position;
	end;
	_vStopTween(); return false;
end;

local _vBoatTweenObj  = nil;
local _vBoatSyncConn  = nil;
local _vBoatDone      = true;

local function _vStopBoat()
	_vBoatDone = true;
	if _vBoatSyncConn then _vBoatSyncConn:Disconnect(); _vBoatSyncConn=nil; end;
	if _vBoatTweenObj and _vBoatTweenObj.PlaybackState==Enum.PlaybackState.Playing then
		pcall(function() _vBoatTweenObj:Cancel(); end);
	end;
	_vBoatTweenObj=nil;
end;

local function _vLaunchBoatTween(seat, destCF)
	_vStopBoat();
	local dist = (seat.Position - destCF.Position).Magnitude;
	if dist < 30 then return; end;
	local speed = _G.SetSpeedBoat or _G.Settings.SeaEvent["Boat Tween Speed"] or _V.BOAT_SPEED;
	local dest  = CFrame.new(destCF.Position.X, seat.Position.Y, destCF.Position.Z);
	local ts = game:GetService("TweenService");
	local rs = game:GetService("RunService");
	_vBoatDone = false;
	_vBoatTweenObj = ts:Create(seat, TweenInfo.new(dist/speed, Enum.EasingStyle.Linear), {CFrame=dest});
	_vBoatSyncConn = rs.Heartbeat:Connect(function()
		if _vBoatDone then if _vBoatSyncConn then _vBoatSyncConn:Disconnect(); _vBoatSyncConn=nil; end; return; end;
		pcall(function()
			local ch  = game.Players.LocalPlayer.Character;
			local hrp = ch and ch:FindFirstChild("HumanoidRootPart");
			local hum = ch and ch:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;
			hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0);
		end);
	end);
	_vBoatTweenObj:Play();
	_vBoatTweenObj.Completed:Connect(function() _vStopBoat(); end);
end;

local function _vGetMat(name)
	local n=0;
	pcall(function()
		for _, v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v)=="table" and v.Name==name then n=tonumber(v.Count) or 0; break; end;
		end;
	end);
	return n;
end;

local function _vHasItem(name)
	local ok=false;
	pcall(function()
		for _, v in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(v)=="table" and v.Name==name then ok=true; break; end;
		end;
		if not ok then
			if game.Players.LocalPlayer.Backpack:FindFirstChild(name) then ok=true; end;
			local ch=game.Players.LocalPlayer.Character;
			if ch and ch:FindFirstChild(name) then ok=true; end;
		end;
	end);
	return ok;
end;

local function _vSendKey(k)
	local vim = game:GetService("VirtualInputManager");
	pcall(function() vim:SendKeyEvent(true,  k, false, game); task.wait(0.05); vim:SendKeyEvent(false, k, false, game); end);
end;

local function _vUseAllSkills()
	for _, k in pairs({"Z","X","C","V","F"}) do _vSendKey(k); end;
	Attack(); task.wait(0.1);
end;

local function _vUseEquippedSkills(toolTip)
	pcall(function()
		local plr = game.Players.LocalPlayer;
		for _, t in pairs(plr.Backpack:GetChildren()) do
			if t:IsA("Tool") and t.ToolTip==toolTip then
				plr.Character.Humanoid:EquipTool(t);
				for _, k in pairs({"Z","X","C","V","F"}) do _vSendKey(k); end;
				t.Parent = plr.Backpack;
				break;
			end;
		end;
	end);
	Attack(); task.wait(0.1);
end;

local function _vRemoveLava()
	pcall(function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland");
		if not island then return; end;
		local il = island:FindFirstChild("Core") and island.Core:FindFirstChild("InteriorLava");
		if il then il:Destroy(); end;
		for _, obj in pairs(island:GetDescendants()) do
			pcall(function()
				if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.Name:lower():find("lava") then
					obj:Destroy();
				end;
			end);
		end;
		local trial = island:FindFirstChild("TrialTeleport");
		for _, obj in pairs(island:GetDescendants()) do
			pcall(function()
				if obj.Name=="TouchInterest" and not (trial and obj:IsDescendantOf(trial)) then
					obj.Parent:Destroy();
				end;
			end);
		end;
	end);
end;

local function _vGetActiveVolcanoRock()
	local rock = nil;
	pcall(function()
		local vr = workspace.Map.PrehistoricIsland.Core.VolcanoRocks;
		for _, m in pairs(vr:GetChildren()) do
			if m:IsA("Model") then
				local vrock = m:FindFirstChild("volcanorock");
				if vrock and vrock:IsA("MeshPart") then
					local col = vrock.Color;
					if col == Color3.fromRGB(185,53,56) or col == Color3.fromRGB(185,53,57) then
						rock = vrock; return;
					end;
				end;
				local vfx = m:FindFirstChild("VFXLayer");
				local at0 = vfx and vfx:FindFirstChild("At0");
				local glow = at0 and at0:FindFirstChild("Glow");
				if glow and glow.Enabled then rock = vfx; return; end;
			end;
		end;
	end);
	return rock;
end;

local function _vGetGolem()
	for _, name in pairs(_V.GOLEM_NAMES) do
		for _, v in pairs(workspace.Enemies:GetChildren()) do
			if v.Name==name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
				return v;
			end;
		end;
	end;
	return nil;
end;

local function _vBuyBoat()
	local boatName = _G.VolcanicSelectedBoat or "Guardian";
	if workspace.Boats:FindFirstChild(boatName) then return; end;
	_vStopTween(); shouldTween=false; _G.StopTween=true; task.wait(0.1);
	local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
	if hrp and (hrp.Position - _V.TIKI_CF.Position).Magnitude > 80 then
		hrp.CFrame = _V.TIKI_CF; task.wait(0.5);
	end;
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boatName);
	task.wait(2);
end;

local function _vSailToIsland(timeout)
	timeout = timeout or 700;
	_vStopBoat(); _vStopTween(); shouldTween=false; _G.StopTween=true; task.wait(0.1);
	local boatName  = _G.VolcanicSelectedBoat or "Guardian";
	local elapsed   = 0;
	local stuckT    = 0;
	local lastBPos  = nil;

	while _G.FullyVolcanicActive
		and not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")
		and elapsed < timeout do
		task.wait(1); elapsed=elapsed+1;
		pcall(function()
			local ch   = game.Players.LocalPlayer.Character;
			local hrp  = ch and ch:FindFirstChild("HumanoidRootPart");
			local hum  = ch and ch:FindFirstChildOfClass("Humanoid");
			if not hrp or not hum then return; end;
			local boat = workspace.Boats:FindFirstChild(boatName);
			if not boat then
				_vStopBoat();
				if (hrp.Position - _V.TIKI_CF.Position).Magnitude > 300 then hrp.CFrame = _V.TIKI_CF; task.wait(0.5); end;
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boatName);
				task.wait(2); return;
			end;
			local seat = boat:FindFirstChildWhichIsA("VehicleSeat") or boat:FindFirstChild("VehicleSeat");
			if not seat then return; end;
			pcall(function() seat.MaxSpeed=_G.SetSpeedBoat or _G.Settings.SeaEvent["Boat Tween Speed"] or _V.BOAT_SPEED; seat.Torque=20; seat.TurnSpeed=8; end);
			if not hum.Sit then
				_vStopBoat();
				hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0); task.wait(0.5);
				hrp.CFrame = seat.CFrame * CFrame.new(0, 1.5, 0); task.wait(0.5);
			else
				if _vBoatDone then _vLaunchBoatTween(seat, _V.SAIL_CF); end;
				local bPos = seat.Position;
				if lastBPos then
					if (bPos - lastBPos).Magnitude < 3 then
						stuckT=stuckT+1;
						if stuckT >= 4 then stuckT=0; _vStopBoat(); _vLaunchBoatTween(seat, _V.SAIL_CF); end;
					else stuckT=0; end;
				end;
				lastBPos = bPos;
			end;
		end);
	end;
	_vStopBoat();
end;

local function _vBackToDojo()
	local ok=false;
	pcall(function()
		for _, grp in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
			local function checkText(t)
				if t and (t:find("Head back to the Dojo") or t:find("Task completed")) then ok=true; end;
			end;
			if grp.Name=="NotificationTemplate" then
				checkText(grp.Text);
				for _, n in pairs(grp:GetChildren()) do if n.Text then checkText(n.Text); end; end;
			end;
			for _, n in pairs(grp:GetChildren()) do if n.Text then checkText(n.Text); end; end;
		end;
	end);
	return ok;
end;

local function _vCheckQuestText()
	local text="";
	pcall(function()
		local res = game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter"):InvokeServer({Context="Check"});
		if res then
			for k,v in pairs(res) do if k=="Text" then text=tostring(v); break; end; end;
		end;
	end);
	return text;
end;

local function _vIsOnQuest()
	local t = _vCheckQuestText();
	return t:find("Venomous") or t:find("Hydra") or t:find("Destroy") or t:find("tree");
end;

local function _vRequestQuest()
	_vWalkTo(_V.DRAGON_CF, 20, 40);
	task.wait(0.5);
	pcall(function()
		game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter"):InvokeServer({Context="RequestQuest"});
	end);
	task.wait(1);
end;

local function _vStage1_ScrapMetal()
	local _vBringActive = true;
	task.spawn(function()
		while _G.FullyVolcanicActive and _vBringActive do
			pcall(function()
				_B = true;
				BringEnemy();
			end);
			task.wait(0.5);
		end;
	end);
	while _G.FullyVolcanicActive and _vGetMat("Scrap Metal") < 10 do
		pcall(function()
			local plr = game.Players.LocalPlayer;
			local qv  = false;
			pcall(function() qv = plr.PlayerGui.Main.Quest.Visible; end);
			if not qv then
				_vWalkTo(_V.JUNGLE_QUEST_CF, 25, 35);
				task.wait(0.4);
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest");
				task.wait(0.3);
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest","DeepForestIsland2",1);
				task.wait(0.5);
			else
				local found=false;
				for _, v in pairs(workspace.Enemies:GetChildren()) do
					if not _G.FullyVolcanicActive then break; end;
					if v.Name=="Jungle Pirate" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						found=true;
						_vWalkTo(v.HumanoidRootPart.CFrame * CFrame.new(0,5,0), 12, 8);
						repeat
							if not _G.FullyVolcanicActive then break; end;
							task.wait(0.15);
							AutoHaki();
							EquipWeapon(_G.Settings.Main["Selected Weapon"]);
							pcall(function() v.Humanoid.WalkSpeed=0; v.HumanoidRootPart.CanCollide=false; end);
							Attack();
						until not _G.FullyVolcanicActive or not v.Parent or v.Humanoid.Health<=0 or _vGetMat("Scrap Metal")>=10;
						break;
					end;
				end;
				if not found then _vWalkTo(_V.JUNGLE_MOB_CF, 30, 20); end;
			end;
		end);
		task.wait(0.3);
	end;
	_vBringActive = false;
end;

local function _vStage2_BlazeEmber()

	local DRAGON_POS = CFrame.new(5864.86377, 1209.55066, 812.775024,
		0.879059196, 0.00000000381980803, 0.476712614,
		-0.0000000131110456, 1, 0.0000000161639893,
		-0.476712614, -0.0000000204593036, 0.879059196);
	local VSLT_POS   = CFrame.new(4789.29639, 1078.59082, 962.764099);
	local HYDRA_POS  = CFrame.new(4620.6157, 1002.2954, 399.0868);
	local SKY_HEIGHT = _G.Settings.Setting and _G.Settings.Setting["Farm Distance"] or 52;
	local VIM        = game:GetService("VirtualInputManager");

	local function _sk(k) pcall(function() VIM:SendKeyEvent(true,k,false,game); task.wait(0.05); VIM:SendKeyEvent(false,k,false,game); end); end;

	local function _equipAndSpam(toolTip)
		local plr = game.Players.LocalPlayer;
		local char = plr.Character; if not char then return; end;
		local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return; end;
		for _, t in pairs(plr.Backpack:GetChildren()) do
			if t:IsA("Tool") and t.ToolTip == toolTip then
				hum:EquipTool(t); task.wait(0.1);
				for _, k in pairs({"Z","X","C","V","F"}) do _sk(k); end;
				task.wait(0.1);
				break;
			end;
		end;
	end;

	local function _goToMobHeight(mobHRP)
		local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if not myHRP then return; end;
		local skyTarget = mobHRP.CFrame * CFrame.new(0, SKY_HEIGHT, 0);
		local dist = (myHRP.Position - skyTarget.Position).Magnitude;
		if dist > 8 then
			_vStartTween(skyTarget);
			local t = 0;
			while _G.FullyVolcanicActive and t < 10 do
				task.wait(0.15); t = t + 0.15;
				myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if myHRP and (myHRP.Position - skyTarget.Position).Magnitude <= 12 then break; end;
			end;
		end;
	end;

	local function _getQuestText()
		local text = "";
		pcall(function()
			local RF  = game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter");
			local res = RF:InvokeServer({Context = "Check"});
			if res then for k,v in pairs(res) do if k=="Text" then text=tostring(v); break; end; end; end;
		end);
		return text;
	end;

	local function _requestAndGetQuest()
		local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if myHRP and (myHRP.Position - DRAGON_POS.Position).Magnitude > 25 then
			_vWalkTo(DRAGON_POS, 20, 40);
		end;
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Modules.Net:WaitForChild("RF/DragonHunter"):InvokeServer({Context="RequestQuest"});
		end);
		local qt = ""; local tries = 0;
		while tries < 20 and _G.FullyVolcanicActive do
			task.wait(0.4);
			qt = _getQuestText();
			if qt:find("Venomous") or qt:find("Hydra") or qt:find("Destroy") or qt:find("tree") then break; end;
			tries = tries + 1;
		end;
		return qt;
	end;

	local function _backToDojo()
		local ok = false;
		pcall(function()
			for _, grp in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
				local function chk(t) if t and (t:find("Head back to the Dojo") or t:find("Task completed")) then ok=true; end; end;
				if grp.Name=="NotificationTemplate" then chk(grp.Text); end;
				for _, n in pairs(grp:GetChildren()) do if n.Text then chk(n.Text); end; end;
			end;
		end);
		return ok;
	end;

	local function _collectEmber()
		local t = 0;
		while _G.FullyVolcanicActive and t < 25 do
			local et = workspace:FindFirstChild("EmberTemplate") or workspace:FindFirstChild("AttachedAzureEmber");
			local part = et and et:FindFirstChild("Part");
			if part then
				_vStopTween();
				local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if hrp then hrp.CFrame = part.CFrame; end;
				task.wait(0.5); return;
			end;
			task.wait(0.5); t = t + 0.5;
		end;
	end;

	local function _killMob(mobName, spawnCF)
		local elapsed = 0;
		while _G.FullyVolcanicActive and not _backToDojo() and elapsed < 90 do
			elapsed = elapsed + 0.1;
			local mob = nil;
			local bestDist = math.huge;
			for _, v in pairs(workspace.Enemies:GetChildren()) do
				if v.Name == mobName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					local d = myHRP and (v.HumanoidRootPart.Position - myHRP.Position).Magnitude or 0;
					if d < bestDist then bestDist = d; mob = v; end;
				end;
			end;
			if mob then
				_goToMobHeight(mob.HumanoidRootPart);
				repeat
					if not _G.FullyVolcanicActive or _backToDojo() then break; end;
					task.wait(0.1);
					AutoHaki();
					pcall(function()
						mob.Humanoid.WalkSpeed = 0;
						mob.HumanoidRootPart.CanCollide = false;
						mob.HumanoidRootPart.Size = Vector3.new(1,1,1);
					end);
					pcall(function() sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge); end);
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					Attack();
					pcall(function()
						local head = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart");
						AttackModule:AttackEnemy(head, {});
					end);
				until not _G.FullyVolcanicActive
					or not mob.Parent
					or mob.Humanoid.Health <= 0
					or _backToDojo();
			else
				_vWalkTo(spawnCF, 25, 8);
				task.wait(0.3);
			end;
			task.wait(0.05);
		end;
	end;

	local function _destroyTrees()
		local elapsed = 0;
		while _G.FullyVolcanicActive and not _backToDojo() and elapsed < 120 do
			elapsed = elapsed + 0.3;
			local bamboo = nil;
			pcall(function() bamboo = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true); end);
			local treePos = bamboo and bamboo.CFrame or nil;
			if not treePos then
				for _, cf in pairs(_V.TREE_CFS) do
					if not _G.FullyVolcanicActive or _backToDojo() then break; end;
					_vWalkTo(cf, 8, 10);
					task.wait(0.1);
					for _, tip in pairs({"Blox Fruit","Melee","Sword","Gun"}) do
						if _backToDojo() then break; end;
						_equipAndSpam(tip);
						task.wait(2);
					end;
				end;
				task.wait(0.2);
			else
				_vWalkTo(treePos, 8, 10);
				task.wait(0.1);
				local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if myHRP and (myHRP.Position - treePos.Position).Magnitude <= 200 then
					for _, tip in pairs({"Blox Fruit","Melee","Sword","Gun"}) do
						if not _G.FullyVolcanicActive or _backToDojo() then break; end;
						_equipAndSpam(tip);
						task.wait(2);
					end;
				end;
			end;
			task.wait(0.2);
		end;
	end;

	local _vBlazeBringActive = true;
	task.spawn(function()
		while _G.FullyVolcanicActive and _vBlazeBringActive do
			pcall(function()
				_B = true;
				BringEnemy();
			end);
			task.wait(0.5);
		end;
	end);

	while _G.FullyVolcanicActive and _vGetMat("Blaze Ember") < 15 do

		local qt = _getQuestText();
		local hasQuest = qt:find("Venomous") or qt:find("Hydra") or qt:find("Destroy") or qt:find("tree");
		if not hasQuest then qt = _requestAndGetQuest(); end;

		if qt:find("Venomous Assailant") then
			_killMob("Venomous Assailant", VSLT_POS);
		elseif qt:find("Hydra Enforcer") then
			_killMob("Hydra Enforcer", HYDRA_POS);
		elseif qt:find("Destroy") or qt:find("tree") then
			_destroyTrees();
		end;

		if _backToDojo() then
			_vStopTween();
			local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			if hrp and (hrp.Position - DRAGON_POS.Position).Magnitude > 25 then hrp.CFrame = DRAGON_POS; end;
			task.wait(0.8);
			_collectEmber();
			task.wait(0.8);
		end;

		task.wait(0.2);
	end;
	_vBlazeBringActive = false;
end;

local function _vStage3_CraftMagnet()
	local DRAGON_NPC_CF = CFrame.new(5864.86377, 1209.55066, 812.775024);
	_vWalkTo(DRAGON_NPC_CF, 18, 45);
	local t2 = 0;
	while _G.FullyVolcanicActive and t2 < 5 do
		local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if hrp and (hrp.Position - DRAGON_NPC_CF.Position).Magnitude <= 25 then break; end;
		task.wait(0.5); t2 = t2 + 0.5;
	end;
	task.wait(0.8);
	local tries = 0;
	repeat
		tries = tries + 1;
		pcall(function()
			local args = {[1]="CraftItem",[2]="Craft",[3]="Volcanic Magnet"};
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args));
		end);
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Modules.Net:WaitForChild("RF/Craft"):InvokeServer("PossibleHardcode","Volcanic Magnet");
		end);
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Modules.Net:WaitForChild("RF/Craft"):InvokeServer("Craft","Volcanic Magnet",{});
		end);
		task.wait(0.5);
		pcall(function()
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CraftItem","Craft","Volcanic Magnet");
		end);
		task.wait(1);
	until _vHasItem("Volcanic Magnet") or tries >= 12 or not _G.FullyVolcanicActive;
end;

local function _vStage4_GoToIsland()
	_vStopBoat(); task.wait(0.5);
	pcall(function()
		local ch  = game.Players.LocalPlayer.Character;
		local hum = ch and ch:FindFirstChildOfClass("Humanoid");
		if hum and hum.Sit then
			local attempts = 0;
			repeat
				attempts = attempts + 1;
				hum.Jump = true; task.wait(0.3);
				hum.Jump = true; task.wait(0.4);
				ch  = game.Players.LocalPlayer.Character;
				hum = ch and ch:FindFirstChildOfClass("Humanoid");
				if not hum or not hum.Sit then break; end;
				if attempts >= 4 then
					local hrp2 = ch:FindFirstChild("HumanoidRootPart");
					if hrp2 then hrp2.CFrame = hrp2.CFrame * CFrame.new(0, 5, 0); end;
				end;
			until (not hum or not hum.Sit) or attempts >= 10;
		end;
	end);
	task.wait(0.8);
	local loc = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island");
	if loc then
		local head = loc:FindFirstChild("HeadTeleport",true) or loc:FindFirstChild("Teleport_Head",true) or loc:FindFirstChild("Head",true);
		local target;
		if head then
			target = CFrame.new(head.CFrame.Position + Vector3.new(0,3,0));
		else
			target = CFrame.new(loc.Position + Vector3.new(0,8,0));
		end;
		_vWalkTo(target, 35, 90);
	end;
end;

local function _vStage5_Raid()
	local raidStart  = os.time();
	local islandDone = false;
	local VIM  = game:GetService("VirtualInputManager");
	local plr  = game.Players.LocalPlayer;
	local RE   = game.ReplicatedStorage;

	local function _sk(k)
		pcall(function()
			VIM:SendKeyEvent(true, k, false, game);
			task.wait(0.04);
			VIM:SendKeyEvent(false, k, false, game);
		end);
	end;

	local function _hasTool(name)
		if plr.Backpack:FindFirstChild(name) then return true; end;
		local ch = plr.Character; return ch and ch:FindFirstChild(name) ~= nil;
	end;

	local function _equipTool(name)
		local ch  = plr.Character; if not ch then return false; end;
		local hum = ch:FindFirstChildOfClass("Humanoid"); if not hum then return false; end;
		if ch:FindFirstChild(name) then return true; end;
		local t = plr.Backpack:FindFirstChild(name);
		if t then hum:EquipTool(t); task.wait(0.06); return true; end;
		return false;
	end;

	local function _spamToolSkills(name)
		if not _hasTool(name) then return; end;
		_equipTool(name);
		for _, k in ipairs({"Z","X","C","V","F"}) do _sk(k); end;
		task.wait(0.04);
	end;

	local function _spamAllWeapons()
		for _, tip in ipairs({"Blox Fruit","Melee","Sword","Gun"}) do
			local ch = plr.Character; if not ch then break; end;
			local hum = ch:FindFirstChildOfClass("Humanoid"); if not hum then break; end;
			for _, t in ipairs(plr.Backpack:GetChildren()) do
				if t:IsA("Tool") and t.ToolTip == tip then
					hum:EquipTool(t); task.wait(0.04);
					for _, k in ipairs({"Z","X","C","V","F"}) do _sk(k); end;
					task.wait(0.04); break;
				end;
			end;
		end;
		if _hasTool("Skull Guitar") then
			_equipTool("Skull Guitar");
			_sk("Z"); _sk("X"); task.wait(0.04);
		end;
		if _hasTool("Dragon Storm") then
			_equipTool("Dragon Storm");
			_sk("Z"); _sk("X"); task.wait(0.04);
		end;
		Attack();
	end;

	local function _getAllActiveRocks()
		local rocks = {};
		pcall(function()
			local vr = workspace.Map.PrehistoricIsland.Core.VolcanoRocks;
			for _, m in ipairs(vr:GetChildren()) do
				if not m:IsA("Model") then continue; end;
				local vrock = m:FindFirstChild("volcanorock");
				if vrock and vrock:IsA("MeshPart") then
					local col = vrock.Color;
					if col == Color3.fromRGB(185,53,56) or col == Color3.fromRGB(185,53,57) then
						table.insert(rocks, vrock);
					end;
				end;
				local vfx  = m:FindFirstChild("VFXLayer");
				local at0  = vfx and vfx:FindFirstChild("At0");
				local glow = at0 and at0:FindFirstChild("Glow");
				if glow and glow.Enabled then
					table.insert(rocks, vfx);
				end;
			end;
		end);
		return rocks;
	end;

	local function _getNearestRock(hrp)
		local rocks = _getAllActiveRocks();
		if #rocks == 0 then return nil; end;
		local best, bestD = rocks[1], math.huge;
		for _, r in ipairs(rocks) do
			local d = (r.Position - hrp.Position).Magnitude;
			if d < bestD then bestD = d; best = r; end;
		end;
		return best;
	end;

	local function _getAllGolems()
		local golems = {};
		for _, name in ipairs(_V.GOLEM_NAMES) do
			for _, v in ipairs(workspace.Enemies:GetChildren()) do
				if v.Name == name and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
					table.insert(golems, v);
				end;
			end;
		end;
		return golems;
	end;

	local function _tweenTo(cf, thr)
		thr = thr or 10;
		_vStartTween(cf);
		local t = 0;
		repeat
			task.wait(0.1); t = t + 0.1;
			local hrp2 = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if hrp2 and (hrp2.Position - cf.Position).Magnitude <= thr then break; end;
		until t > 6 or not _G.FullyVolcanicActive or islandDone;
		_vStopTween();
	end;

	local function _removeLava()
		pcall(function()
			local island = workspace.Map:FindFirstChild("PrehistoricIsland");
			if not island then return; end;
			local il = island.Core:FindFirstChild("InteriorLava");
			if il then il:Destroy(); end;
			for _, obj in ipairs(island:GetDescendants()) do
				pcall(function()
					if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.Name:lower():find("lava") then obj:Destroy(); end;
				end);
			end;
			local trial = island:FindFirstChild("TrialTeleport");
			for _, obj in ipairs(island:GetDescendants()) do
				pcall(function()
					if obj.Name == "TouchInterest" and not (trial and obj:IsDescendantOf(trial)) then obj.Parent:Destroy(); end;
				end);
			end;
		end);
	end;

	local function _killGolemNow(golem)
		if not golem or not golem.Parent then return; end;
		pcall(function()
			golem.Humanoid.WalkSpeed   = 0;
			golem.HumanoidRootPart.CanCollide = false;
			golem.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
		end);
		pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge); end);
		AutoHaki();
		EquipWeapon(_G.Settings.Main["Selected Weapon"]);
		local head = golem:FindFirstChild("Head") or golem:FindFirstChild("HumanoidRootPart");
		local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if hrp then
			hrp.CFrame = golem.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
		end;
		for _ = 1, 12 do
			if not golem.Parent or golem.Humanoid.Health <= 0 then break; end;
			pcall(function()
				if golem:FindFirstChild("HumanoidRootPart") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					plr.Character.HumanoidRootPart.CFrame = golem.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
					plr.Character.HumanoidRootPart.Velocity = Vector3.zero;
				end;
				golem.Humanoid.WalkSpeed = 0;
				golem.HumanoidRootPart.CanCollide = false;
			end);
			pcall(function() AttackModule:AttackEnemy(head, {}); end);
			if G and G.Kill then G.Kill(golem, true); end;
			_spamAllWeapons();
			task.wait(0.07);
		end;
	end;

	task.wait(1);
	pcall(function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland");
		if not island then return; end;
		local core = island:FindFirstChild("Core");
		local act  = core and (core:FindFirstChild("ActivationPrompt") or core:FindFirstChild("ActivationPrompt", true));
		if act then
			local pp = act:FindFirstChildOfClass("ProximityPrompt") or act:FindFirstChild("ProximityPrompt");
			if pp then
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if hrp and (hrp.Position - act.CFrame.Position).Magnitude > 120 then
					_tweenTo(act.CFrame, 20);
				end;
				fireproximityprompt(pp, math.huge);
				task.wait(0.5);
			end;
		end;
	end);
	task.wait(2);

	local _golemKillConn = workspace.Enemies.ChildAdded:Connect(function(child)
		if islandDone or not _G.FullyVolcanicActive then return; end;
		for _, name in ipairs(_V.GOLEM_NAMES) do
			if child.Name == name then
				task.spawn(function()
					task.wait(0.2);
					_killGolemNow(child);
				end);
				break;
			end;
		end;
	end);

	task.spawn(function()
		while _G.FullyVolcanicActive and not islandDone do
			_removeLava();
			task.wait(0.3);
		end;
	end);

	task.spawn(function()
		while _G.FullyVolcanicActive and not islandDone do
			pcall(function()
				local golems = _getAllGolems();
				for _, golem in ipairs(golems) do
					if not _G.FullyVolcanicActive or islandDone then break; end;
					pcall(function()
						golem.Humanoid.WalkSpeed = 0;
						golem.HumanoidRootPart.CanCollide = false;
					end);
					pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge); end);
					local head = golem:FindFirstChild("Head") or golem:FindFirstChild("HumanoidRootPart");
					pcall(function() AttackModule:AttackEnemy(head, {}); end);
					_spamAllWeapons();
				end;
			end);
			task.wait(0.15);
		end;
	end);

	while _G.FullyVolcanicActive and not islandDone do
		pcall(function()
			local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
			if not hrp then return; end;

			local rock = _getNearestRock(hrp);
			if rock then
				local dist = (hrp.Position - rock.Position).Magnitude;
				if dist > 12 then
					_tweenTo(CFrame.new(rock.Position), 10);
				end;
				hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
				if hrp and (hrp.Position - rock.Position).Magnitude <= 120 then
					AutoHaki();
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					_spamAllWeapons();
					pcall(function() AttackModule:AttackEnemy(rock, {}); end);
				end;
			else
				local golems = _getAllGolems();
				if #golems > 0 then
					local golem = golems[1];
					local nearest = golem;
					local nearestD = math.huge;
					for _, g in ipairs(golems) do
						local d = (g.HumanoidRootPart.Position - hrp.Position).Magnitude;
						if d < nearestD then nearestD = d; nearest = g; end;
					end;
					golem = nearest;
					pcall(function() golem.Humanoid.WalkSpeed=0; golem.HumanoidRootPart.CanCollide=false; golem.HumanoidRootPart.Size=Vector3.new(50,50,50); end);
					pcall(function() sethiddenproperty(plr, "SimulationRadius", math.huge); end);
					PosMon = golem.HumanoidRootPart.Position;
					MonFarm = golem.Name;
					_B = true; BringEnemy();
					hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
					if hrp then
						hrp.CFrame = golem.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0);
						hrp.Velocity = Vector3.zero;
					end;
					AutoHaki();
					EquipWeapon(_G.Settings.Main["Selected Weapon"]);
					_spamAllWeapons();
					local head = golem:FindFirstChild("Head") or golem:FindFirstChild("HumanoidRootPart");
					pcall(function() AttackModule:AttackEnemy(head, {}); end);
					if G and G.Kill then G.Kill(golem, true); end;
				else
					pcall(function()
						local island2 = workspace.Map:FindFirstChild("PrehistoricIsland");
						local trial   = island2 and island2:FindFirstChild("TrialTeleport");
						local skull   = island2 and island2:FindFirstChild("Core")
							and island2.Core:FindFirstChild("PrehistoricRelic")
							and island2.Core.PrehistoricRelic:FindFirstChild("Skull");
						if trial and trial:IsA("BasePart") then
							_vStartTween(CFrame.new(trial.Position + Vector3.new(0,5,0)));
						elseif skull then
							_vStartTween(CFrame.new(skull.Position + Vector3.new(0,5,0)));
						end;
					end);
					task.wait(0.4);
				end;
			end;

			if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and (os.time()-raidStart) > 30 then
				islandDone = true;
			end;
			if (os.time()-raidStart) >= 360 then islandDone = true; end;
		end);
		task.wait(0.1);
	end;

	islandDone = true;
	pcall(function() _golemKillConn:Disconnect(); end);
	_vStopTween();

	pcall(function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland");
		local trial  = island and island:FindFirstChild("TrialTeleport");
		local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
		if hrp and trial and trial:IsA("BasePart") then
			hrp.CFrame = CFrame.new(trial.Position + Vector3.new(0,6,0));
		end;
	end);
	task.wait(1);

	if _G.VolcanicCollectEgg and _G.FullyVolcanicActive then
		Library:Notify({Title="Volcanic Kaitun", Content="Coletando Dragon Egg...", Icon="egg", Duration=4});
		local et=0; local eggDone=false;
		while _G.FullyVolcanicActive and et<40 and not eggDone do
			pcall(function()
				local island = workspace.Map:FindFirstChild("PrehistoricIsland");
				local se = island and island:FindFirstChild("Core") and island.Core:FindFirstChild("SpawnedDragonEggs");
				if se then
					local eggs = se:GetChildren();
					if #eggs > 0 then
						local egg = eggs[1];
						if egg:IsA("Model") then
							local molten = egg:FindFirstChild("Molten");
							local pp = molten and (molten:FindFirstChildOfClass("ProximityPrompt") or molten:FindFirstChild("ProximityPrompt"));
							if molten then
								local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
								if hrp then hrp.CFrame = molten.CFrame; end;
								task.wait(0.3);
								if pp then fireproximityprompt(pp, 30); end;
								pcall(function()
									RE.Modules.Net["RE/CollectedDragonEgg"]:FireServer();
								end);
								pcall(function() VIM:SendKeyEvent(true,"E",false,game); task.wait(1); VIM:SendKeyEvent(false,"E",false,game); end);
								task.wait(0.5); eggDone = true;
							end;
						end;
					end;
				end;
			end);
			task.wait(1); et = et + 1;
		end;
	end;

	if _G.VolcanicCollectBone and _G.FullyVolcanicActive then
		Library:Notify({Title="Volcanic Kaitun", Content="Coletando Dino Bones...", Icon="box", Duration=4});
		local bt=0;
		while _G.FullyVolcanicActive and bt<30 do
			pcall(function()
				for _, v in ipairs(workspace:GetDescendants()) do
					if v:IsA("BasePart") and v.Name=="DinoBone" then
						local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart");
						if hrp then hrp.CFrame = CFrame.new(v.Position); end;
						task.wait(0.3);
					end;
				end;
			end);
			task.wait(1); bt = bt + 1;
		end;
	end;
end;

local _volcanicMainLoop;
_volcanicMainLoop = function()
	while _G.FullyVolcanicActive do

		local hasMagnet = _vHasItem("Volcanic Magnet");

		if not hasMagnet then
			_G._volcanicPhase = "scrap";
			if _vGetMat("Scrap Metal") < 10 then
				Library:Notify({Title="Volcanic Kaitun", Content="[1/9] Farmando Scrap Metal (".. _vGetMat("Scrap Metal") .."/10)...", Icon="pickaxe", Duration=4});
				local scrapTries = 0;
				while _G.FullyVolcanicActive and _vGetMat("Scrap Metal") < 10 and scrapTries < 6 do
					_vStage1_ScrapMetal(); scrapTries = scrapTries + 1; task.wait(0.5);
				end;
			end;
			if not _G.FullyVolcanicActive then break; end;

			_G._volcanicPhase = "blaze";
			if _vGetMat("Blaze Ember") < 15 then
				Library:Notify({Title="Volcanic Kaitun", Content="[2/9] Farmando Blaze Ember (".. _vGetMat("Blaze Ember") .."/15)...", Icon="flame", Duration=4});
				local blazeTries = 0;
				_G.Settings.DragonDojo["Auto Farm Blaze Ember"] = true;
				_G.OnBlzeQuest = false;
				while _G.FullyVolcanicActive and _vGetMat("Blaze Ember") < 15 and blazeTries < 12 do
					_vStage2_BlazeEmber(); blazeTries = blazeTries + 1; task.wait(0.5);
				end;
				_G.Settings.DragonDojo["Auto Farm Blaze Ember"] = false;
				_G.OnBlzeQuest = false;
			end;
			if not _G.FullyVolcanicActive then break; end;

			_G._volcanicPhase = "craft";
			Library:Notify({Title="Volcanic Kaitun", Content="[3/9] Craftando Volcanic Magnet...", Icon="hammer", Duration=4});
			_vStage3_CraftMagnet();
			if not _G.FullyVolcanicActive then break; end;
			hasMagnet = _vHasItem("Volcanic Magnet");
			if not hasMagnet then task.wait(1); continue; end;
			Library:Notify({Title="Volcanic Kaitun", Content="[3/9] Volcanic Magnet craftado!", Icon="check", Duration=3});
		end;

		if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
			_G._volcanicPhase = "sailing";
			Library:Notify({Title="Volcanic Kaitun", Content="[4/9] Indo ate Tiki Outpost e navegando para o Mar 6+...", Icon="anchor", Duration=5});
			_vStopTween();
			shouldTween = false; _G.StopTween = true;
			local boatName = _G.VolcanicSelectedBoat or "Guardian";
			local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			if hrp and (hrp.Position - _V.TIKI_CF.Position).Magnitude > 80 then
				_vWalkTo(_V.TIKI_CF, 30, 60);
			end;
			if not workspace.Boats:FindFirstChild(boatName) then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", boatName);
				task.wait(2);
			end;
			Library:Notify({Title="Volcanic Kaitun", Content="[5/9] Navegando... aguardando spawn da Prehistoric Island...", Icon="ship", Duration=6});
			_vSailToIsland(700);
		end;
		if not _G.FullyVolcanicActive then break; end;

		if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
			Library:Notify({Title="Volcanic Kaitun", Content="[6/9] Prehistoric Island detectada! Indo ate ela via Tween...", Icon="map-pin", Duration=4});
			_G._volcanicPhase = "tweening";
			_vStage4_GoToIsland();
			Library:Notify({Title="Volcanic Kaitun", Content="[7/9] Na ilha! Ativando raid do vulcao...", Icon="zap", Duration=3});
		end;
		if not _G.FullyVolcanicActive then break; end;

		_G._volcanicPhase = "solving";
		Library:Notify({Title="Volcanic Kaitun", Content="[8/9] RAID ATIVA! Fechando buracos + Kill Golems...", Icon="shield", Duration=5});
		_vStage5_Raid();
		if not _G.FullyVolcanicActive then break; end;

		Library:Notify({Title="Volcanic Kaitun", Content="[9/9] FULLY VOLCANIC SOLADO! Aguardando reset...", Icon="trophy", Duration=8});
		_G._volcanicPhase = "resetting";
		if _G.VolcanicAutoReset then
			local t = 0;
			while t < 10 and _G.FullyVolcanicActive and _G.VolcanicAutoReset do task.wait(1); t = t + 1; end;
			if _G.FullyVolcanicActive and _G.VolcanicAutoReset then
				Library:Notify({Title="Volcanic Kaitun", Content="Resetando personagem para novo ciclo...", Icon="refresh-cw", Duration=3});
				pcall(function()
					local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
					if hum then hum.Health = 0; end;
				end);
				task.wait(4.5);
				_G._volcanicPhase = "idle";
			else break; end;
		else
			_G.FullyVolcanicActive = false;
			_G._volcanicPhase = "idle";
			break;
		end;
	end;

	_vStopBoat(); _vStopTween();
	if _vHB then pcall(function() _vHB:Disconnect(); end); _vHB=nil; end;
	shouldTween=false; _G.StopTween=false;
	_G._volcanicPhase = "idle";
	Library:Notify({Title="Volcanic Kaitun", Content="Auto Fully Volcanic desativado.", Icon="x", Duration=4});
end;

MultiFarmTab:AddSection("PRE HISTORIC KAITUN");

MultiFarmTab:AddDropdown({
	Title   = "Boat Selection",
	Desc    = "Barco para navegar ate a Prehistoric Island",
	Options = {"Guardian","Patrol Boat","Speedboat","Upgraded Boat","Cannon Raft"},
	CurrentOption = {_G.VolcanicSelectedBoat or "Guardian"},
	Callback = function(sel)
		_G.VolcanicSelectedBoat = sel[1] or "Guardian";
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Volcanic Selected Boat"] = _G.VolcanicSelectedBoat;
			(getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Fully Volcanic",
	Desc  = "Scrap Metal → Blaze Ember (kill + tree) → Craft Magnet → Navega → Raid → Coleta → Reset.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Fully Volcanic"] or false,
	Callback = function(state)
		_G.FullyVolcanicActive = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Fully Volcanic"] = state; (getgenv()).SaveSetting();
		end;
		if state then
			task.spawn(_volcanicMainLoop);
		else
			_vStopBoat(); _vStopTween();
			if _vHB then pcall(function() _vHB:Disconnect(); end); _vHB=nil; end;
			shouldTween=false; _G.StopTween=false;
			_G._volcanicPhase = "idle";
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Reset After Complete",
	Desc  = "Espera 10s e reseta apos a raid.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Reset After Complete"] or false,
	Callback = function(state)
		_G.VolcanicAutoReset = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Reset After Complete"] = state; (getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Collect Egg",
	Desc  = "Coleta Dragon Egg apos raid.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Collect Egg"] or false,
	Callback = function(state)
		_G.VolcanicCollectEgg = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Collect Egg"] = state; (getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddToggle({
	Title = "Auto Collect Bone",
	Desc  = "Coleta DinoBones apos raid.",
	Value = _G.Settings.Multi and _G.Settings.Multi["Auto Collect Bone"] or false,
	Callback = function(state)
		_G.VolcanicCollectBone = state;
		if _G.Settings and _G.Settings.Multi then
			_G.Settings.Multi["Auto Collect Bone"] = state; (getgenv()).SaveSetting();
		end;
	end
});

MultiFarmTab:AddButton({
	Title = "Remove Lava (Manual)",
	Desc  = "Remove toda a lava da Prehistoric Island agora.",
	Callback = function()
		pcall(function()
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name == "Lava" or v.Name == "LavaPart" then pcall(function() v:Destroy(); end); end;
			end;
			for _, v in pairs(game.ReplicatedStorage:GetDescendants()) do
				if v.Name == "Lava" then pcall(function() v:Destroy(); end); end;
			end;
			local island = workspace.Map:FindFirstChild("PrehistoricIsland");
			if island then
				local il = island:FindFirstChild("Core") and island.Core:FindFirstChild("InteriorLava");
				if il then il:Destroy(); end;
				for _, obj in pairs(island:GetDescendants()) do
					pcall(function()
						if (obj:IsA("Part") or obj:IsA("MeshPart")) and (obj.Name:lower():find("lava") or obj.Name:lower():find("magma")) then
							obj:Destroy();
						end;
					end);
				end;
			end;
		end);
		Library:Notify({Title="Volcanic", Content="Lava removida!", Icon="check", Duration=3});
	end
});

task.spawn(function()
	task.wait(3);
	if _G.Settings.Multi and _G.Settings.Multi["Auto Fully Volcanic"] then
		_G.FullyVolcanicActive = true;
		_G.VolcanicAutoReset   = _G.Settings.Multi["Auto Reset After Complete"] or false;
		_G.VolcanicCollectEgg  = _G.Settings.Multi["Auto Collect Egg"] or false;
		_G.VolcanicCollectBone = _G.Settings.Multi["Auto Collect Bone"] or false;
		task.spawn(_volcanicMainLoop);
	end;
end);

task.spawn(function()
	local plr = game.Players.LocalPlayer;
	plr.CharacterAdded:Connect(function(char)
		if not _G.FullyVolcanicActive then return; end;
		if _G._volcanicPhase == "idle" then return; end;
		task.wait(4);
		if not _G.FullyVolcanicActive then return; end;
		Library:Notify({Title="Volcanic Kaitun", Content="Personagem ressurgiu - retomando ciclo...", Icon="refresh-cw", Duration=4});
		task.spawn(_volcanicMainLoop);
	end);
end);

task.spawn(function()
	while task.wait(1) do
		pcall(function()
			if not _G.VolcanicAutoReset then return; end;
			local island = workspace.Map:FindFirstChild("PrehistoricIsland");
			if not island then return; end;
			local trial = island:FindFirstChild("TrialTeleport");
			if not trial then return; end;
			local eventEnded = trial:FindFirstChild("TouchInterest");
			if not eventEnded then return; end;
			if _G.FullyVolcanicActive then return; end;
			task.wait(4.5);
			local shouldWait = true;
			while shouldWait do
				shouldWait = false;
				if _G.VolcanicCollectEgg then
					local se = island:FindFirstChild("Core") and island.Core:FindFirstChild("SpawnedDragonEggs");
					if se and se:FindFirstChild("DragonEgg") then shouldWait = true; end;
				end;
				if _G.VolcanicCollectBone and workspace:FindFirstChild("DinoBone") then
					shouldWait = true;
				end;
				if shouldWait then task.wait(0.5); end;
			end;
			local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
			if hum then hum.Health = 0; end;
		end);
	end;
end);


MultiFarmTab:AddSection("DUNGEON KAITUN");
_G.Settings.Main = _G.Settings.Main or {};
_G.Settings.Main["Auto Fully Dungeon"] = _G.Settings.Main["Auto Fully Dungeon"] or false;

MultiFarmTab:AddParagraph({
	Title = "Auto Fully Dungeon",
	Desc = "Entra na Dungeon, derrota todos os NPCs de cada Floor (incluindo Kitsune F10 e Gas F15), faz Skip Hub e repete. Funciona apenas na Dungeon World (Place ID: 73902483975735)."
});

local _AutoFullyDungeonToggle = MultiFarmTab:AddToggle({
	Title = "Auto Fully Dungeon",
	Desc = "Liga/desliga o ciclo completo de Dungeon automático.",
	Value = _G.Settings.Main["Auto Fully Dungeon"],
	Callback = function(state)
		_G.Settings.Main["Auto Fully Dungeon"] = state;
		if getgenv().DungeonConfig then
			getgenv().DungeonConfig.AutoFully = state;
			getgenv().DungeonConfig.AutoEnter    = state;
			getgenv().DungeonConfig.AutoComplete = state;
			getgenv().DungeonConfig.AutoSkipHub  = state;
			getgenv().DungeonConfig.SelectBuffs  = state;
		end;
		(getgenv()).SaveSetting();
	end
});

task.spawn(function()
	task.wait(3);
	if _G.Settings.Main["Auto Fully Dungeon"] then
		if getgenv().DungeonConfig then
			getgenv().DungeonConfig.AutoFully   = true;
			getgenv().DungeonConfig.AutoEnter   = true;
			getgenv().DungeonConfig.AutoComplete = true;
			getgenv().DungeonConfig.AutoSkipHub = true;
			getgenv().DungeonConfig.SelectBuffs = true;
		end;
		if _AutoFullyDungeonToggle and _AutoFullyDungeonToggle.SetStage then
			_AutoFullyDungeonToggle.SetStage(true);
		end;
		Library:Notify({Title = "Dungeon", Content = "Auto Fully Dungeon reativado automaticamente!", Icon = "zap", Duration = 4});
	end;
end);

task.spawn(function()
	local _DUNGEON_PID = 73902483975735;
	while true do
		task.wait(1);
		if not _G.Settings.Main["Auto Fully Dungeon"] then continue; end;
		if game.PlaceId ~= _DUNGEON_PID then
			Library:Notify({Title = "Auto Fully Dungeon", Content = "Não está na Dungeon World! Place ID: " .. _DUNGEON_PID, Icon = "alert-triangle", Duration = 5});
			task.wait(10);
			continue;
		end;
		pcall(function()
			if not (workspace:FindFirstChild("DungeonFloor") or workspace:FindFirstChild("FloorEnemies") or workspace:FindFirstChild("DungeonArea")) then
				if #game:GetService("Players"):GetPlayers() < 2 then return; end;
				for _, v in pairs(workspace:GetDescendants()) do
					local name = v.Name:lower();
					if (name:find("portal") or name:find("dungeon") or name:find("enter") or name:find("gate")) and v:IsA("BasePart") then
						TweenPlayer(v.CFrame * CFrame.new(0, 2, 0));
						task.wait(0.8);
						for _, pp in pairs(v:GetDescendants()) do
							if pp:IsA("ProximityPrompt") then pcall(function() fireproximityprompt(pp); end); end;
						end;
						local rep = game:GetService("ReplicatedStorage");
						local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
						if remote then
							pcall(function() remote:InvokeServer("EnterDungeon"); end);
							pcall(function() remote:InvokeServer("JoinDungeon"); end);
						end;
						break;
					end;
				end;
				return;
			end;

			local shrines = {};
			local leaks   = {};
			for _, v in pairs(workspace:GetDescendants()) do
				local name = v.Name:lower();
				if name:find("shrine") or (name:find("kitsune") and name:find("trap")) then
					if v:IsA("BasePart") or v:IsA("Model") then table.insert(shrines, v); end;
				end;
				if name:find("gas") or name:find("leak") then
					if v:IsA("BasePart") or v:IsA("Model") then table.insert(leaks, v); end;
				end;
			end;
			if #shrines > 0 then
				for _, sh in pairs(shrines) do
					local pos = sh:IsA("Model") and sh:GetPivot().Position or sh.Position;
					TweenPlayer(CFrame.new(pos.X, pos.Y + 15, pos.Z));
					task.wait(0.1);
					local vim = game:GetService("VirtualInputManager");
					for _, key in pairs({"Z","X","C","V","F"}) do
						pcall(function() vim:SendKeyEvent(true, key, false, game); task.wait(0.05); vim:SendKeyEvent(false, key, false, game); task.wait(0.03); end);
					end;
				end;
				return;
			end;
			if #leaks > 0 then
				for _, lk in pairs(leaks) do
					local pos = lk:IsA("Model") and lk:GetPivot().Position or lk.Position;
					TweenPlayer(CFrame.new(pos.X, pos.Y + 15, pos.Z));
					task.wait(0.1);
					local vim = game:GetService("VirtualInputManager");
					for _, key in pairs({"Z","X","C","V","F"}) do
						pcall(function() vim:SendKeyEvent(true, key, false, game); task.wait(0.05); vim:SendKeyEvent(false, key, false, game); task.wait(0.03); end);
					end;
				end;
				return;
			end;
			local enemyFolder = workspace:FindFirstChild("FloorEnemies") or workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("DungeonEnemies");
			if enemyFolder then
				for _, v in pairs(enemyFolder:GetChildren()) do
					if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						local hrp = v:FindFirstChild("HumanoidRootPart");
						if hrp then
							EquipWeapon(_G.Settings.Main["Selected Weapon"] or _G.SelectWeapon);
							TweenPlayer(hrp.CFrame * CFrame.new(0, 20, 0));
							task.wait(0.1);
							getgenv().UseConfiguredSkills(hrp.Position);
						end;
						return;
					end;
				end;
			end;
			local rep = game:GetService("ReplicatedStorage");
			local remote = rep:FindFirstChild("CommF_", true) or (rep.Remotes and rep.Remotes:FindFirstChild("CommF_"));
			if remote then
				pcall(function() remote:InvokeServer("NextFloor"); end);
				pcall(function() remote:InvokeServer("AdvanceFloor"); end);
			end;
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("ProximityPrompt") then
					local n = (v.ActionText or v.Name):lower();
					if n:find("next") or n:find("advance") or n:find("continue") or n:find("pass") then
						pcall(function() fireproximityprompt(v); end);
					end;
				end;
			end;

			local plrGui = game.Players.LocalPlayer.PlayerGui;
			for _, gui in pairs(plrGui:GetDescendants()) do
				if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible then
					local t = (gui.Text or ""):lower();
					if t:find("skip") or t:find("lobby") or t:find("return") or t:find("continue") or t:find("next") then
						gui:Activate();
						task.wait(1);
					end;
				end;
			end;
		end);
	end;
end);
ServerTabSection = ServerTab:AddSection("Server");
local _FpsParagraph = ServerTab:AddParagraph({
	Title = "FPS",
	Desc = "0",
	Image = "monitor",
	ImageSize = 20
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			_FpsParagraph:SetDesc(math.floor(workspace:GetRealPhysicsFPS()));
		end);
	end;
end);
local _PingParagraph = ServerTab:AddParagraph({
	Title = "Ping",
	Desc = "0",
	Image = "signal",
	ImageSize = 20
});
task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			_PingParagraph:SetDesc((game:GetService("Stats")).Network.ServerStatsItem["Data Ping"]:GetValueString() .. " ms");
		end);
	end;
end);
RejoinServerButton = ServerTab:AddButton({
	Title = "Rejoin Server",
	Callback = function()
		(game:GetService("TeleportService")):Teleport(game.PlaceId);
	end
});
ServerHopButton = ServerTab:AddButton({
	Title = "Server Hop",
	Callback = function()
		local module = (loadstring(game:HttpGet("https://raw.githubusercontent.com/raw-scriptpastebin/FE/main/Server_Hop_Settings")))();
		module:Teleport(game.PlaceId);
	end
});
JobIdParagraph = ServerTab:AddParagraph({
	Title = "Job ID",
	Desc = game.JobId,
	Buttons = {
		{
			Title = "Copy",
			Callback = function()
				setclipboard(game.JobId);
			end
		}
	}
});
EnterJobIdInput = ServerTab:AddInput({
	Title = "Enter Job ID",
	Callback = function(value)
		_G.JobId = value;
	end
});
JoinJobIdButton = ServerTab:AddButton({
	Title = "Join Job ID",
	Callback = function()
		(game:GetService("TeleportService")):TeleportToPlaceInstance(game.PlaceId, _G.JobId);
	end
});
StatusServerSection = ServerTab:AddSection("Status");
MoonServerParagraph = ServerTab:AddParagraph({
	Title = "Moon Server",
	Desc = "N/A"
});
KitsuneStatusParagraph = ServerTab:AddParagraph({
	Title = "Kitsune Status",
	Desc = "N/A"
});
FrozenStatusParagraph = ServerTab:AddParagraph({
	Title = "Frozen Status",
	Desc = "N/A"
});
MirageStatusParagraph = ServerTab:AddParagraph({
	Title = "Mirage Status",
	Desc = "N/A"
});
HakiDealerStatusParagraph = ServerTab:AddParagraph({
	Title = "Haki Dealer Status",
	Desc = "N/A"
});
PrehistoricStatusParagraph = ServerTab:AddParagraph({
	Title = "Prehistoric Status",
	Desc = "N/A"
});
task.spawn(function()
	while task.wait() do
		pcall(function()
			if (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				MoonServerParagraph:SetDesc("Full Moon 100%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				MoonServerParagraph:SetDesc("Full Moon 75%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				MoonServerParagraph:SetDesc("Full Moon 50%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				MoonServerParagraph:SetDesc("Full Moon 25%");
			elseif (game:GetService("Lighting")).Sky.MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				MoonServerParagraph:SetDesc("Full Moon 15%");
			else
				MoonServerParagraph:SetDesc("Full Moon 0%");
			end;
		end);
	end;
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					KitsuneStatusParagraph:SetDesc("Kitsune Island is Spawning");
				else
					KitsuneStatusParagraph:SetDesc("Kitsune Island Not Spawn");
				end;
			else
				KitsuneStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
					PrehistoricStatusParagraph:SetDesc("Prehistoric Island is Spawning");
				else
					PrehistoricStatusParagraph:SetDesc("Prehistoric Island Not Spawn");
				end;
			else
				PrehistoricStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				FrozenStatusParagraph:SetDesc("Frozen Dimension Spawning");
			else
				FrozenStatusParagraph:SetDesc("Frozen Dimension Not Spawn");
			end;
		end;
	end);
end);
task.spawn(function()
	pcall(function()
		while task.wait(0.2) do
			if World2 or World3 then
				if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					MirageStatusParagraph:SetDesc("Mirage Island is Spawning");
				else
					MirageStatusParagraph:SetDesc("Mirage Island Not Spawn");
				end;
			else
				MirageStatusParagraph:SetDesc("World 3 Only");
			end;
		end;
	end);
end);
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			local response = (((game:GetService("ReplicatedStorage")):WaitForChild("Remotes")):WaitForChild("CommF_")):InvokeServer("ColorsDealer", "1");
			if response then
				HakiDealerStatusParagraph:SetDesc("Master Of Auras Spawning");
			else
				HakiDealerStatusParagraph:SetDesc("Master Of Auras Not Spawn");
			end;
		end);
	end;
end);
local _seaStatusParagraph = ServerTab:AddParagraph({
	Title = "SEA ATUAL",
	Desc = "Detectando..."
});
local _serverTimeParagraph = ServerTab:AddParagraph({
	Title = "TEMPO DE SERVIDOR",
	Desc = "N/A"
});
local _fodStatusParagraph = ServerTab:AddParagraph({
	Title = "FIRST OF DARKNESS",
	Desc = "N/A"
});
local _chaliceStatusParagraph = ServerTab:AddParagraph({
	Title = "GOD CHALICE",
	Desc = "N/A"
});
local _raidBossStatusParagraph = ServerTab:AddParagraph({
	Title = "RAID BOSS",
	Desc = "N/A"
});
local _pirateRaidStatusParagraph = ServerTab:AddParagraph({
	Title = "PIRATES RAID",
	Desc = "N/A"
});
local _factoryStatusParagraph = ServerTab:AddParagraph({
	Title = "FACTORY",
	Desc = "N/A"
});
local _jobIdParagraph = ServerTab:AddParagraph({
	Title = "JOB ID",
	Desc = "Em breve"
});
local _serverStartTime = os.time();
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local elapsed = os.time() - _serverStartTime;
			local mins = math.floor(elapsed / 60);
			local secs = elapsed % 60;
			_serverTimeParagraph:SetDesc(string.format("%02d:%02d ativos", mins, secs));
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(0.5);
		pcall(function()
			if World1 then
				_seaStatusParagraph:SetDesc("SEA 1 (First Sea)");
			elseif World2 then
				_seaStatusParagraph:SetDesc("SEA 2 (Second Sea)");
			elseif World3 then
				_seaStatusParagraph:SetDesc("SEA 3 (Third Sea)");
			else
				_seaStatusParagraph:SetDesc("Sea desconhecido");
			end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local found = false;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("first") and v.Name:lower():find("dark") then
					found = true; break;
				end;
			end;
			_fodStatusParagraph:SetDesc(found and "SPAWNED no servidor!" or "Nao encontrado");
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local found = false;
			for _, v in pairs(workspace:GetDescendants()) do
				if v.Name:lower():find("god") and v.Name:lower():find("chal") then
					found = true; break;
				end;
			end;
			_chaliceStatusParagraph:SetDesc(found and "SPAWNED no servidor!" or "Nao encontrado");
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local raidBossNames = {"Darkbeard", "rip_indra", "Dough King", "Ice Admiral", "Cyborg", "Thunder God"};
			local found = false;
			for _, bossName in pairs(raidBossNames) do
				if workspace.Enemies:FindFirstChild(bossName) then
					found = true;
					_raidBossStatusParagraph:SetDesc("SPAWNED: " .. bossName);
					break;
				end;
			end;
			if not found then _raidBossStatusParagraph:SetDesc("Nenhum Raid Boss ativo"); end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local pirateRaid = workspace:FindFirstChild("PirateRaid") or workspace:FindFirstChild("Pirate Raid") or workspace:FindFirstChild("PiratesRaid");
			if pirateRaid then
				_pirateRaidStatusParagraph:SetDesc("ATIVO no servidor!");
			else
				_pirateRaidStatusParagraph:SetDesc("Inativo");
			end;
		end);
	end;
end);
task.spawn(function()
	while true do
		task.wait(1);
		pcall(function()
			local factory = workspace:FindFirstChild("Factory") or workspace:FindFirstChild("FactoryFortress");
			if factory then
				_factoryStatusParagraph:SetDesc("ATIVO no servidor!");
			else
				_factoryStatusParagraph:SetDesc("Inativo");
			end;
		end);
	end;
end);
getgenv().HoldSkillConfig = {
	["Z"] = true,
	["X"] = true,
	["C"] = true,
	["V"] = false,
	["F"] = false,
	["Melee"] = false,
	["Sword"] = false,
	["Gun"] = false,
}

HoldAndSkillTab:AddSection("Skills Config - Selecione as skills para usar nos farms");

HoldAndSkillTab:AddParagraph({
	Title = "Como funciona",
	Desc = "Selecione abaixo quais teclas/skills serao usadas em TODOS os farms e funcoes do hub que precisam de skills. As combinacoes Z X C Melee, Z X C V F Fruit, Z X Sword e Z X Gun definem grupos rapidos."
});

HoldAndSkillTab:AddToggle({
	Title = "Z X C Melee",
	Desc = "Usa apenas Z, X, C de Melee (Fighting Style)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = true;
			getgenv().HoldSkillConfig["V"] = false;
			getgenv().HoldSkillConfig["F"] = false;
			getgenv().HoldSkillConfig["Melee"] = true;
			getgenv().HoldSkillConfig["Sword"] = false;
			getgenv().HoldSkillConfig["Gun"] = false;
		end
	end
});

HoldAndSkillTab:AddToggle({
	Title = "Z X C V F Fruit",
	Desc = "Usa Z, X, C, V e F de Fruta (Devil Fruit)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = true;
			getgenv().HoldSkillConfig["V"] = true;
			getgenv().HoldSkillConfig["F"] = true;
			getgenv().HoldSkillConfig["Melee"] = false;
			getgenv().HoldSkillConfig["Sword"] = false;
			getgenv().HoldSkillConfig["Gun"] = false;
		end
	end
});

HoldAndSkillTab:AddToggle({
	Title = "Z X Sword",
	Desc = "Usa apenas Z e X de Espada (Sword)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = false;
			getgenv().HoldSkillConfig["V"] = false;
			getgenv().HoldSkillConfig["F"] = false;
			getgenv().HoldSkillConfig["Melee"] = false;
			getgenv().HoldSkillConfig["Sword"] = true;
			getgenv().HoldSkillConfig["Gun"] = false;
		end
	end
});

HoldAndSkillTab:AddToggle({
	Title = "Z X Gun",
	Desc = "Usa apenas Z e X de Arma de Fogo (Gun)",
	Value = false,
	Callback = function(state)
		if state then
			getgenv().HoldSkillConfig["Z"] = true;
			getgenv().HoldSkillConfig["X"] = true;
			getgenv().HoldSkillConfig["C"] = false;
			getgenv().HoldSkillConfig["V"] = false;
			getgenv().HoldSkillConfig["F"] = false;
			getgenv().HoldSkillConfig["Melee"] = false;
			getgenv().HoldSkillConfig["Sword"] = false;
			getgenv().HoldSkillConfig["Gun"] = true;
		end
	end
});

HoldAndSkillTab:AddSection("Skills Individuais");

HoldAndSkillTab:AddToggle({
	Title = "Usar Skill Z",
	Desc = "Ativa o uso da tecla Z nos farms",
	Value = true,
	Callback = function(state)
		getgenv().HoldSkillConfig["Z"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill X",
	Desc = "Ativa o uso da tecla X nos farms",
	Value = true,
	Callback = function(state)
		getgenv().HoldSkillConfig["X"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill C",
	Desc = "Ativa o uso da tecla C nos farms",
	Value = true,
	Callback = function(state)
		getgenv().HoldSkillConfig["C"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill V",
	Desc = "Ativa o uso da tecla V nos farms",
	Value = false,
	Callback = function(state)
		getgenv().HoldSkillConfig["V"] = state;
	end
});
HoldAndSkillTab:AddToggle({
	Title = "Usar Skill F",
	Desc = "Ativa o uso da tecla F nos farms",
	Value = false,
	Callback = function(state)
		getgenv().HoldSkillConfig["F"] = state;
	end
});

getgenv().UseConfiguredSkills = function(targetPosition)
	pcall(function()
		local char = game.Players.LocalPlayer.Character;
		if not char then return end
		local hrp = char:FindFirstChild("HumanoidRootPart");
		if not hrp and targetPosition then
			hrp.CFrame = CFrame.lookAt(hrp.Position, targetPosition);
		end
		local vim = game:GetService("VirtualInputManager");
		local skillsToUse = {};
		if getgenv().HoldSkillConfig["Z"] then table.insert(skillsToUse, "Z") end
		if getgenv().HoldSkillConfig["X"] then table.insert(skillsToUse, "X") end
		if getgenv().HoldSkillConfig["C"] then table.insert(skillsToUse, "C") end
		if getgenv().HoldSkillConfig["V"] then table.insert(skillsToUse, "V") end
		if getgenv().HoldSkillConfig["F"] then table.insert(skillsToUse, "F") end
		for _, key in pairs(skillsToUse) do
			pcall(function()
				vim:SendKeyEvent(true, key, false, game);
				task.wait(0.08);
				vim:SendKeyEvent(false, key, false, game);
				task.wait(0.05);
			end)
		end
	end)
end

task.spawn(function()
	task.wait(4);

	local S = _G.Settings;
	if not S then return; end;

	local function _reactivate(toggle, state)
		if toggle and toggle.SetValue then
			pcall(function() toggle:SetValue(state); end);
		end;
	end;

	if S.Main and S.Main["Auto Farm"] then
		pcall(function() AutoFarmToggle:SetValue(true); end);
	end;

	if S.Multi and S.Multi["Auto Fully Volcanic"] then
		_G.FullyVolcanicActive    = true;
		_G.VolcanicAutoReset      = S.Multi["Auto Reset After Complete"] or false;
		_G.VolcanicCollectEgg     = S.Multi["Auto Collect Egg"] or false;
		_G.VolcanicCollectBone    = S.Multi["Auto Collect Bone"] or false;
		task.spawn(_volcanicMainLoop);
		Library:Notify({Title="Volcanic Kaitun", Content="Auto Fully Volcanic reativado!", Icon="zap", Duration=5});
	end;

	if S.Main and S.Main["Auto Fully Dungeon"] then
		if getgenv().DungeonConfig then
			getgenv().DungeonConfig.AutoFully    = true;
			getgenv().DungeonConfig.AutoEnter    = true;
			getgenv().DungeonConfig.AutoComplete = true;
			getgenv().DungeonConfig.AutoSkipHub  = true;
			getgenv().DungeonConfig.SelectBuffs  = true;
		end;
		pcall(function() _AutoFullyDungeonToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Summon Prehistoric Island"] then
		pcall(function() AutoSummonPrehistoricIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Prehistoric Island"] then
		pcall(function() TweenToPrehistoricIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Kill Lava Golem"] then
		pcall(function() AutoKillLavaGolemToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Summon Frozen Dimension"] then
		pcall(function() AutoSummonFrozenDimensionToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Frozen Dimension"] then
		pcall(function() TweenToFrozenDimensionToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Summon Kitsune Island"] then
		pcall(function() AutoSummonKitsuneIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Kitsune Island"] then
		pcall(function() TweenToKitsuneIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Collect Azure Ember"] then
		pcall(function() AutoCollectAzureEmberToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Trade Azure Ember"] then
		pcall(function() AutoTradeAzureEmberToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Tween To Mirage Island"] then
		pcall(function() TweenToMirageIslandToggle:SetValue(true); end);
	end;

	if S.SeaStack and S.SeaStack["Auto Find Mirage"] then
		_G.FindMirage = true;
	end;

	if S.SeaStack and S.SeaStack["Auto Attack Seabeasts"] then
		pcall(function() AutoAttackSeaBeastsToggle:SetValue(true); end);
	end;

	if S.Farm and S.Farm["Auto Pirate Raid"] then
		pcall(function() AutoPirateRaidToggle:SetValue(true); end);
	end;

	if S.Farm and S.Farm["Auto Factory Raid"] then
		pcall(function() AutoFactoryRaidToggle:SetValue(true); end);
	end;

	if S.SettingSea then
		if S.SettingSea.Lightning then
			pcall(function() LightningToggle:SetValue(true); end);
		end;
		if S.SettingSea["Increase Speed Boat"] then
			pcall(function() IncreaseSpeedBoatToggle:SetValue(true); end);
		end;
		if S.SettingSea["No Clip Rock"] then
			pcall(function() NoClipRockToggle:SetValue(true); end);
		end;
	end;

	if S.Setting then
		if S.Setting["Custom Speed Enabled"] then
			pcall(function() SettingsTab:GetDescendants(); end);
		end;
	end;

	Library:Notify({
		Title   = "TRon Void Hub",
		Content = "Auto Execute completo! Funcoes salvas reativadas.",
		Icon    = "check-circle",
		Duration = 5
	});
end);
-- ===================== SETTINGS TAB =====================
SettingsTab:AddSection("Weapon")
ChooseWeaponDropdown = SettingsTab:AddDropdown({
	Title = "Select Weapon",
	Options = {"Melee","Sword","Blox Fruit","Gun"},
	CurrentOption = {_G.Settings.Main["Select Weapon"] or "Melee"},
	Callback = function(sel)
		_G.SelectWeapon = sel[1] or sel
		_G.Settings.Main["Select Weapon"] = _G.SelectWeapon
		pcall(function() (getgenv()).SaveSetting() end)
	end
})

SettingsTab:AddSection("Farm Settings")
SettingsTab:AddSlider({
	Title = "Farm Distance",
	Min = 0, Max = 100,
	Default = _G.Settings.Setting["Farm Distance"] or 35,
	Callback = function(val)
		_G.Settings.Setting["Farm Distance"] = val
		Pos = CFrame.new(0, val, 0)
		pcall(function() (getgenv()).SaveSetting() end)
	end
})
SettingsTab:AddSlider({
	Title = "Tween Speed",
	Min = 50, Max = 1000,
	Default = _G.Settings.Setting["Player Tween Speed"] or 350,
	Callback = function(val)
		_G.Settings.Setting["Player Tween Speed"] = val
		getgenv().TweenSpeedFar = val
		pcall(function() (getgenv()).SaveSetting() end)
	end
})
SettingsTab:AddToggle({
	Title = "Bring Mob",
	Value = _G.Settings.Setting["Bring Mob"],
	Callback = function(state)
		_G.Settings.Setting["Bring Mob"] = state
		pcall(function() (getgenv()).SaveSetting() end)
	end
})
SettingsTab:AddToggle({
	Title = "Fast Attack",
	Value = _G.Settings.Setting["Fast Attack"],
	Callback = function(state)
		_G.Settings.Setting["Fast Attack"] = state
		pcall(function() (getgenv()).SaveSetting() end)
	end
})

SettingsTab:AddSection("Visual")
SettingsTab:AddToggle({
	Title = "Fix Lag / Low Quality",
	Value = getgenv().FixLagEnabled or false,
	Callback = function(state)
		getgenv().FixLagEnabled = state
	end
})
SettingsTab:AddButton({
	Title = "Reset Settings",
	Callback = function()
		Library:Notify({Title="TRon Void Hub",Content="Settings reset!",Icon="refresh-cw",Duration=3})
	end
})

getgenv().ReadyForGuiLoaded = true

Library:Notify({
	Title   = "TRon Void Hub",
	Content = "Auto Execute completo! Funcoes salvas reativadas.",
	Icon    = "check-circle",
	Duration = 5
})
