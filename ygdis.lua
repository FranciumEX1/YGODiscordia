local discordia = require("Discordia")
local dbase = require("sqlite3")
local stats = require("monsterDetails")
local stStuff = require("otherCardDetails")

local prefix = "y/"
local playerList = {}
local client = discordia.Client()


--///////////////////////////////////////////////////////////////////////////

function stringConverter(cardName)
    local newString = string.gsub(" " .. cardName, "%W%l", string.upper):sub(2)
    return newString
end

function playerExists(guild, playerName)
    local found = false 
    for player in guild.members:iter() do
        if player.username == playerName then
            found = true
            return found
        end
    end
    return found
end

function playerInGame(playerName)
    local found = false 
    for k, v in ipairs(playerList) do
        if v == playerName then
            found = true
            return found
        end
    end
    return found
end

--/////////////////////////////////////////////////////////////////////////

client:on("ready", function()
    print("Ready to go.")
end
)


client:on("messageCreate", function(message)
    local command = message.content
    local commandPlayer = message.author.username
    if string.sub(command, 1, 2) == prefix and string.sub(command, 3, -1) ~= "" then
        local action = string.sub(command, 3, -1)
        action = string.gsub(action,";","")
        if string.sub(command, 3, 10) == "viewcard" and string.sub(command, 12, -1) ~= "" then
            local cardToFind = stringConverter(string.sub(command, 12, -1))
            cardToFind = string.gsub(cardToFind,";","")
            if stats.doesMonsterExist(cardToFind) == true then
                message.channel:send{
                    embed = {
                        title = stats.cardTitle(cardToFind),
                        description = "Level: " .. stats.getLevel(cardToFind) .. "\n" .. 
                        "Attribute: " .. stats.getAttribute(cardToFind) .. "\n" ..
                        "Sub-Type: " .. stats.getSubType(cardToFind) .. "\n" ..
                        "Attack: " .. stats.getAttack(cardToFind) .. "\n" ..
                        "Defense: " .. stats.getDefense(cardToFind) .. "\n" ..
                        stats.getDescription(cardToFind),
                        image = {
                            url = stats.cardImage(cardToFind)
                        }
                    }
                }
            elseif stStuff.doesSTExist(cardToFind) == true then
                message.channel:send{
                    embed = {
                        title = stStuff.getName(cardToFind),
                        description = stStuff.getDescription(cardToFind),
                        image = {url = stStuff.getImage(cardToFind)}
                    }
                }
            end
        end
        if not playerInGame(commandPlayer) and action == "enter" then
            playerList[#playerList + 1] = commandPlayer
            message.channel:send(
                commandPlayer .. " has entered Yu-Gi-Oh Discordia!"
            )
        end 
        if playerInGame(commandPlayer) then
            --Deck Crafting Actions
            


        end
    end
end
)

client:run("Bot NTE0MTA3NjMyMDM1MDM3MTg0.D1xoqA.htgKVFwGWnc6kYRcr8UIRdv_SOE")
