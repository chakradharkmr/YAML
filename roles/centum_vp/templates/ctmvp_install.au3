Func ControlWaitToEnable($title, $button, $function=Null, $wait=2000)
  Do
    If $function <> Null Then
      $function()
    EndIf
    Sleep($wait)
  Until(1 == ControlCommand($title, "", $button, "IsEnabled", ""))
EndFunc

Func ClickOkButton()
  ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.ok_button }}")
EndFunc

WinWait("{{ au3_vp_install.title }}")
WinActivate("{{ au3_vp_install.title }}")
WinWaitActive("{{ au3_vp_install.title }}")

WinWait("{{ au3_vp_install.title }}")
WinActivate("{{ au3_vp_install.title }}")
WinWaitActive("{{ au3_vp_install.title }}")

ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.next_button }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.next_button }}")

ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.change_button }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.change_button }}")

ControlWaitToEnable("{{ au3_vp_install.cs3k_top_title }}", "RichEdit20W1")
ControlSetText("{{ au3_vp_install.cs3k_top_title }}", "", "RichEdit20W1", "{{ centum_vp_install.cs3k_top_path }}")

ControlWaitToEnable("{{ au3_vp_install.cs3k_top_title }}", "{{ au3_vp_install.ok_button }}")
ControlClick("{{ au3_vp_install.cs3k_top_title }}", "", "{{ au3_vp_install.ok_button }}")

WinWait("{{ au3_vp_install.title }}")
WinActivate("{{ au3_vp_install.title }}")
WinWaitActive("{{ au3_vp_install.title }}")

ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.next_button }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.next_button }}")

; package type
ControlWaitToEnable("{{ au3_vp_install.title }}", "ComboBox1")
ControlCommand("{{ au3_vp_install.title }}", "", "ComboBox1", "SelectString", "{{ centum_vp_install.package_type }}")

; db location
{% if centum_vp_install.package_type == 'HIS/ENG' or centum_vp_install.package_type == 'UASS' %}
ControlWaitToEnable("{{ au3_vp_install.title }}", "RichEdit20W1")
ControlSetText("{{ au3_vp_install.title }}", "", "RichEdit20W1", "{{ centum_vp_install.location_of_project_database }}")
{% endif %}

; console type
ControlWaitToEnable("{{ au3_vp_install.title }}", "ComboBox2")
ControlCommand("{{ au3_vp_install.title }}", "", "ComboBox2", "SelectString", "{{ centum_vp_install.console_type }}")

; port number
{% if centum_vp_install.package_type == 'HIS/ENG' and centum_vp_install.console_type == '3' %}
ControlWaitToEnable("{{ au3_vp_install.title }}", "ComboBox3")
ControlCommand("{{ au3_vp_install.title }}", "", "ComboBox3", "SelectString", "{{ au3_vp_install.opkb_port }}")
{% endif %}

{% if centum_vp_install.console_type == 2 %}
; upper panel
{%   if centum_vp_install.upper_panel == 1 %}
ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.upper_panel }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.upper_panel }}")
{%   endif %}

; lower panel
{%   if centum_vp_install.lower_panel == 1 %}
ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.lower_panel }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.lower_panel }}")
{%   endif %}
{% endif %}

ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.next_button }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.next_button }}")

ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.install_button }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.install_button }}")

{% if centum_vp_install.execute_it_security == 'No' %}
ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.not_execute_it_security }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.not_execute_it_security }}")
{% endif %}

ControlWaitToEnable("{{ au3_vp_install.title }}", "{{ au3_vp_install.finish_button }}")
ControlClick("{{ au3_vp_install.title }}", "", "{{ au3_vp_install.finish_button }}")
