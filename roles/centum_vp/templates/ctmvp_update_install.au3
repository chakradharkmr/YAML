Func ControlWaitToEnable($title, $button, $wait=2000)
  Do
    Sleep($wait)
  Until(1 == ControlCommand($title, "", $button, "IsEnabled", ""))
EndFunc

Local $Title = "YOKOGAWA CENTUM VP Setup"

WinWait($Title)
WinActivate($Title)
WinWaitActive($Title)

ControlWaitToEnable($Title, "&Install")
ControlClick($Title, "", "&Install")

{% if vp_update_reboot.stat.exists %}
ControlWaitToEnable($Title, "No, I will restart my computer later.")
ControlClick($Title, "", "No, I will restart my computer later.")
{% endif %}

ControlWaitToEnable($Title, "&Finish")
ControlClick($Title, "", "&Finish")