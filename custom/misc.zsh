# Ram disk
ramdisk() {
  sudo mkdir -p /media/ramdisk
  sudo mount -t tmpfs -o size=2048M tmpfs /media/ramdisk
  cd /media/ramdisk
}

check-font-styles() {
  echo -e "\e[1mbold\e[0m"
  echo -e "\e[3mitalic\e[0m"
  echo -e "\e[3m\e[1mbold italic\e[0m"
  echo -e "\e[4munderline\e[0m"
  echo -e "\e[4:3mundercurl\e[m"
  echo -e "\e[9mstrikethrough\e[0m"
  echo -e "\e[31mred\e[0m"
  echo -e "\x1B[31mred\e[0m"
}
