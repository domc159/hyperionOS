#!/bin/bash

# Preveri, ali je skripta zagnana kot root
if [ "$EUID" -ne 0 ]; then
  echo "Prosimo, zaženite skripto kot root."
  exit 1
fi

# Posodobi sistemski paketni seznam
echo "Posodabljam sistemski paketni seznam..."
pacman -Syu --noconfirm

# Namesti pakete iz PKGlist.txt
echo "Nameščam pakete iz PKGlist.txt..."
if [ -f PKGlist.txt ]; then
  pacman -S --noconfirm - < PKGlist.txt
else
  echo "Datoteka PKGlist.txt ne obstaja!"
  exit 1
fi

# Kopiraj vsebino mape ETC v /etc
echo "Kopiram vsebino mape ETC v /etc..."
if [ -d ETC ]; then
  cp -r ETC/* /etc/
else
  echo "Mapa ETC ne obstaja!"
fi

# Kopiraj vsebino mape USR v /usr
echo "Kopiram vsebino mape USR v /usr..."
if [ -d USR ]; then
  cp -r USR/* /usr/
else
  echo "Mapa USR ne obstaja!"
fi

# Kopiraj vsebino mape config v ~/.config
echo "Kopiram vsebino mape config v ~/.config..."
if [ -d config ]; then
  mkdir -p ~/.config
  cp -r config/* ~/.config/
else
  echo "Mapa config ne obstaja!"
fi

echo "Namestitev in konfiguracija je zaključena!"
