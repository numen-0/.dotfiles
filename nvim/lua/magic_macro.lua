Magic = {}
Magic.__index = Magic

function Magic.do_the_magic()
    local filetype = vim.api.nvim_exec2('echo &filetype', {output=true})["output"]
    if filetype ~= "c" then
        print("this is not a c file bro")
        return
    end
    local label_s = "____magic_macro_label_start:"
    local label_e = "____magic_macro_label_end:"
    local line_s = tonumber(vim.api.nvim_buf_get_mark(0, "<")[1])
    local line_e = tonumber(vim.api.nvim_buf_get_mark(0, ">")[1])
    local message = "// magic macro does it again"

    local file_name = vim.api.nvim_buf_get_name(0)
    local file_copy = file_name .. ".____magic_macro_copy_file.h"
    local file_copy2 = file_name .. ".____magic_macro_copy_file2.h"

    local command = [[silent !sed -e '%d a %s' -e '%d a %s' %s > %s; gcc -E -o- %s | sed '/^%s/,$\!d;/^%s$/,$d;' | sed '1 s|^.*$|%s|' &> %s]]
    command = string.format(command,
        line_s-1, label_s, line_e, label_e, file_name, file_copy,
        file_copy,
        label_s, label_e,
        message,
        file_copy2
    )

    vim.cmd(command)

    -- create scratch buf
    local buf = vim.api.nvim_create_buf(true, true)
    -- create and show window
    vim.cmd("vsplit")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(win, buf)

    vim.cmd(string.format("-1read %s", file_copy2))
    vim.cmd(string.format("silent !rm %s %s", file_copy, file_copy2))
end

return Magic
