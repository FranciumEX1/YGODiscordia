local dbase = require("sqlite3")

local otherStats = {}

function otherStats.doesSTExist(cardName)
    conn = dbase.open("YuGiscord.db")
    local search = conn:exec("SELECT COUNT(*) FROM SpellsAndTraps WHERE Cardname LIKE '%" .. cardName .. "%'")
    --search:reset():bind(cardName):step()
    local result = tonumber(search[1][1])
    print(result)
    if result ~= 0 then return true else return false end
    conn:close()
end

function otherStats.getName(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Cardname FROM SpellsAndTraps WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

function otherStats.getDescription(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT Description FROM SpellsAndTraps WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

function otherStats.getImage(cardName)
    local conn = dbase.open("YuGiscord.db")
    local searcher = conn:exec("SELECT CardImage FROM SpellsAndTraps WHERE Cardname LIKE '%" .. cardName .. "%'")
    local result = searcher[1][1]
    conn:close()
    return result
end

return otherStats