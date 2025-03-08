# Date Created: 03/08/2025
# AUTHOR: Gustavo Wydler Azuaga

# git_new_account_setup

Welcome to the **git_new_account_setup** repository! 🎉

## 📌 About This Project
This script eacily walks you through the process of setting up a new github account in your linux system

- Asks for the github username
- Asks for the email associated with the github username
- Generates an ed25519 ssh key with the following format:
  
  ```bash
   $HOME/.ssh/id_ed25519_$github_user
   ```
- Adds the user to ~/.ssh/config file:
  ```bash
  # $github_user GitHub Account
  Host github.com-$github_user
    HostName github.com
    User git
    IdentityFile .ssh/id_ed25519_$github_user
    IdentitiesOnly yes
  ```
- Ensures ssh agent is running.
- Adds ssh key .ssh/id_ed25519_$github_user.
- Lists the recently added secret and public keys.
- Prompts the user to visit: https://github.com/settings/keys
- Tells the user to paste the recently generated key in the portal.
- Tests the ssh connection with: ssh -T git@github.com-$github_user
- Requests the user to visit: https://github.com/settings/tokens
- Instructs the user to generate New Token (classic) in the portal.
- Requests the user to provide the recently generated OAuth token.
- Attempts to validate the user with the github api.
- Runs the gh auth status, and informs loggin status.
- Finally fetches user data.

Feel free to modify and expand upon it as needed.

## 🚀 Getting Started

1. Clone this repository:
   ```bash
   git clone git@github.com:kurogane13/git_new_account_setup.git
   ```
2. Navigate into the directory:
   ```bash
   cd git_new_account_setup
   ```

##
---
💡 *Happy coding! 🚀*
