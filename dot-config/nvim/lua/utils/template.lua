local M = {}
-- Put them in M.su = {} when we need more functions...

M.assignment_number = string.match(vim.fn.expand("%"), "A(%d+)") or "?"

local function calculate_next_friday()
	local date = os.date("*t")
	local today = date.wday
	local days_till_friday = (6 - today) % 7
	local next_friday_day = date.day + days_till_friday
	date.day = next_friday_day
	---@diagnostic disable-next-line: param-type-mismatch
	local next_friday = os.time(date)
	local old_locale = os.setlocale(nil, "time")
	os.setlocale("en_US.UTF-8", "time")
	local month = os.date("%B", next_friday)
	os.setlocale(old_locale, "time")
	return os.date("%d", next_friday), month
end
print(os.setlocale(nil, "time"))

M.next_friday_date, M.next_friday_month = calculate_next_friday()

-- For testing xd
M.bajer = "maxbajer"

return M
