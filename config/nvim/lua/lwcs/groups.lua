local M = {}

M.setup = function()
  local mappings = {}
  
  local function bg(key, val)
    mappings[key] = { bg = val }
  end


  local function fg(key, val)
    mappings[key] = { fg = val }
  end
 
  bg("Normal", "#282c34")
  -- bg("NormalFloat", "#795548")
  -- bg("NormalNC", "#795548")

  fg("@string.c", "#00F000")
  fg("@string.java", "#F44336")
  return mappings
end

return M

