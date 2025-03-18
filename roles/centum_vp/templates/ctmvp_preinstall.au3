#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>

$YOKOGAWA_CENTUM_VP_SETUP = "{{ au3_vp_preinstall.title }}"
$YOKOGAWA_PRODUCTS_INSTALLER = "{{ au3_vp_preinstall.installer_title }}"

While 1
  If IsWindowVisible($YOKOGAWA_CENTUM_VP_SETUP) Then
    If ControlClick($YOKOGAWA_CENTUM_VP_SETUP, "", "[CLASS:Button; TEXT:{{ au3_vp_preinstall.install_button }}]") Then
	  ExitLoop
	EndIf
  EndIf

  If IsWindowVisible($YOKOGAWA_PRODUCTS_INSTALLER) Then
    If ControlClick($YOKOGAWA_PRODUCTS_INSTALLER, "", "[TEXT:{{ au3_vp_preinstall.access_rights_ok_button }}]") Then
	  Exit
	EndIf
  EndIf
  
  Sleep(1000)
WEnd

While 1
  If IsWindowVisible($YOKOGAWA_CENTUM_VP_SETUP) Then
    If ControlClick($YOKOGAWA_CENTUM_VP_SETUP, "", "[CLASS:Button; TEXT:{{ au3_vp_preinstall.no_button }}]") Then
	  ExitLoop
	EndIf
  EndIf

  If IsWindowVisible($YOKOGAWA_PRODUCTS_INSTALLER) Then
    WinActivate($YOKOGAWA_PRODUCTS_INSTALLER)
    If ControlClick($YOKOGAWA_PRODUCTS_INSTALLER, "", "[TEXT:{{ au3_vp_preinstall.access_rights_ok_button }}]") Then
	  ExitLoop
	EndIf
  EndIf
  
  Sleep(1000)
WEnd

Func IsWindowVisible($title)
  return BitAND(WinGetState($title), $WIN_STATE_VISIBLE)
EndFunc
