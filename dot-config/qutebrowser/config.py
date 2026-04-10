# ty: ignore C0111
c = c  # noqa: F821
config = config  # noqa: F821

config.load_autoconfig(False)

config.bind("d", "scroll-page 0 0.5")
config.bind("u", "scroll-page 0 -0.5")
config.bind("<Ctrl-U>", "undo")
config.bind("x", "tab-close")
config.bind("<space>l", "config-source")
config.unbind("G")
config.bind("ge", "scroll-to-perc 100")
config.bind("<Ctrl+1>", "tab-focus 1")
config.bind("<Ctrl+2>", "tab-focus 2")
config.bind("<Ctrl+3>", "tab-focus 3")
config.bind("<Ctrl+4>", "tab-focus 4")
config.bind("<Ctrl+5>", "tab-focus 5")
config.bind("<Ctrl+6>", "tab-focus 6")
config.bind("<Ctrl+7>", "tab-focus 7")
config.bind("<Ctrl+8>", "tab-focus 8")
config.bind("<Ctrl+9>", "tab-focus -1")  # Last tab

# c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"

c.aliases["tp"] = "open 127.0.0.1:23635"


c.editor.command = ["alacritty", "-e", "hx", "{file}"]

c.url.searchengines = {
    "DEFAULT": "https://html.duckduckgo.com/html&q={}",
    "np": "https://search.nixos.org/packages?channel=unstable&query={}",
    "no": "https://search.nixos.org/options?channel=unstable&query={}",
}

c.url.default_page = "about:blank"
# c.url.start_pages = ["about:blank"]
c.url.start_pages = ["https://html.duckduckgo.com"]


# Settings from https://obionar.com/blog/qutebrowser-configuration/
### Privacy
# No autoplay — saves bandwidth, reduces tracking pixels in video ads
c.content.autoplay = False

# No geolocation — I do not want sites to know where I am
c.content.geolocation = False

# First-party cookies only — blocks most cross-site tracking
c.content.cookies.accept = "no-3rdparty"

# Limit referrer leakage — only send referrer to the same domain
c.content.headers.referer = "same-domain"

# Disable WebGL — it is a fingerprinting vector I rarely need
c.content.webgl = False

# No browser notifications — they are almost always spam
c.content.notifications.enabled = False

# No JavaScript clipboard access — sites should not read your clipboard silently
c.content.javascript.clipboard = "none"

# Restrict WebRTC — prevents IP leakage through peer connections
c.content.webrtc_ip_handling_policy = "default-public-interface-only"

# No DNS prefetch — prevents the browser from resolving links you have not
# clicked
c.content.dns_prefetch = False


### Ad Blocking
c.content.blocking.enabled = True
c.content.blocking.method = "both"

c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
]


c.content.blocking.hosts.lists = [
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
    "https://someonewhocares.org/hosts/zero/hosts",
]
