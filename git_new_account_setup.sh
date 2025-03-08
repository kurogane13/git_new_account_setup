#!/bin/bash

# 🛠️ Function to generate SSH key, configure GitHub SSH, and authenticate
add_github_account() {
    echo -e "\n\e[1;36m🚀 GitHub SSH Config & Key Generator 🚀\e[0m\n"

    # 📝 Prompt for GitHub username
    echo -e "\n\e[1;33m🔹 Enter new GitHub account username:\e[0m"
    read -p "   ➤ " github_user

    echo -e "\n\e[1;33m📧 Enter email for SSH key:\e[0m"
    read -p "   ➤ " user_email

    ssh_key_path="$HOME/.ssh/id_ed25519_$github_user"

    # 🛠️ Generate SSH key
    echo -e "\n\e[1;34m🔑 Generating SSH Key: $ssh_key_path ...\e[0m\n"
    ssh-keygen -t ed25519 -C "$user_email" -f "$ssh_key_path" -N ""

    # 🔧 Append new account to SSH config
    ssh_config="$HOME/.ssh/config"
    echo -e "\n\e[1;32m✏️ Updating SSH Config ($ssh_config) ...\e[0m\n"
    cat <<EOF >> "$ssh_config"

# $github_user GitHub Account
Host github.com-$github_user
  HostName github.com
  User git
  IdentityFile $ssh_key_path
  IdentitiesOnly yes
EOF

    # 🔄 Ensure ssh-agent is running
    echo -e "\n\e[1;35m♻️ Ensuring ssh-agent is running...\e[0m\n"
    eval "$(ssh-agent -s)"

    # 🛠️ Add the new SSH key
    echo -e "\n\e[1;34m🔑 Adding SSH Key to agent...\e[0m\n"
    ssh-add "$ssh_key_path"

    # 📂 List generated SSH keys
    echo -e "\n\e[1;36m📂 Listing SSH Keys:\e[0m\n"
    ls -lha "$ssh_key_path"*

    # 📜 Display the public key
    echo -e "\n\e[1;33m🔑 Here is your SSH public key:\e[0m\n"
    cat "$ssh_key_path.pub"

    echo -e "\n\e[1;32m🔗 Now, add this SSH key to GitHub:\e[0m"
    echo -e "\e[1;34m   ➤ Go to: https://github.com/settings/keys\e[0m"
    echo -e "\e[1;34m   ➤ Click 'New SSH Key', paste the key, and save it.\e[0m\n"

    read -p "   ➤ Press Enter once you have added the key to GitHub: "

    # ✅ Test SSH connection
    echo -e "\n\e[1;34m🔍 Testing SSH Connection to GitHub...\e[0m\n"
    ssh -T git@github.com-$github_user

    echo -e "\n\e[1;36m🎟️ Next, Generate an OAuth Token:\e[0m"
    echo -e "\e[1;34m   ➤ Go to: https://github.com/settings/tokens\e[0m"
    echo -e "\e[1;34m   ➤ Click 'Generate New Token (classic)'.\e[0m"
    echo -e "\e[1;34m   ➤ Select scopes (e.g., repo, gist, workflow as needed).\e[0m"
    echo -e "\e[1;34m   ➤ Copy and store the generated token securely.\e[0m\n"

    echo -e "\n\e[1;33m🔑 Enter your GitHub OAuth Token:\e[0m"
    read -s -p "   ➤ " github_token
    echo -e "\n"

    # 🔐 Authenticate using GitHub CLI via SSH
    echo -e "\n\e[1;35m🔑 Authenticating with GitHub CLI...\e[0m\n"
    echo "$github_token" | gh auth login --with-token

    # 🔍 Check authentication status
    echo -e "\n\e[1;36m🔍 Checking GitHub authentication status...\e[0m\n"
    gh auth status

    # 🔎 Fetch user details to confirm authentication
    echo -e "\n\e[1;34m🔎 Fetching GitHub user details...\e[0m\n"
    gh api user -q .

    echo -e "\n\e[1;32m✅ Setup complete! You are now authenticated with GitHub via SSH.\e[0m\n"
}

# 🔄 Run the function
add_github_account
