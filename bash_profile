if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/leolei/Downloads/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/leolei/Downloads/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/leolei/Downloads/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/leolei/Downloads/google-cloud-sdk/completion.bash.inc'
fi
