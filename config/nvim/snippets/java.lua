local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper: capitalize first letter of the value typed in another node
local function capitalize(args)
    local name = args[1][1] or ""
    if name == "" then
        return ""
    end
    return name:sub(1, 1):upper() .. name:sub(2)
end

-- Helper: pass through another node's value unchanged
local function passthrough(args)
    return args[1][1] or ""
end

return {
    s(
        { trig = "function", dscr = "Function" },
        t({
            "    public void function() {",
            "        final Object value = null;", 
            "    }",
        })
    ),
    s(
        { trig = "functionOptional", dscr = "Function returning an optional" },
        t({
            "    public Optional<type> function() {",
            "        final Object returnValue = null;",
            "        return Optional.ofNullable(returnValue);",
            "    }",
        })
    ),
}
