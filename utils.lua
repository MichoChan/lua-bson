local M = {}

local tconcat = table.concat
local tinsert = table.insert
local srep = string.rep

M.print_table = function(root)
    local cache = {  [root] = "." }
    local function _dump(t,space,name)
        local temp = {}
        for k, v in next, t do
            local key = tostring(k)
            if cache[v] then
                tinsert(temp,"+" .. key .. " {" .. cache[v].."}")
            elseif type(v) == "table" then
                local new_key = name .. "." .. key
                cache[v] = new_key
                tinsert(temp,"+" .. key .. _dump(v,space .. (next(t,k) and "|" or " " ).. srep(" ",#key),new_key))
            else
                tinsert(temp,"+" .. key .. " [" .. tostring(v).."]")
            end
        end
        return tconcat(temp,"\n"..space)
    end

    print(_dump(root, "",""))
end

M.hex_dump = function(b)
    local s = tostring(b)
    local format, sub = string.format, string.sub
    for i = 1, #s do
        print(format("\\x%02x", sub(s, i, i):byte()))
    end
end

return M
