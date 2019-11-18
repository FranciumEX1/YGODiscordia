local dbase = require("sqlite3")

local monsterStats = {}

function monsterStats.doesMonsterExist(cardName)
    conn = dbase.open("YuGiscord.db")
    local search = conn:exec("SELECT COUNT(*) FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    --search:reset():bind(cardName):step()
    print(search[1][1])
    local result = tonumber(search[1][1])
    if result ~= 0 then return true else return false end
    conn:close()
end

function monsterStats.cardTitle(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Cardname FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

function monsterStats.getAttack(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Attack FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = tonumber(searcher[1][1])
    conn:close()
    return result
end

function monsterStats.getDefense(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Defense FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = tonumber(searcher[1][1])
    conn:close()
    return result
end

function monsterStats.getLevel(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Level FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = tonumber(searcher[1][1])
    conn:close()
    return result
end

function monsterStats.getAttribute(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Attribute FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

function monsterStats.getSubType(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT SubType FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end


function monsterStats.cardImage(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Image FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

function monsterStats.getDescription(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Description FROM Monsters WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

return monsterStats