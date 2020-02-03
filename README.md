# LogOffDisconnectedDisabledUsers
Log off disconnected users from a server when they are disabled.  Use in conjunction with a scheduled task.


This script was designed because there was some servers where the group policy setting "Set time limit for disconnected sessions" was not the optimal solution.

I still prefer this group policy setting which can be found:
Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Services > Remote Desktop Session Host > "Set time limit for disconnected sessions"

To run this, because it is not signed and assuming there is an execution policy in place:

powershell -ExecutionPolicy Bypass ./LogOffDisconnectedDisabledUsers.ps1
