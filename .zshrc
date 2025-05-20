# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"
alias cdi="zi"

# ---- Eza (better ls) -----
alias ls="eza --icons=always"
alias ll="ls -la"

# Other aliases
alias tf=terraform
alias n=lvim
alias taildrop="tailscale file cp"
alias lg="lazygit"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/minhalvp/.bun/_bun" ] && source "/Users/minhalvp/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
source <(fzf --zsh)

# Added by Windsurf
export PATH="/Users/minhalvp/.codeium/windsurf/bin:$PATH"
