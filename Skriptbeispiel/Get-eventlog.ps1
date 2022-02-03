[cmdletBinding()]
param(

[string]$Computername = "localhost",

[Parameter(Mandatory=$true)]
[int]$EventId,

[int]$Newest = 5
) 

#Zusätzliche Ausgabe die nur ausgegeben wird wenn das Skript mit dem Parameter -Verbose aufgerufen
Write-Verbose -Message "Vom user wurde übergeben: $Computername | $EventId | $Newest"

#Debug haltepunkt der nur benutzt wird wenn das Skript mit dem Paramter -Debug aufgerufen wird
Write-Debug -Message "Vor Abfrage"
Get-EventLog -LogName Security -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest

