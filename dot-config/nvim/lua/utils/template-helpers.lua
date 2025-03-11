local M = {}
-- Put them in M.su = {} when we need more functions...

M.assignment_number = string.match(vim.fn.expand("%"), "A(%d+)") or "?"

local function calculate_next_friday()
  local date = os.date("*t")
  local today = date.wday
  -- 1,2,3,4,5,6
  local days_till_friday
  if today <= 6 then
    days_till_friday = 7 - today
  else
    days_till_friday = 14 - today
  end
  local next_friday_day = today + days_till_friday
  date.day = next_friday_day
  ---@diagnostic disable-next-line: param-type-mismatch
  local next_friday = os.time(date)
  return os.date("%d", next_friday), os.date("%B", next_friday)
end

M.next_friday_date, M.next_friday_month = calculate_next_friday()

-- For testing xd
M.bajer = "maxbajer"

return M
