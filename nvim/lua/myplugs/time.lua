local M = {}
local mappings = require("mappings")

M.config = {
    format              = "%H:%M",
    timer_duration      = 10, -- default in minutes
    timer_message       = "Time's up!",
    queue_notifications = true,
    notification_time   = 3000, -- milliseconds
}

function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts or {})
end

local notification_queue = {}
local is_notification_active = false
function M.show_notification(message)
    local function display_notification(msg)
        -- buf
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
        vim.api.nvim_buf_set_option(buf, "swapfile", false)
        vim.api.nvim_buf_set_option(buf, "undofile", false)
        vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

        -- text
        local text_width = #msg
        local total_width = 20
        local padding = math.floor((total_width - text_width) / 2)
        local centered_msg = string.rep(" ", padding) .. msg

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { centered_msg })

        -- positioning
        local col = vim.o.columns - total_width - 4
        local row = 1

        -- win
        local win = vim.api.nvim_open_win(buf, false, {
            relative = 'editor',
            width = total_width,
            height = 1,
            col = col,
            row = row,
            style = 'minimal',
            border = 'rounded',
            focusable = false, -- Make the window non-focusable
        })

        -- automatically close the window after n seconds
        vim.defer_fn(function()
            vim.api.nvim_win_close(win, true)
            is_notification_active = false
            -- If there are more notifications in the queue, show the next one
            if #notification_queue > 0 then
                local next_message = table.remove(notification_queue, 1)
                M.show_notification(next_message)
            end
        end, M.config.notification_time)
    end

    -- Queue notifications if one is already active
    if M.config.queue_notifications and is_notification_active then
        table.insert(notification_queue, message)
    else
        is_notification_active = true
        display_notification(message)
    end
end

function M.show_time()
    local current_time = os.date(M.config.format)
    M.show_notification(current_time)
end

---@param minutes number?
---@param message string?
function M.set_timer(minutes, message)
    minutes = minutes or M.config.timer_duration
    message = message or M.config.timer_message

    vim.defer_fn(function()
        M.show_notification(message)
    end, minutes * 60 * 1000)

    print("timer set for " .. minutes .. "min(s)")
end

function M.set_timer_dynamic()
    local count = vim.v.count -- Capture the count if any
    if count > 0 then
        M.set_timer(count)
    else
        local minutes = vim.fn.input("Enter timer duration (minutes): ")
        M.set_timer(tonumber(minutes))
    end
end

-- Map <leader>t to show time
mappings.map2("n", "<leader>t", M.show_time, {})

-- Detect *count*<leader>T to set timer
mappings.map2("n", "<leader>T", M.set_timer_dynamic, {})

return M
