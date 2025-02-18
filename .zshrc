# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
. "/Users/minhalvp/.deno/env"
. "$HOME/.cargo/env"

alias tf=terraform

# pnpm
export PNPM_HOME="/Users/minhalvp/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
alias taildrop="tailscale file cp"

export PATH="/Users/minhalvp/.local/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk && export PATH=$PATH:$ANDROID_HOME/emulator && export PATH=$PATH:$ANDROID_HOME/platform-tools 
