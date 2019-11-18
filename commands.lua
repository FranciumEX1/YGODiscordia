local discordia = require("Discordia")
local dbase = require("sqlite3")
local monsterStats = require("./monsterDetails")
local otherStats = require("./otherCardDetails")
local stringFuncs = require("./textFunctions")

chatCommands = {}
prefix = "y/"
commandList = {"viewcard"}


chatCommands["viewcard"] = function(message)	
	if string.sub(message.content, 1, 2) ~= prefix then return end
	searchCard = string.sub(stringFuncs.stringConverter(message.content), 3, -1)
	if not monsterStats.doesMonsterExist(searchCard) and not otherStats.doesSTExist(searchCard) then
		message.channel:send("No card by that name found.") 
		return
	elseif monsterStats.doesMonsterExist(searchCard) then
	    message.channel:send{
	        embed = {
	            title = monsterStats.cardTitle(searchCard),
	            description = "Level: " .. monsterStats.getLevel(searchCard) .. "\n" .. 
	            "Attribute: " .. monsterStats.getAttribute(searchCard) .. "\n" ..
	            "Sub-Type: " .. monsterStats.getSubType(searchCard) .. "\n" ..
	            "Attack: " .. monsterStats.getAttack(searchCard) .. "\n" ..
	            "Defense: " .. monsterStats.getDefense(searchCard) .. "\n" ..
	            monsterStats.getDescription(searchCard),
	            image = {
	                url = monsterStats.cardImage(searchCard)
	            }
	        }
	    }
	    return
	elseif otherStats.doesSTExist(searchCard) then
		message.channel:send{
        	embed = {
            	title = otherStats.getName(searchCard),
            	description = otherStats.getDescription(searchCard),
            	image = {
                	url = otherStats.getImage(searchCard)
            	}
        	}
    	}
    	return
    end
end

return chatCommands