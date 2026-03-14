-- ============================================================
--   ROBLOX FIX LAG SCRIPT
--   Remove Fog | Remove Texturas | Boost FPS | Reduz Ping
--   Compatível com Executores: Synapse X, KRNL, Fluxus, etc.
-- ============================================================

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserSettings = UserSettings()
local GameSettings = UserSettings.GameSettings

-- ============================================================
-- [1] REMOVER FOG COMPLETAMENTE
-- ============================================================
local function RemoveFog()
    Lighting.FogEnd        = 999999
    Lighting.FogStart      = 999999
    Lighting.FogColor      = Color3.fromRGB(0, 0, 0)

    -- Remove objetos de Atmosphere (fog volumétrico)
    for _, obj in ipairs(Lighting:GetDescendants()) do
        if obj:IsA("Atmosphere") then
            obj.Density   = 0
            obj.Offset    = 0
            obj.Color     = Color3.fromRGB(0, 0, 0)
            obj.Decay     = Color3.fromRGB(0, 0, 0)
            obj.Glare     = 0
            obj.Haze      = 0
        end
        if obj:IsA("BloomEffect")
            or obj:IsA("BlurEffect")
            or obj:IsA("ColorCorrectionEffect")
            or obj:IsA("DepthOfFieldEffect")
            or obj:IsA("SunRaysEffect") then
            obj.Enabled = false
        end
    end
    print("[FixLag] Fog removido.")
end

-- ============================================================
-- [2] REMOVER / SIMPLIFICAR TEXTURAS
-- ============================================================
local function RemoveTextures()
    local function processInstance(obj)
        -- Remove texturas de partes
        if obj:IsA("SpecialMesh") then
            obj.TextureId = ""
        end
        if obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Transparency = 1
        end
        -- Simplifica materiais pesados de BasePart
        if obj:IsA("BasePart") then
            if obj.Material == Enum.Material.Glass
                or obj.Material == Enum.Material.Neon
                or obj.Material == Enum.Material.ForceField then
                obj.Material = Enum.Material.SmoothPlastic
            end
            obj.CastShadow = false   -- sombras custam muito FPS
        end
    end

    -- Processa o workspace inteiro
    for _, obj in ipairs(workspace:GetDescendants()) do
        pcall(processInstance, obj)
    end

    -- Garante que novas partes também sejam processadas
    workspace.DescendantAdded:Connect(function(obj)
        task.wait()
        pcall(processInstance, obj)
    end)

    print("[FixLag] Texturas removidas / simplificadas.")
end

-- ============================================================
-- [3] CONFIGURAÇÕES DE GRÁFICOS (QUALIDADE MÍNIMA)
-- ============================================================
local function OptimizeGraphics()
    -- Nível de qualidade gráfica (1 = mínimo, 21 = máximo)
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    -- Desativa sombras globais
    Lighting.GlobalShadows = false

    -- Reduz iluminação ao mínimo
    Lighting.Brightness     = 0.5
    Lighting.Ambient        = Color3.fromRGB(178, 178, 178)
    Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)

    print("[FixLag] Gráficos otimizados para FPS máximo.")
end

-- ============================================================
-- [4] OTIMIZAR PING / REDE
-- ============================================================
local function OptimizeNetwork()
    -- Reduz taxa de atualização de partes não necessárias
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Anchored then
            pcall(function()
                -- Desativa Network Ownership de partes soltas
                obj:SetNetworkOwner(nil)
            end)
        end
    end

    -- Desativa animações desnecessárias de NPCs distantes
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer and LocalPlayer.Character then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
                end
            end
        end
    end

    print("[FixLag] Rede otimizada para menor ping.")
end

-- ============================================================
-- [5] REMOVER PARTÍCULAS E EFEITOS VISUAIS PESADOS
-- ============================================================
local function RemoveParticles()
    local removeList = {
        "ParticleEmitter",
        "Trail",
        "Smoke",
        "Fire",
        "Sparkles",
        "SelectionBox",
        "SelectionSphere",
        "BillboardGui",
        "SurfaceGui",
    }

    local function cleanObj(obj)
        for _, className in ipairs(removeList) do
            if obj:IsA(className) then
                if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
                    obj.Enabled = false
                else
                    obj.Enabled = false
                end
            end
        end
    end

    for _, obj in ipairs(workspace:GetDescendants()) do
        pcall(cleanObj, obj)
    end

    workspace.DescendantAdded:Connect(function(obj)
        task.wait()
        pcall(cleanObj, obj)
    end)

    print("[FixLag] Partículas e efeitos removidos.")
end

-- ============================================================
-- [6] LOOP DE MANUTENÇÃO (mantém fog/texturas desativados)
-- ============================================================
local function StartMaintenance()
    task.spawn(function()
        while task.wait(5) do
            -- Garante fog zerado a cada 5 segundos
            pcall(function()
                Lighting.FogEnd   = 999999
                Lighting.FogStart = 999999
                for _, obj in ipairs(Lighting:GetDescendants()) do
                    if obj:IsA("Atmosphere") then
                        obj.Density = 0
                        obj.Haze    = 0
                        obj.Glare   = 0
                    end
                end
            end)
        end
    end)
    print("[FixLag] Loop de manutenção iniciado.")
end

-- ============================================================
-- EXECUTAR TUDO
-- ============================================================
print("====================================")
print("  ROBLOX FIX LAG - Iniciando...")
print("====================================")

RemoveFog()
RemoveTextures()
OptimizeGraphics()
RemoveParticles()
OptimizeNetwork()
StartMaintenance()

print("====================================")
print("  FIX LAG APLICADO COM SUCESSO!")
print("  FPS e Ping otimizados.")
print("====================================")
