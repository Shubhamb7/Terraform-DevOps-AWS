#! /bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo hostnamectl set-hostname ${Name}
sudo apt-get install mysql-server -y