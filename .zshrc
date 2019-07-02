# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs..

# Lines configured by zsh-newuser-install
export EDITORP=vim #エディタをvimに設定
export LANG=ja_JP.UTF-8 #文字コードをUTF-8に設定

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# history
HISTFILE=~/work/dotfils/zsh/.zsh_hist
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history #ヒストリに実行時間も保存
setopt hist_ignore_dups #直前と同じコマンドはヒストリに追加しない

# viキーバインド
bindkey -v

# cdした先のディレクトリをディレクトリスタックに追加
setopt auto_pushd

# pushdしたとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# コマンドのスペルミスを訂正する
setopt correct

# <Tab>でパス名の補完候補を表示したあと、
# 続けて<Tab>を押すと候補からパス名を選択することができるようになる
zstyle ':completion:*:default' menu select=1

autoload colors
zstyle ':completion:*' list-lolors "${LS_COLORS}"

# エイリアス
alias -s py='python'
alias -s jl='julia'
alias -s rb='ruby'
alias -s js='osascript -l JavaScript'
alias -s cc='gcc -o'
alias -s cpp='gcc -o'
function runcpp () { gcc -O2 $1; ./a.out }
alias -s {c,cpp}=runcpp
alias -s txt='vim'
alias -s html='open'
alias -s png='open'
function runjava () {
    className=$1
    className=${className%.java}
    javac $1
    shift
    java $className $@
}
alias -s java='runjava'

function runrust () {
    className=$1
    className=${className%.rs}
    echo $1
    rustc $1
    ./$className $@
}
alias -s rs='runrust'


# 複数個上にも移動できるようにする
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='ls -1'
alias la='ls -aG'
alias ll='ls -lG'
alias vimtutor='vimtutor ja'
alias sz='source ~/.zshrc'

# vで始まるコマンドはvimでファイルを開く事を示す
alias v='vim'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias vg='vim ~/.gvimrc'
alias vzp='vim ~/.zprofile'

# caで始まるコマンドはcargo系のコマンドを行う事を示す
alias cab='cargo build'
alias car='cargo run'
alias cau='cargo update'
alias cac='cargo check'

# cで始まるコマンドはcd系のコマンドを行う事を示す
alias cpy='cd ~/IT/Python'

# アプリ起動コマンド
# 日本語ネームのアプリは情報を見るから名前を確認
# oはopenの略
alias /a='/applications'
alias od='open -a Discord'
alias of='open -a Firefox'
alias og='open -a Google\ Chrome'
alias ogm='open -a GO\ for\ Gmail'
alias oi='open -a iTunes'
alias ok='open -a Keyboard\ Maestro'
alias oke='open -a Karabiner-Elements'
alias oki='open -a Kindle'
alias ol='open -a Launchpad'
alias oli='open -a LINE'
alias om='open -a notes'
alias os='open -a System\ Preferences'
alias osl='open -a Slack'
alias ov='open -a MacVim'
alias ovc='open -a Visual\ Studio\ Code'
alias ox='open -a Xcode'

# 遊び
alias -s m3a=afplay
alias -s m4a=afplay

# おまじない気分 防止するエラーがあるので一応置いてある詳しくはggr
alias sudo='sudo'

# cd無しで移動
setopt auto_cd
# cdの後にlsを実行
# chpwd() { ls -ltrG  }     # ファイルの編集日時などの詳細情報を表示
function chpwd() { ls -1 }  # ファイル名のみの簡易的な情報を表示

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

eval "$(pyenv init -)"

# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# '#'以降をコメントとして扱う
setopt interactive_comments
# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# ターミナルを閉じてもコマンドを遡れるようにする
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000

# 他のターミナルで実行したコマンドを使えるようにする
setopt share_history
alias aaa='echo $(('


# プラグインの設定 -----------------------------------------------------

# zplugがなければgitからclone
if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを使う
source ~/.zplug/init.zsh
# ここに使いたいプライグインを書いておく
# zplug "ユーザー名/リポジトリ名", タグ
# 補完強化
zplug 'zsh-users/zsh-completions'
# コマンドを種類ごとに色付け
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
# fzf 関連のプラグイン
# 本体（連携前提のパーツ)
zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux
# ヒストリの補完を強化する
zplug 'zsh-users/zsh-history-substring-search', defer:3
# git のローカルリポジトリを一括管理（fzf でリポジトリへジャンプ）
zplug 'motemen/ghq', as:command, from:gh-r
# fzf でよく使う関数の詰め合わせ
zplug 'mollifier/anyframe'
# git の補完を効かせる
# 補完&エイリアスが追加される
zplug 'plugins/git', from:oh-my-zsh
zplug 'peterhurford/git-aliases.zsh'
# 自分自身をプラグインとして管理
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# インストールしてないプラグインはインストール
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi
# コマンドをリンクして, PATHに追加し、プラグインは読み込む
zplug load


# fzfの設定 -------------------------------------------------------------------


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# 選択したファイルをvimで開く
fe() {
    local files
    IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}


# fd 選択したディレクトリに移動
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
}


# インタラクティブCD
function cd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
        fzf --reverse --preview '
        __cd_nxt="$(echo {})";
        __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
        echo $__cd_path;
        echo;
        ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || ls -1
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# .zshrc が.zshrc.zwc より新しい場合zcomipleを自動で実行
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
    zcompile ~/.zshrc
fi
echo こんにちはなんだナ!

# ボトルネックを探りたい時は↓と.zshenv1行目のコメントを外す
#if type zprof > /dev/null 2>&1; then
#  zprof | less
#fi
# End of lines added by compinstall
