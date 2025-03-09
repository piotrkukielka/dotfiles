# dotfiles

## Chezmoi for dotfiles management
I use [chezmoi](chezmoi.io) for dotfiles management mainly due to it's templating capabilities.

### Putting a secret from keepassxc in dotfiles
In order to utilize the templating engine the file [has to be added to chezmoi as a template](https://www.chezmoi.io/user-guide/templating/#creating-a-template-file). For example
```
chezmoi add --template ~/.zshrc
```
or if the file is already added
```
chezmoi chattr +template ~/.zshrc
```
Only then will evaluate the template and ask for keepass password. Example line that will trigget the templating and replaces it with value from UserName key in `test` entry in dotfiles folder in keepass vault defined in [chezmoi config](https://www.chezmoi.io/user-guide/password-managers/keepassxc/)
```
    somespecialvariable = {{ (keepassxc "dotfiles/test").UserName }}
```

Unfortunalety if using templates `chezmoi re-add` does not work (for these files).
