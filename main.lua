local discordia = require("Discordia")
local dbase = require("sqlite3")
local stats = require("monsterDetails")
local stStuff = require("otherCardDetails")

local prefix = "y/"
local client = discordia.Client()

--////////////////////////////////////////////////////////////////////////////
local playerList = {}
local deckList = {}
--///////////////////////////////////////////////////////////////////////////

function stringConverter(cardName)
    local newString = string.gsub(" " .. cardName, "%W%l", string.upper):sub(2)
    return newString
end

client:on("messageCreate", function(message)
    local command = message.content
    local commandPlayer = message.author.username
    if string.sub(command, 1, 2) == prefix and string.sub(command, 3, -1) ~= "" then
        local singleAction = string.sub(command, 3, -1)
        singleAction = string.gsub(singleAction,";","")
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
    end
end
)
