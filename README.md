# badpermissions

Escalate example. Service|Process|Task bad permissions checker.

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
[!]  Found vulnerable: C:\Tools\macror.exe
[!]  Found vulnerable: C:\Tools\putty.exe
[ ]
[+] Cheking 38 Services ...
[!]  Found vulnerable: C:\Tools\vulnerable_service.exe
[!]  Found vulnerable: C:\Program Files\KMSpico\Service_KMS.exe
[ ]
[+] Cheking 39 Scheduled Tasks ...
[!]  Found vulnerable: C:\Program Files\Microsoft Office\Office15\MsoSync.exe
[ ]
[ ]
[ ] Done

```


