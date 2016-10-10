# badpermissions

Escalate example; Service|Process|Task bad permissions & hijackable Service path checker.

```bash
PS C:\bp> .\badpermissions.ps1

 _         _                      _         _
| |_ ___ _| |   ___ ___ ___ _____|_|___ ___|_|___ ___ ___
| . | .'| . |  | . | -_|  _|     | |_ -|_ -| | . |   |_ -|
|___|__,|___|  |  _|___|_| |_|_|_|_|___|___|_|___|_|_|___|
               |_|
__________________________________________________belane__

[i] Log file: BP_MSEDGEWIN10-noprivs.txt
[ ]
[i] Current User: noprivs
[+] Current User Membership
[ ] - Users
[ ] - TestGroup
[ ]
[+] Cheking 13 Process ...
[!]  Write rights: C:\Tools\macror.exe
[!]  Write rights: C:\Tools\putty.exe
[!]  Write rights: C:\Users\noprivs\AppData\Local\Titanapp\Titan.exe
[ ]
[+] Cheking 38 Services ...
[!]  Write rights: C:\Tools\vulnerable_service.exe
[!]  Write rights: C:\Program Files\KMSpico\Service_KMS.exe
[!]  Write rights: C:\Brand\SupportAssistAgent\bin\SupportAssist.exe
[!]  Unquoted path: C:\Program Files\TunVPN\TunVPN Client.exe
[!]  Unquoted path: C:\Program Files\Waves\MaxxAudio\WavesSysSvc64.exe
[ ]
[+] Cheking 39 Scheduled Tasks ...
[!]  Write rights: C:\Program Files\Microsoft Office\Office15\MsoSync.exe
[!]  Write rights: C:\Users\noprivs\AppData\Local\Titanapp\Update\TiUpdate.exe
[ ]
[ ]
[ ] Done

```


