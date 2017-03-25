# Git Hooks

My standard hooks for git repositories.

## Setup

```sh
cp -R /usr/share/git-core/templates ~/.git_templates
rm -rf ~/.git_templates/hooks
git clone $this_repo_url ~/.git_templates/hooks
git config --global init.templatedir ~/.git_templates
```
