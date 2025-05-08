# make .bash_profile same as .bashrc
if [ -f "${HOME}/.bashrc" ]; then
    source "${HOME}/.bashrc"
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/john/.cache/lm-studio/bin"
# End of LM Studio CLI section

