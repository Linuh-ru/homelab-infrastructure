#!/bin/bash
# 1. Задаём переменные
TEMPLATE_ID=9000
VM_NAME="ubuntu-22.04-cloudinit"
STORAGE="local-lvm" # имя хранилища в Proxmox

# 2. Скачиваем официальный Ubuntu Cloud Image
wget -O ubuntu.img https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img

# 3. Создаём виртуалку
qm create $TEMPLATE_ID --name $VM_NAME --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0 --ostype l26

# 4. Импортируем образ как жёсткий диск
qm importdisk $TEMPLATE_ID ubuntu.img $STORAGE

# 5. Привязываем диск, включаем Cloud-Init
qm set $TEMPLATE_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE:vm-$TEMPLATE_ID-disk-0,discard=on
qm set $TEMPLATE_ID --ide2 $STORAGE:cloudinit
qm set $TEMPLATE_ID --boot c --bootdisk scsi0
qm set $TEMPLATE_ID --serial0 socket --vga serial0
qm set $TEMPLATE_ID --agent 1

# 5.1 Расширяем диск (по умолчанию образ ~2 ГБ)
qm resize $TEMPLATE_ID scsi0 +18G

# 5.2 Базовая настройка Cloud-Init
qm set $TEMPLATE_ID --ipconfig0 ip=dhcp
# Раскомментируйте и подставьте свой ключ:
# qm set $TEMPLATE_ID --ciuser ubuntu --sshkey "$(cat ~/.ssh/id_rsa.pub)"

# 6. Превращаем виртуалку в шаблон
qm template $TEMPLATE_ID

# 7. Удаляем скачанный образ
rm ubuntu.img
echo "Готово! Шаблон с ID $TEMPLATE_ID успешно создан!"
