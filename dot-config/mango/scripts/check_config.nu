#!/usr/bin/env nu
def main [] {
    ^mango -p
    | complete
    | get stderr
    | str length
    | if $in == 0 {
        dms notify "No mango isssues"
    } else {
        dms notify "Run `mango -p` to check"
    }
}
