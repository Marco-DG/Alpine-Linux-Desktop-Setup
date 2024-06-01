# CODE

set-face global value           bright-blue                     # afflicts also the number-lines
set-face global type            bright-blue
set-face global variable        white
set-face global module          bright-blue
set-face global function        white
set-face global string          bright-blue
set-face global keyword         bright-blue
set-face global operator        white
set-face global attribute       white
set-face global comment         bright-black
set-face global documentation   bright-black
set-face global meta            bright-blue
set-face global builtin         bright-blue

# MARKUP

set-face global title           yellow
set-face global header          green
set-face global mono            cyan
set-face global block           magenta
set-face global link            blue
set-face global bullet          bright-yellow
set-face global list            white

# BUILTIN

set-face global Default white
set-face global PrimarySelection    black,bright-white
set-face global SecondarySelection  black,green
set-face global PrimaryCursor       black,bright-white
set-face global SecondaryCursor     black,cyan
set-face global PrimaryCursorEol    black,bright-white
set-face global SecondaryCursorEol  black,bright-white
set-face global LineNumbers         comment
set-face global LineNumberCursor    value
set-face global LineNumbersWrapped  black
set-face global MenuForeground      bright-white+b              # highlight the item selected in the menu
set-face global MenuBackground      default
set-face global MenuInfo            green
set-face global Information         default
set-face global Error               default
set-face global StatusLine          default
set-face global StatusLineMode      bright-blue                 # bottom "insert"
set-face global StatusLineInfo      default                     # bottom "1 sel"
set-face global StatusLineValue     white
set-face global StatusCursor        black,bright-white
set-face global Prompt              default
set-face global MatchingChar        +bu
set-face global BufferPadding       black
set-face global Whitespace          comment

# PLUGINS

# kak-lsp
set-face global InlayHint +d@type
set-face global parameter +i@variable
set-face global enum cyan
set-face global InlayDiagnosticError default
set-face global InlayDiagnosticWarning yellow
set-face global InlayDiagnosticInfo blue
set-face global InlwhiteayDiagnosticHint green
set-face global LineFlagError default
set-face global LineFlagWarning yellow
set-face global LineFlagInfo blue
set-face global LineFlagHint green
set-face global DiagnosticError ,,default+c
set-face global DiagnosticWarning ,,yellow+c
set-face global DiagnosticInfo ,,blue+c
set-face global DiagnosticHint ,,green+c
# Infobox faces
set-face global InfoDefault Information
set-face global InfoBlock block
set-face global InfoBlockQuote block
set-face global InfoBullet bullet
set-face global InfoHeader header
set-face global InfoLink link
set-face global InfoLinkMono header
set-face global InfoMono mono
set-face global InfoRule comment
set-face global InfoDiagnosticError InlayDiagnosticError
set-face global InfoDiagnosticHint InlayDiagnosticHint
set-face global InfoDiagnosticInformation InlayDiagnosticInfo
set-face global InfoDiagnosticWarning InlayDiagnosticWarning

# kak-rainbower
try %{ set-option global rainbow_colors yellow magenta blue }

# For backwards compatibility
define-command -override -hidden one-enable-fancy-underlines %{
    echo -debug "one-enable-fancy-underlines is deprecated - curly underlines are enabled by default"
}
