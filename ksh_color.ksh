# See http://misc.flogisoft.com/bash/tip_colors_and_formatting
# For more information on ANSI256 color codes and using colors on terminals in general

RESET='[0m'
NORMAL='[22m'
BOLD='[1m'
UNDERLINE='[4m'

BLACK=0m
RED=1m
GREEN=2m
YELLOW=3m
BLUE=4m
MAGENTA=5m
CYAN=6m
WHITE=7m


FG='[3'
BG='[4'

FGBLACK="$FG$BLACK"
FGRED="$FG$RED"
FGGREEN="$FG$GREEN"
FGYELLOW="$FG$YELLOW"
FGBLUE="$FG$BLUE"
FGMAGENTA="$FG$MAGENTA"
FGCYAN="$FG$CYAN"
FGWHITE="$FG$WHITE"

BGBLACK="$BG$BLACK"
BGRED="$BG$RED"
BGGREEN="$BG$GREEN"
BGYELLOW="$BG$YELLOW"
BGBLUE="$BG$BLUE"
BGMAGENTA="$BG$MAGENTA"
BGCYAN="$BG$CYAN"
BGWHITE="$BG$WHITE"

FGA256='[38;5;'
BGA256='[48;5;'

# usage
# echo "$FG${RED}WARNING:${RESET} This could be bad"
# echo "$BG${RED}ERROR:${RESET} This IS bad!"
# echo "${FGGREEN}OK:${RESET} This is OK"
# echo "$BOLD$FGBLACK${BGYELLOW}FOUND${RESET} in a string."
# echo "${BGA256}125mHELLO${RESET}"   # Only works on 256 color capable terminals.

# echo "WARN This is bad" | sed -e "s/WARN/$BG${RED}&${RESET}/g"
# search() {
#   PAT="$1"
#   shift
#   sed -e "s/$1/$BG${YELLOW}&${RESET}/g" $@
# }
