-- dummy functions so our script doesnt bug when we load it in game
-- since the actual functions do IO

-- actual function
local doLog = false
function slthLog(text)
    if doLog then
        slthLog(text)
    end
end

print_counter = 0
function simpleGridPrint(tbl, title, keymap)
    startPrinter(title)
    local count = 0
    local x_string = ''
    for i, val in pairs(tbl) do
    if count == g_iW then
    count = 0
    slthLog(x_string)
    x_string = ''
    end
    count = count + 1
    x_string = x_string .. val .. '|'
    end
    slthLog('STOP')
    print_counter = print_counter + 1
end

function startPrinter(title)
    local index_string
    if print_counter > 29 then
        index_string = 'c' .. print_counter
    elseif print_counter > 19 then
        index_string = 'b' .. print_counter
    elseif print_counter > 9 then
        index_string = 'a' .. print_counter
    else
        index_string = print_counter
    end
    slthLog('START ; ', index_string .. title)
end

function saveSVG(content, filename)
    return
end
