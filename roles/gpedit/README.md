gpedit
======

This role allows you to edit local group policy.

Dependencies
------------

The role requires the local windows software repository to be present.

Example Playbook
----------------

Example of how to use the role in a playbook:
```yaml
---
- name: Execute role(s) for testing purposes
  hosts: HIS0126
  vars_files:
    - MyProject_vars.yaml

  roles:
    - role: <some role name>
    - role: gpedit
      vars:
        gpedit_target_policy_settings:
          - { user_dir: '$env:windir\System32\GroupPolicy\Machine\Registry.pol',
              reg_path: 'Software\Policies\Microsoft\Windows NT\CurrentVersion\Winlogon',
              reg_name: 'SyncForegroundPolicy',
              reg_data: '1',
              reg_type: 'DWord' }
    - role: <some other role name>
```

Example of how to use the role in a tasks file:
```yaml
- name: Set policy to wait for network before logon
  ansible.builtin.include_role:
    name: gpedit
  vars:
    gpedit_target_policy_settings:
      - { user_dir: '$env:windir\System32\GroupPolicy\Machine\Registry.pol',
          reg_path: 'Software\Policies\Microsoft\Windows NT\CurrentVersion\Winlogon',
          reg_name: 'SyncForegroundPolicy',
          reg_data: '1',
          reg_type: 'DWord' }
```

Author Information
------------------

Clememt Buurman
clement.buurman@yokogawa.com
