centum_vp
=========

This role installs Yokogawa CENTUM-VP. 


Requirements
------------

The role has been developed using CENTUM-VP R6.07.10, latest tested revision is R6.10.00.
Copy CENTUM-VP patches (original zipped format) to the "Images" repository as follows (example):
[path on your Ansible controller]/Images/CENTUM-VP/Updates/R6.10.00/R61003.zip.

Newer overall revisions of CENTUM-VP may need additional testing/debugging.

If you run this playbook against a Hyper-V VM and want to see what happens on the desktop, then make sure to use "Basic" session mode to display the VM. Do not use "Enhanced session" mode, because autologon is used during execution of the playbook and auologon does not work when using "Enhanced session" mode.

Role Variables
--------------

Variables to be set in MyProject_vars.yml:
  local_admin_autologon   [Set the credentials to use for autologon when not using a domain (AD)]
  domain_admin_autologon  [Set the credentials to use for autologon when using a domain (AD)]
  local_ctmvp_depot       [Location on the target computer where CENTUM-VP set-up files are stored]
  vnet_cidr_mask          [Subnet mask in CIDR notation for the Windows VnetIP adapter. Default = 16]

centum_vp_install:
  install_type: Install                           [Future use. For now; always keep at 'Install']
  package_type: '{{ vp_package_type }}'           [Set the package name to one of the following: HIS/ENG, UGS, SIOS or APCS. Default = HIS/ENG]
  cs3k_top_path: C:\CENTUMVP                      [Top folder where CENTUM-VP will be installed on the target comuter. Default = C:\CENTUMVP]
  location_of_project_database: "{{ hostvars[groups['CENTUM'][0]]['inventory_hostname_short'] }}"
                                                  [Each HIS needs a reference to the computer where the CENTUM-VP project database will be shared. The default setting uses the hostname of the first entry in the inventories CENTUM group.]
  console_type: "General PC"                      [Type of HIS. Valid options are: "General PC", "Open Style Console" or "Solid Style Console". Default = "General PC"]           
  touch_use: "0"                                  [If touch screen is used on the HIS, set to "1". Default = "0"]
  touch_confirm: "0"                              [If touch screen is used on the HIS, set to "1". Default = "0"]
  upper_panel: "0"                                [If upper panel touch screen is used on the HIS, set to "1". Default = "0"]
  lower_panel: "0"                                [If lower panel touch screen is used on the HIS, set to "1". Default = "0"]
  touch_set: "0"                                  [Always "0"]
  port_no: " "                                    [If touch screen is used on the HIS, set the port used for touch screen]
  install_vnetip_driver: "Yes"                    [Future use. For now; always keep at 'Yes']
  install_vnetip_open_driver: "Yes                [Future use. For now; always keep at 'Yes']
  opkb_driver: "No"                               [If operator keyboard (OPKB) is used, set to "Yes". Default = "No"]
  his_rs_driver: "No"                             [If HIS RS is used, set to "Yes". default = "No"]
  his_ras_driver: "No"                            [If HIS RAS card (housekeeping interface for HIS open console) is used, set to "Yes". Default = "No"]
  organization: Yokogawa                          [Set the name of the organization to be filled during CENTUM-VP setup. Default = Yokogawa]
  clean_up_auto_deployment_files: "Yes"           [Future use. For now; always keep at 'Yes']
  execute_it_security: "No"                       [Specify the choice at the end of CENTUM-VP set-up to run IT security tool. Default = "No", because IT-security tool
                                                   is later-on executed by Ansible.]

au3_vp_preinstall:
  title: YOKOGAWA CENTUM VP Setup                 [Do not change]
  installer_title: YOKOGAWA products installer    [Do not change]
  install_button: "&Install"                      [Do not change]
  ok_button: "&OK"                                [Do not change]
  no_button: "&NO"                                [Do not change]
  access_rights_ok_button: "OK"                   [Do not change]
  execute_it_security: 'false'                    [Do not change]

au3_vp_install:
  title: YOKOGAWA CENTUM VP Setup                 [Do not change]
  next_button: "&Next"                            [Do not change]
  cs3k_top_title: YOKOGAWA CENTUM VP Setup        [Do not change]
  change_button: "&Change..."                     [Do not change]
  install_button: "&Install"                      [Do not change]
  finish_button: "&Finish"                        [Do not change]
  delete_button: "&Remove"                        [Do not change]
  ok_button: "&OK"                                [Do not change]
  yes_button: "&YES"                              [Do not change]
  no_button: "&NO"                                [Do not change]
  opkb_port: " "                                  [Do not change]
  open_style_console: Open Style Console          [Do not change]
  solid_style_console: Solid Style Console        [Do not change]  
  pc: General PC                                  [Do not change]  
  upper_panel: Use upper part touch panel         [Do not change]
  lower_panel: Use lower part touch panel         [Do not change]
  not_execute_it_security: No. I want to install other software products.
                                                  [Do not change]
  reboot_later: No, I will restart my computer later.
                                                  [Do not change]
it_security:
  model: standard                                 [Specify the IT-security model. Valis options are: legacy, standard or strengthened. Default = standard]
  user_management: "{{ 'domain' if using_active_directory else 'standalone' }}"
                                                  ['domain' if Active Directory is used, 'standalone' if all computers are in a WORKGROUP. The default string chooses the user management model based on the using_active_directory variable, which is set in the projects vars file.]
  it_security_version: "2.0"                      [IT security version. Valid options: "1.0", "2.0". Default = "2.0"]
  title: IT Security Tool - Setup                 [Do not change]
  next_button_caption: "Next"                     [Do not change]
  confirm_settings_title: Confirm Setting Item    [Do not change]
  cancel_button_caption: "Cancel"                 [Do not change]
  restart_now_button_caption: "Restart now"       [Do not change]
  finish_button_caption: "Finish"                 [Do not change]
  dialog_title: IT Security Tool                  [Do not change]
  dialog_yes_button_caption: "&Yes"               [Do not change]
  legacy: Legacy Model                            [Do not change]
  standard: Standard Model                        [Do not change]
  strengthened: Strengthened Model                [Do not change]
  standalone: Standalone Management               [Do not change]
  domain: Domain Management                       [Do not change]
  combination: Combination Management             [Do not change]
  path: '{{ win_local_sw_depot }}\CENTUM-VP\{{ ctmvp_revision }}\CENTUM\SECURITY\Yokogawa.IA.iPCS.Platform.Security.ITSecurityTool.exe'
                                                  [Do not change]
  options: '/N /NM /R 3'                          [Do not change]
  restart: "No"                                   [Do not change]

Dependencies
------------

- role: win_local_sw_depot
- { role: vcredist, vcredist_versions: { 2022 } }
- role: opc_com_proxy_stub

Example Playbook
----------------

    ---
    - name: Deploy all CENTUM hosts
      hosts: CENTUM
      vars_files:
        - '/home/icss/git/IACS-Deployment/MyProject_vars.yaml'

      roles:
        - win_os_settings
        - { role: join_domain_other, when: using_active_directory }
        - yoko_win_settings
        - win_local_users
        - { role: centum_vp, ctmvp_revision: 'R6.10.00' }
        - { role: vsr , when: not using_active_directory } 
        - { role: trellix_ens, when: not using_active_directory } 
