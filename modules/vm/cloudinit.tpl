#cloud-config
users:
  - name: ubuntu
    ssh_authorized_keys:
      - 
    lock_passwd: true
write_files:
  - path: /etc/timezone
    content: 
  - path: /etc/hostname
    content: 
package_update: true
runcmd:
  - ['timedatectl', 'set-timezone', '']
  - ['sysctl', '-w', 'net.ipv4.ip_forward=1']
  - ['sysctl', '-w', 'net.ipv6.conf.all.forwarding=1']
