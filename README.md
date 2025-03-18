# Y-dPloy

Y-dPloy is an Ansible implementation that aims to automate Yokogawa automation systems deployment.

## Installation

The Ansible environment used for Y-dPloy is developed and tested on a VM called 'AnsibleVM'.

You can receive a copy of 'AnsibleVM', or create your own Ansible controller as follows;  
Install Ubuntu 23.04 (on a Hyper-V VM).  
Hostname:	AnsibleVM  
NIC1:		Internet access (default)  
NIC2:		Deployment network, IP-address 172.17.1.222/24.  
Install Ansible on it according to the Ansible online documentation;  
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-ubuntu  
Request access to the Y-dPloy repository on Gitlab.  
Clone the Y-dPloy repository into /home/users/icss/git/<repository folder name>;
Tell git who you are (any changes you make in the code will be registered under your name in git)

```bash
git config --global user.email "your e-mail address in gitlab"
git config --global user.name "your user name in gitlab"
```

```bash
cd /home/users/icss/git
git init
git clone <repository clone url>
```
Add local bin path to $PATH variable:

```bash
PATH=$PATH:/home/icss/.local/bin
```
Install ansible-lint, pykeepass and pywinrm:

```bash
cd /home/users/icss/git/IACS-Deployment
python3 -m pip install --user ansible-lint
pip install 'pykeepass==4.0.3' --user
pip install "pywinrm>=0.3.0" --user
pip3 install pycryptodomex
```
Install ansible galaxy collections:

```bash
ansible-galaxy collection install viczem.keepass
ansible-galaxy collection install fortinet.fortios
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install ansible.windows
ansible-galaxy collection install ansible.utils
ansible-galaxy collection install ansible.netcommon
ansible-galaxy collection install community.windows
ansible-galaxy collection install community.zabbix
ansible-galaxy role install geerlingguy.mysql
ansible-galaxy role install geerlingguy.apache
ansible-galaxy role install geerlingguy.php
```

Install and configure samba:

```bash
sudo apt install samba
sudo systemctl enable --now smbd
sudo ufw allow samba
sudo usermod -aG sambashare $USER
sudo smbpasswd -a $USER
sudo smbpasswd -e $USER
sudo mkdir /samba/users/Images
sudo chgrp -R icss:sambashare /samba/users/Images
sudo chmod 2770 /samba/users/Images
sudo apt-get install sshpass
sudo nano /etc/samba/smb.conf
```
Add to the end of the file:
```ini
# Y-dPLoy Images share
[share]
   path = /samba/users/Images
   writable = yes
   guest ok = yes
   guest only = yes
   read only = no
   create mode = 755
   directory mode = 755
   browsable = yes
```
Save the file, then restart samba service:
```bash
sudo systemctl restart smbd
```
Copy the software depot (connect to PNSD lab network using Barracuda VPN client):
```bash
from: \\192.168.5.210\Images
to: \\<ansible_ip>\share    [/samba/users/Images]
```

## Usage
Connect AnsibleVM to the network of the target system to be deployed.  
Default IP-addresses are in subnet 172.17.1.0/24.  

Login to AnsibleVM (you can use Putty and SHH) as user 'icss'.
Install the ansible.windows module:

```bash
cd git/<repository folder name>
```

Edit project inventory, variable and master playbook to match your project design.  
Then run playbooks as follows:  
 
```bash
cd git/<repository folder name>
ansible-playbook -i <inventory file name> <project playbook file name>
```

Example:
```bash
cd git/IACS-Deployment
ansible-playbook -i MyProject-inventory.ini MyProject-playbook.yml
```

## Contributing
Pull requests are welcome.   
For major changes, please open an issue first to discuss what you would like to change.


## License
Yokogawa propriatary development.  
Yokogawa internal use only.
