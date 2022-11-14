# FZF configuration options
export FZF_DEFAULT_OPTS="--no-height --no-reverse"

# FZF utility functions
## fd - cd to selected directory
fd() {
    local dir
    dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
    cd "$dir"
}

## fbr - checkout git branch
fbr() {
	local branches branch
	branches=$(git branch -vv) &&
	branch=$(echo "$branches" | fzf +m) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

## fstash - easier way to deal with stashes
fstash() {
    local out q k sha
    while out=$(
        git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
        fzf --ansi --no-sort --query="$q" --print-query \
                --expect=ctrl-d,ctrl-b);
    do
        mapfile -t out <<< "$out"
        q="${out[0]}"
        k="${out[1]}"
        sha="${out[-1]}"
        sha="${sha%% *}"
        [[ -z "$sha" ]] && continue
        if [[ "$k" == 'ctrl-d' ]]; then
            git diff $sha
        elif [[ "$k" == 'ctrl-b' ]]; then
            git stash branch "stash-$sha" $sha
            break;
        else
            git stash show -p $sha
        fi
    done
}
