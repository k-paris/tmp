#cloud-config
hostname: ${hostname}
ssh_pwauth: true
password: ${plain_password}
chpasswd:
  expire: false
  list:
    - ${username}:${plain_password}
users:
  - default
  - name: ${username}
    lock_passwd: false
    plain_text_passwd: '${plain_password}'
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: sudo
    shell: /bin/bash

runcmd:
  - sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
  - systemctl restart ssh