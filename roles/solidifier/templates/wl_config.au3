; Run WLConfig
#RequireAdmin

Run ("{{ solidifier_depot }}\WL_Config\WL_Config.exe")

WinGetProcess ("WL Configuration Tool Ver:2.18.0.2")
WinWaitActive ("WL Configuration Tool Ver:2.18.0.2")
ControlClick ("WL Configuration Tool Ver:2.18.0.2", "Whitelist Creation", "[CLASS:Button; INSTANCE:2]")


WinGetProcess ("WL Configuration Tool Ver:2.18.0.2")
WinWaitActive ("WL Configuration Tool Ver:2.18.0.2")
ControlClick ("WL Configuration Tool Ver:2.18.0.2", "Default Registration", "[CLASS:Button; INSTANCE:3]")


WinGetProcess ("WL Configuration Tool Ver:2.18.0.2")
WinWaitActive ("WL Configuration Tool Ver:2.18.0.2")
ControlClick ("WL Configuration Tool Ver:2.18.0.2", "Register", "[CLASS:Button; INSTANCE:6]")


WinGetProcess ("Confirm")
WinWaitActive ("Confirm")
ControlClick ("Confirm", "OK", "[CLASS:Button; INSTANCE:1]")


WinGetProcess ("Whitelist Creation")
WinWaitActive ("Whitelist Creation")
ControlClick ("Whitelist Creation", "OK", "[CLASS:Button; INSTANCE:2]")


WinGetProcess ("Whitelist Creation")
WinWaitActive ("Whitelist Creation")
Send("{Enter}")


WinGetProcess ("WL Configuration Tool Ver:2.18.0.2")
WinWaitActive ("WL Configuration Tool Ver:2.18.0.2")
ControlClick ("WL Configuration Tool Ver:2.18.0.2", "Exit", "[CLASS:Button; INSTANCE:21]")


WinGetProcess ("Confirm")
WinWaitActive ("Confirm")
ControlClick ("Confirm", "OK", "[CLASS:Button; INSTANCE:1]")
