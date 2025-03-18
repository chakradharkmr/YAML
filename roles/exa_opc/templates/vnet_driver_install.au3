Func ControlWaitToEnable($title, $button, $function=Null, $wait=2000)
  Do
    If $function <> Null Then
      $function()
    EndIf
    Sleep($wait)
  Until(1 == ControlCommand($title, "", $button, "IsEnabled", ""))
EndFunc

Func WinWaitAndActive($title)
  WinWait($title)
  WinActivate($title)
  WinWaitActive($title)
EndFunc

$title = "Vnet Driver Setup"

WinWaitAndActive($title)
ControlWaitToEnable($title, "OK")
ControlClick($title, "", "OK")

WinWaitAndActive($title)
ControlWaitToEnable($title, "OK")
ControlClick($title, "", "OK")

WinWaitAndActive($title)
ControlWaitToEnable($title, "OK")
ControlClick($title, "", "OK")