local discordia = require("Discordia")
local dbase = require("sqlite3")
local monsterStats = require("./monsterDetails")
local otherStats = require("./otherCardDetails")
local commands = require("./commands")

local client = discordia.Client()

client:on("ready", function()
    print("Ready to go.")
end
)

client:on("messageCreate", function(message)
    chatCommand = message.content
    chatCommand = string.sub(chatCommand, 3, -1)
    commands["viewcard"](message)
end
)

client:run("Bot TOKEN")