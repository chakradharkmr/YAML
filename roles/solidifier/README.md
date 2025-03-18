# Solidifier

This role will install solidifier (whitelisting software) and solidify the target system(s). The role is OS aware and will install and configure Solidifier based on the OS of the target machine (Windows 10 or Windows Server).

This playbook should be run at the end of a deployment.

## Installation steps

The following steps will be performed:

1. Create a Solidifier folder under the Yokogawa software repository.
2. Download the Solidifier application (Server/Client depending on OS version).
3. Install the Solidifier application (Server/Client depending on OS version).
4. Configure the scripting whitelist rules.
5. Configure parameters as described in the Whitelisting manual.
6. Configure WL_Config and solidifying the system.
7. Install the .bat patches that are required for the System to ensure proper functionality.

It is important that the target node is not rebooted during this process. Furthermore, the machine will automatically reboot after step 5 in order to prepare for step 6, this is the only exception to the no reboot rule. The completion time varies with the amount of available storage. For example, a 100GB Disk may be solidified in about 20 to 30 minutes, whereas a machine with 1TB can take over 90 minutes up to 2 hours. Do not cancel this process under any circumstance and let the machine finish solidifying it's disk drive.
