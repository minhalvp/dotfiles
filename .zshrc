# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# Other aliases
alias tf=terraform
alias taildrop="tailscale file cp"