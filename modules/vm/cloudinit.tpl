#cloud-config
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ${ssh_authorized_keys}
    lock_passwd: true
write_files:
  - path: /etc/timezone; content: | ${timezone}
  - path: /etc/hostname; content: | ${hostname}
package_update: true
runcmd:
  - ['timedatectl', 'set-timezone', '${timezone}']
  - ['sysctl', '-w', 'net.ipv4.ip_forward=1']
  - ['sysctl', '-w', 'net.ipv6.conf.all.forwarding=1']
