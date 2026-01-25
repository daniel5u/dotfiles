Statusline = {}

-- status of git
local function git()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
    return ""
    end

    local head      = git_info.head
    local added     = git_info.added and (" +" .. git_info.added) or ""
    local changed   = git_info.changed and (" ~" .. git_info.changed) or ""
    local removed   = git_info.removed and (" -" .. git_info.removed) or ""
    if git_info.added == 0 then added = "" end
    if git_info.changed == 0 then changed = "" end
    if git_info.removed == 0 then removed = "" end

    return table.concat({
        "[ ",
        head,
        added, changed, removed,
        "]",
    })
end

-- show the file icon
local function icon()
    local ok, dev = pcall(require, "nvim-web-devicons")
    if not ok then return "" end
    local ico, col = dev.get_icon_color(vim.fn.expand("%:t"), nil, { default = true })
    return ico and (" %#Icon#" .. ico .. "%*") or ""
end

-- time stamp
local function time()
    return "[" .. os.date("%H:%M") .. "]"
end

-- show mode in statusline
local function mode()
    local m = vim.api.nvim_get_mode().mode
    local map = {
        n = "NORMAL", no = "N-OPER", v = "VISUAL", V = "V-LINE",
        [""] = "V-BLOCK", s = "SELECT", s = "S-LINE", [""] = "S-BLOCK",
        i = "INSERT", ic = "INSERT", R = "REPLACE", cv = "EX", t = "TERM"
    }
    return "[" .. (map[m] or m) .. "]"
end



function Statusline.active()
    return table.concat {
        icon()," [%F]",
        git(),
        "%=",
        time()," ",
        mode()
    }
end

function Statusline.inactive()
    return " %t"
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})


