i3-msg "workspace 1 ; append_layout ~/.config/i3/workspace1.json"
emacs --name "i3-config" ~/.config/i3/config &
urxvt -name topright -e htop &
urxvt -name middlerightleft -e ~/.config/i3/ttyclock.sh &
urxvt -name middlerightright -e cmatrix &
urxvt -name bottomright -hold -e neofetch --w3m &
