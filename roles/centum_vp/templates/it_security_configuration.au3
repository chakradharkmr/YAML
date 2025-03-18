#include <GuiComboBox.au3>

Func ControlWaitToEnable($title, $control, $function=Null, $wait=2000)
  Do
    If $function <> Null Then
      $function()
    EndIf
    Sleep($wait)
  Until(1 == ControlCommand($title, "", $control, "IsEnabled", ""))
EndFunc

Func ClickCancelButton()
  ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.cancel_button_caption }}]")
EndFunc

WinWait("{{ it_security.title }}")
WinActivate("{{ it_security.title }}")
WinWaitActive("{{ it_security.title }}")

{% if it_security.it_security_version == '1.0' %}
Sleep(1000)
send("{UP}")
{% endif %}

{% if it_security.model == 'legacy' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.legacy }}]")
{% endif %}
{% if it_security.model == 'standard' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.standard }}]")
{% endif %}
{% if it_security.model == 'strengthened' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.strengthened }}]")
{% endif %}
{% if not it_security.model == 'legacy' %}
{%   if it_security.user_management == 'standalone' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.standalone }}]")
{%   endif %}
{%   if it_security.user_management == 'domain' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.domain }}]")
{%   endif %}
{%   if it_security.user_management == 'combination' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.combination }}]")
{%   endif %}
{% endif %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.next_button_caption }}]")

{% if it_security.it_security_version == '2.0' %}
WinWait("{{ it_security.dialog_title }}")
WinActivate("{{ it_security.dialog_title }}")
WinWaitActive("{{ it_security.dialog_title }}")

ControlClick("{{ it_security.dialog_title }}", "", "[TEXT:{{ it_security.dialog_yes_button_caption }}]")
{% endif %}

WinWait("{{ it_security.title }}")
WinActivate("{{ it_security.title }}")
WinWaitActive("{{ it_security.title }}")

ControlWaitToEnable("{{ it_security.title }}", "[TEXT:{{ it_security.finish_button_caption }}]", ClickCancelButton)
{% if it_security.restart == 'No' %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.restart_now_button_caption }}]")
{% endif %}
ControlClick("{{ it_security.title }}", "", "[TEXT:{{ it_security.finish_button_caption }}]")
