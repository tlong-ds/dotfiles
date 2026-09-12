# The following lines were added by Docker Desktop to add commands to your PATH.
if test -d /Users/bunnypro/.docker/bin
    set -gx PATH /Users/bunnypro/.docker/bin $PATH
end
# End of Docker Desktop section.

if test -d /opt/homebrew/bin
    eval (/opt/homebrew/bin/brew shellenv)
end

if test -d /Users/bunnypro/.local/bin
    set -gx PATH /Users/bunnypro/.local/bin $PATH
end
