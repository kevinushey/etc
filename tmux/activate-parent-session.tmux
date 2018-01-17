set -gq prefix C-Space
set -gq status-bg colour236
send-keys M-F11

bind-key -n S-Up      select-pane -U
bind-key -n S-Down    select-pane -D
bind-key -n S-Left    select-pane -L
bind-key -n S-Right   select-pane -R

bind-key -n M-S-Up    resize-pane -U 10
bind-key -n M-S-Down  resize-pane -D 10
bind-key -n M-S-Left  resize-pane -L 10
bind-key -n M-S-Right resize-pane -R 10

bind-key -n M-Left    select-window -p
bind-key -n M-Right   select-window -n

