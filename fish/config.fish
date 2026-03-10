set -g fish_greeting --

# --- 全局字体颜色设置 (191, 189, 183 -> #bfbdb7) ---
# 这些设置会影响你输入的命令、参数以及普通文本的颜色
set -g fish_color_normal bfbdb7
set -g fish_color_command bfbdb7
set -g fish_color_param bfbdb7
set -g fish_color_error ff5555 --bold # 错误命令建议保留红色，方便识别
set -g fish_color_autosuggestion 555 # 自动建议使用灰色

# --- 提示符设置 (163, 249, 77 -> #a3f94d) ---
function fish_prompt
    set_color a3f94d
    echo (prompt_pwd -D 6)
    echo -n "> " # 建议加一个空格，输入更美观
    
    # 提示符结束后，将颜色恢复为你要求的“其他字体颜色”
    set_color bfbdb7
end

# --- 你的其他函数保持不变 ---

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$pwd" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function nh
    nohup $argv &>/dev/null &
end

function t
    set_color a3f94d # 这里我同步改成了你的 Prompt 绿色，保持一致
    date +"%m-%d %A %T"
    set_color bfbdb7
end

function ch
    curl cheat.sh/$argv[1]
end

function dd
    # 注意：macOS 通常没有 v 这个别名，建议根据你之前的讨论改为 nvim 或 vim
    ddgr --unsafe -x --np $argv | nvim - +"syntax on | set ft=rst wrap"
end

# >>> conda initialize >>>
if test -f /Users/danielsu/anaconda3/bin/conda
    eval /Users/danielsu/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

alias tl "tmux list-sessions"
alias ta "tmux attach-session -t"
alias tn "tmux new-session -s"
alias v nvim
alias z zed-preview

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

eval (/opt/homebrew/bin/brew shellenv)

function auto_switch_input_source --on-event fish_prompt
    if set -q GHOSTTY_RESOURCES_DIR
        macism com.apple.keylayout.ABC
    end
end

# opencode
fish_add_path /Users/danielsu/.opencode/bin

# OpenClaw Completion
source "/Users/danielsu/.openclaw/completions/openclaw.fish"
