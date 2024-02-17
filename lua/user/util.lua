local Util = {}

function Util.clean_registers()
    local regs = vim.split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", "")
    for _, r in ipairs(regs) do
        vim.fn.setreg(r, {})
    end
    print("finish to clean registers")
end

return Util
