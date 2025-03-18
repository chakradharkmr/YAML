SHCT
=========

Prepares SHCT on the system.

Requirements
------------

Also make sure that the SHCT role is added to the centum_vp.yml file of the centum-vp playbook, like so:

  roles:
    - win_os_settings
    - { role: join_domain_other, when: using_active_directory }
    - yoko_win_settings
    - win_local_users
    - { role: centum_vp, ctmvp_revision: 'R6.09.00' }
    - { role: vsr, when: not using_active_directory }
    - { role: trellix_ens, when: not using_active_directory }
    - { role: shct, when: is_shct_server }                    <== here it is.

Role Variables
--------------

System-ID needs to be manually set in the project vars file (MyProject_vars.yaml) before executing the CENTUM-VP playbook (centum_vp.yml).
The 'system_id' variable is located under the '=== SHCT ===' heading in 'MyProject_vars.yaml'.
To allow SHCT to collect data from network equipment via SNMP, make sure that you complete the following section in 'MyProject_vars.yaml':
=== NETWORK EQUIPMENT SETTINGS ===

Dependencies
------------

Currently only developed for use with CENTUM-VP systems.

Example Playbook
----------------

Example of how to use in a playbook:

    - hosts: servers
      roles:
         - { role: shct }

Author Information
------------------

Clement Buurman
clement.buurman@yokogawa.com
