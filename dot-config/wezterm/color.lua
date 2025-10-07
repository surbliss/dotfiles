local wezterm = require "werterm"

local module = {}

module.minimal_custom = {
  background = "#1f1f28",
  foreground = '#dcd7ba'
  ,
  -- [colors.normal]
  black = '#090618',
  red = '#C34043',
  green = '#98BB6C',
  yellow = '#E6C384',
  blue = '#A3D4D5',
  magenta = '#B8B4D0',
  cyan = '#7E9CD8', -- # not cyan, just crystalBlue, lul
  white = '#c8c093',

  -- [colors.bright]
  brights = {
    black = '#727169',
    red = '#e82424',
    green = '#98bb6c',
    yellow = '#e6c384',
    blue = '#7fb4ca',
    magenta = '#938aa9',
    cyan = '#7aa89f',
    white = '#dcd7ba',
  },
  -- [colors.selection]
  selection_bg = '#2d4f67',
  selection_fg = '#c8c093',

  indexed = {
    [16] = '#ffa066',
    [17] = '#ff5d62'
  }
}


module.kanagawa_lotus = {
  foreground = "#181825", -- lotusInk0
  background = "#FDFCFB", -- lotusWhite0

  cursor_fg = "#B7C5D8",  -- lotusBlue1
  cursor_bg = "#65869C",  -- lotusInk3

  selection_fg = "#181825",
  selection_bg = "#B7C5D8", -- lotusBlue1

  ansi = {
    "#EAE3D7", -- black   (lotusWhite2)
    "#E82424", -- red     (lotusRed)
    "#76946A", -- green   (lotusGreen)
    "#DCA561", -- yellow  (lotusYellow)
    "#086187", -- blue    (lotusBlue2)
    "#957FB8", -- magenta (lotusViolet)
    "#0081A7", -- cyan    (lotusCyan)
    "#181825", -- white   (lotusInk0)
  },
  brights = {
    "#8F909C", -- bright black   (lotusInk1)
    "#FF5D62", -- bright red     (lotusBrightPink)
    "#2E8B57", -- bright green   (lotusBrightGreen)
    "#FF8800", -- bright orange  (lotusBrightOrange)
    "#223249", -- bright blue    (lotusBlue3)
    "#7C3AED", -- bright magenta (lotusBrightViolet)
    "#006A6A", -- bright cyan    (lotusSuperAqua)
    "#FDFCFB", -- bright white   (lotusWhite0)
  },
}

return module
