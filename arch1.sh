loadkeys ru
setfont cyr-sun16

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo '2.4 создание разделов'

echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
mkfs.fat -F32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
mkfs.ext4 /dev/nvme0n1p4

echo '2.4.3 Монтирование дисков'
swapon /dev/nvme0n1p2
mount /dev/nvme0n1p3 /mnt
mkdir /mnt/{boot,home}
mkdir /mnt/boot/EFI
mount /dev/nvme0n1p1 /mnt/boot/EFI
mount /dev/nvme0n1p4 /mnt/home

echo '3.1 Отсортируем зеркала'
pacman -Sy --noconfirm reflector
reflector --verbose -l 5 -p https --sort rate --save /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel linux linux-headers linux-firmware nano dhcpcd netctl

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(wget https://raw.githubusercontent.com/DymkaCat/arch-install-gpt/master/arch2.sh -O -)"
