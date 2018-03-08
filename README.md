
# dotfiles

All my linux configuration in one central location.

This is the documentation for how to version control dotfiles across multiple systems via git and the config alias. The method for this was taken directly from [Nicola Paolucci's blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

See the above post for how to setup the initial git repo.

To use the dotfiles on a new linux installation perform the following:

```bash
git clone --bare https://github.com/sizezero/dotfiles.git ~/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
<if the above command fails, delete or backup any conflicting files and retry>
config config --local status.showUntrackedFiles no
```

Since untracked files are not shown through the normal status command it can be hard to know which files have been committed to the repo. To show all files in the dotfiles repo:

```bash
config ls-files
```
