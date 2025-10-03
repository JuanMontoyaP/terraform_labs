#!/bin/bash

# Update the system
apt-get update -y
apt-get upgrade -y
apt-get install -y openssh-server

# Create the .ssh directory for the ubuntu user
mkdir -p /home/ubuntu/.ssh
chmod 700 /home/ubuntu/.ssh

# Create the private key file
cat << 'EOL' > /home/ubuntu/.ssh/id_rsa
${private_key}
EOL

# Set proper permissions for the private key
chmod 600 /home/ubuntu/.ssh/id_rsa
chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa

# Set ownership of the .ssh directory
chown ubuntu:ubuntu /home/ubuntu/.ssh

# Optional: Disable strict host key checking for internal network (security trade-off)
cat << 'EOL' > /home/ubuntu/.ssh/config
Host 10.0.*.*
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
EOL

chmod 600 /home/ubuntu/.ssh/config
chown ubuntu:ubuntu /home/ubuntu/.ssh/config