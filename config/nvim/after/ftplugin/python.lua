--
-- Safe to run twice
--
vim.bo.commentstring = "# %s"

vim.keymap.set("n", "<leader>oi", function()
    require("conform").format({ formatters = { "ruff_organize_imports" }, async = true })
end, { buffer = true, silent = true })

--
-- Guard
--
if vim.b.did_ftplugin_python then
    return
end
vim.b.did_ftplugin_python = true

local dap = require("dap")
if not dap.adapters.python then
    dap.adapters.python = function(cb, config)
        if config.request == "attach" then
            local connect = config.connect or config
            cb({
                type = "server",
                host = connect.host or "127.0.0.1",
                port = assert(connect.port, "connect.port required for python attach"),
            })
        else
            cb({
                type = "executable",
                command = "python",
                args = { "-m", "debugpy.adapter" },
                options = { source_filetype = "python" },
            })
        end
    end

    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            console = "internalConsole",
            justMyCode = false,
            python = function()
                local venv = vim.fn.getcwd() .. "/.venv/bin/python"
                if vim.fn.executable(venv) == 1 then
                    return venv
                end
                return "python"
            end,
        },
        {
            type = "python",
            request = "attach",
            name = "Attach to localhost:5678",
            connect = { host = "localhost", port = 5678 },
            justMyCode = false,
        },
    }
end

local root_markers = { "pyproject.toml", "ty.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }
local root_dir = vim.fs.root(0, root_markers)
if not root_dir then
    print("not in a python project")
    return
end

print("python root_dir = " .. root_dir)

vim.lsp.start({
    name = "ty",
    cmd = { "ty", "server" },
    root_dir = root_dir,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
})
