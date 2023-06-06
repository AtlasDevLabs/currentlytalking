local startingHeight = 0.01 
local titleColor = '~b~' 
local outerIdColor = '~b~' 
local innerIdColor = '~b~' 
local defaultNameColor = '~b~'
local isTalking = {} 

Citizen.CreateThread(function()
    while true do
        local t = 0
        local activePlayers = GetActivePlayers()
        for _, playerId in ipairs(activePlayers) do
            isTalking[playerId] = NetworkIsPlayerTalking(playerId)
        end
        for _, playerId in ipairs(activePlayers) do
            local playerName = GetPlayerName(playerId)
            if playerName and isTalking[playerId] then
                local name = outerIdColor .. '[' .. innerIdColor .. GetPlayerServerId(playerId) .. outerIdColor .. '] ' .. defaultNameColor .. playerName
                t = t + 1
                if t == 1 then
                    drawTxt2(0.5, startingHeight, 1.1, 1.0, 0.40, titleColor .. "Currently Talking", 255, 255, 255, 255)
                end
                drawTxt2(0.5, startingHeight + (t * 0.030), 1.0704, 1.0, 0.40, name, 255, 255, 255, 255)
            end
        end

        Citizen.Wait(0)
    end
end)

function drawTxt2(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(0)
    SetTextScale(scale, scale)
    SetTextOutline()
    SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
