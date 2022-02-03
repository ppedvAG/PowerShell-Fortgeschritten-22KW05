# WMI / CIM Mögliche Lösung
1.
```powershell
#CIM
 Get-CimClass -Namespace root\cimv2
#WMI
Get-WmiObject -NameSpace root\CIMv2 -List
```

2.
```powershell
#CIM
Get-CimInstance -ClassName Win32_DisplayConfiguration
#WMI
Get-WmiObject -Class Win32_Battery
```

3.
```powershell
Get-CimInstance -Classname Win32_OperatingSystem | Format-List -Property *
```

4.
```powershell
$session = New-CimSession -Computername Member1
Get-CimInstance -CimSession $session -ClassName Win32_LogicalDisk
```