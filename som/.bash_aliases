#  ============================================================
#  aliases for git bash
#  ============================================================
alias pmg='premake5 gmake'
alias pmv='premake5 vs2022'
alias py='python3'

gitdir=/git
subdir=make

# SOM
alias cdg='cd $gitdir;ls'
alias cdd='cd $gitdir/DSTW/$subdir;git status'
alias cdd98='cd $gitdir/DSTW98/$subdir;git status'
alias cdct='cd $gitdir/CoverageTest/$subdir;git status'
alias cdpy='cd $gitdir/sompy;git status'
alias cdco='cd $gitdir/covbr2html/$subdir;git status'
alias cdcp='cd $gitdir/somcpp/$subdir;git status'
alias cdts='cd $gitdir/CppUTestSteps/$subdir;git status'
alias cdto='cd $gitdir/todo;git status'
alias cdht='cd $gitdir/howto;git status'

# UTILZ
alias gl='git log --abbrev-commit -n 10'
alias gs='git st'
alias gd='git diff -b'
alias gb='git branch'
alias gdn='git diff --name-only'
alias gfo='git fetch origin'
alias gfd='git fetch origin dev:dev'
alias gcl='git clean -dfXq .'
