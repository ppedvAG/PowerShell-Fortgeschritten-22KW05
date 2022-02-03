<#
.SYNOPSIS
Kurzbeschreibung: Abfrage von Events
.DESCRIPTION
Lange Beschreibung: Abfrage von An und Abmeldebezogenen Events.
.PARAMETER EventId
Folgende Werte sind möglich:
4624 | Anmeldung
4625 | fehlgeschlagene Anmeldung
4634 | Abmeldung
.EXAMPLE
Get-eventlog.ps1 -EventId 4634 -Newest 3

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   10119 Feb 03 14:05  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   10116 Feb 03 14:04  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   10113 Feb 03 14:04  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....

   Bie dieser Ausführung werden die aktuellesten 3 AbmeldeEvents ausgegeben
.EXAMPLE
weiteres Beispiel
.LINK
https://docs.microsoft.com/de-de/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1
#>
[cmdletBinding()]
param(
[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTcpPort WinRM -InformationLevel Quiet})]
[string]$Computername = "localhost",

[ValidateSet(4624,4625,4634)]
[Parameter(Mandatory=$true)]
[int]$EventId,

[ValidateRange(2,10)]
[int]$Newest = 5,

[ValidateLength(3,10)]
[string]$OutputfileName = "File"
) 
$Newest = 1
#Zusätzliche Ausgabe die nur ausgegeben wird wenn das Skript mit dem Parameter -Verbose aufgerufen
Write-Verbose -Message "Vom user wurde übergeben: $Computername | $EventId | $Newest"

#Debug haltepunkt der nur benutzt wird wenn das Skript mit dem Paramter -Debug aufgerufen wird
Write-Debug -Message "Vor Abfrage"

Get-EventLog -LogName Security -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest

