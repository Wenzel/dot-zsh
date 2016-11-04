for i in `echo $HOME/.zsh/*.zshrc | sort`; do
    source $i
done

