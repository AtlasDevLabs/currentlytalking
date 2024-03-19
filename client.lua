local startingHeight = 0.01 -- How far it is from top of screen. Limit is 0.10
local titleColor = '~b~' -- Currently Talking Text
local outerIdColor = '~w~' -- [] Brackets 
local innerIdColor = '~w~' -- PlayerID
local defaultNameColor = '~w~' -- PlayerName

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local talkingPlayers = {} -- Store talking players temporarily to avoid multiple loops
        for i = 0, 255 do
            if NetworkIsPlayerActive(i) and NetworkIsPlayerTalking(i) then
                local name = outerIdColor .. '[' .. innerIdColor .. GetPlayerServerId(i) .. outerIdColor .. '] ' .. defaultNameColor .. GetPlayerName(i)
                table.insert(talkingPlayers, name)
            end
        end

        if #talkingPlayers > 0 then
            drawTxt2(0.5, startingHeight, 1.1, 1.0, 0.40, titleColor .. "Currently Talking:", 255, 255, 255, 255)
            for index, playerName in ipairs(talkingPlayers) do
                drawTxt2(0.5, startingHeight + (index * 0.030), 1.0704 + ((string.len(playerName) - 9) * 0.0001), 1.0, 0.40, playerName, 255, 255, 255, 255)
            end
        end
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
