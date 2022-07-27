#! /bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo hostnamectl set-hostname ${Name}
echo "<h1>WEB SERVER</h1>" > index.html
python3 -m http.server 8000 &