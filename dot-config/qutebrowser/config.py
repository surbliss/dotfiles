config.load_autoconfig(False)

config.bind("d", "scroll-page 0 0.5")
config.bind("u", "scroll-page 0 -0.5")
config.bind("<Ctrl-U>", "undo")
config.bind("x", "tab-close")

# c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"

c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
]

