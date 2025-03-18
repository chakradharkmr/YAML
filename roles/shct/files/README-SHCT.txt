SHCT - SNMP
~~~~~~~~~~~

Introduction
~~~~~~~~~~~~
SHCT uses a tool (TWSNMP v4) to read data from SNMP enabled equipment in the system.
Preferably use SNMPv3 to configure this.

Requirements
~~~~~~~~~~~~
- Visual C++ Redistributable 2008 must be installed on the SHCT center station (done by Y-dPloy (Ansible)).
- SHCT Setup must be executed on the SHCT center station (done by Y-dPloy (Ansible)).
- The file "C:\SHCT\Program\cnf\SHCTSNMP.cnf" must be manually edited as per SHCT Manual (done by Y-dPloy (Ansible)).
- Target Hirschmann switches must be configured for SNMP access by SHCT, an example configuration is provided below.

Hirschmann switch configuration example
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

! #### beginning of example configuration section ####

! Configure prompt
set prompt "SW0101"

! Configure a network management vlan
vlan database
vlan  30
vlan name 30 "MGMT"
exit

! Configure network management access 
network parms 192.168.1.1 255.255.255.0 0.0.0.0
network mgmt_vlan 30
!RMA operation
network mgmt-access operation enable
!RMA entry
network mgmt-access modify 1 ip 192.168.1.0
network mgmt-access modify 1 mask 255.255.255.0
network mgmt-access modify 1 http disable
network mgmt-access modify 1 https enable
network mgmt-access modify 1 snmp enable
network mgmt-access modify 1 telnet disable
network mgmt-access modify 1 ssh enable
network mgmt-access status 1 enable
no ip http server
ip https server
ip ssh

Configure
! Configure general SNMP settings
snmp-server sysname "SW0101"
snmp-server location "MCR - Auxiliary room"
snmp-server contact "YEF-NL-DL-Operations-OT-Security@yokogawa.com"

! Configure the interface that is used for network management, use the network management VLAN
interface  1/1 
name "MGMT"
vlan pvid 30 
vlan participation exclude 1 
vlan participation include 30 
exit

! Configure SNMPv3 access
snmp-access global enable
snmp-access version v1 disable
snmp-access version v2 disable
snmp-access version v3 enable
snmp-access radius-authenticate disable
snmp-access version v3-encryption readonly enable
snmp-access version v3-encryption readwrite disable
no snmp-server community public
no snmp-server community private

! Configure the SNMP user (the username "user" is used in this example)
users name user
users passwd user :v1:bf458614d778fbcdaee14b95f1ef25276164329006a8a41279e2d6061ef85f12:
users snmpv3 authentication user md5
users snmpv3 encryption user des :v1:bf458614d778fbcdaee14b95f1ef25276164329006a8a41279e2d6061ef85f12:
users login user defaultList
users access user readonly
users snmpv3 accessmode user readonly

! the :v1:....: strings are encryption hash of the actual password
! manually set the password using the following commands:

! Disable telnet access
lineconfig
no transport input telnet
exit

! Save the changes
exit
copy system:running-config nvram:startup-config

! #### end of example configuration section ####

Note 1
Some settings may be the default, such as the readonly settings for the default user "user". 
Default settings are not listed in the output of the "show running-config" command.

Note 2
Use the following commands to manually configure a user with another username, such as"mysnmpuser" for SNMP-v3 access:

users passwd mysnmpuser <<enter old (nothing) and new passwords manually when prompted>>
users snmpv3 authentication mysnmpuser md5
users snmpv3 encryption mysnmpuser des <<enter encryption key manually when prompted>>
users access mysnmpuser readonly
users snmpv3 accessmode mysnmpuser readonly

Example contents of SHCTSNMP.cnf
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 [TOOLPATH]
 SNMPToolExecutePath=..\bin\SNMP
 [192.168.1.1]
 SNMPMode=3
 Community=user
 UserID=user
 Password=484936642B796C6B2B545A2F42335A4E4737385A7333743867502F6E387A7777486873346159416F724751586D635442625737395351503530547864574A4557

Please note that this file is automatically configured when using Y-dPloy (Ansible).
Concerning the "Password=" entry:
The encrypted password string can be manually generated using:
C:\SHCT\Program\Script\SHCTSNMP.exe -E <<your_snmp_user_passwordstring>>

Troubleshooting
~~~~~~~~~~~~~~~
SHCT uses an executable called "Spnms.exe" which belongs to TWSNMP.
"Spnms.exe" can be used to test SNMP access to your network device from the SHCT center station.
Version 4 (archived): 	https://lhx98.linkclub.jp/twise.co.jp/
Version 5: 		https://github.com/twsnmp/twsnmp (not used in SHCT, just mentioned for reference)
The tool is developed in Japanese, an English version was not found.
In SHCT, it is located under "C:\SHCT\Program\bin\SNMP".
The version of the "Spnms.exe" executable that is used in SHCT R4.01.02 is 4.8.0.0.
Command syntax (SHCT uses the same syntax to gather data):
Spnms.exe [/S SNMP version] [Target IP-address] [SNMP username] [SNMP Password] "[Path to output folder]"

[SNMP version]:
Valid values: integer [1-5]
1： SNMPv2c
2： SNMPv3 Hash: MD5
3： SNMPv3 Hash: MD5 Encryption: DES
4： SNMPv3 Hash: SHA
5： SNMPv3 Hash: SHA Encryption: AES

Note:
In combination with Hirschmann switches, only option 1 or 3 can be used.
Option 3 is the most secure and preferred option.

Example:
cd /d C:\SHCT\Program\bin\SNMP
Spnms.exe /S 3 192.168.1.1 user @MySecretPassword@ "C:\SHCT\Data\VP123456"

Notes:
- This will produce a raw .txt file (SNMP dump) under "C:\SHCT\Data\VP123456". 
- It may take a few minutes for the file to be created. Be patient before starting other attempts.
- When executed by SHCT, SHCTSNMP.exe will convert the .txt file to a .csv file.