stringStuff = {}

function stringStuff.stringConverter(cardName)
    local newString = string.gsub(" " .. cardName, "%W%l", string.upper):sub(2)
    return newString
end

return stringStuff