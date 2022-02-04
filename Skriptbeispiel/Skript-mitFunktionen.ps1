[cmdletBinding(PositionalBinding=$false)]
param(
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[Parameter(Mandatory=$true, Position=0)]
[string]$Path,

[ValidateRange(1,99)]
[int]$DirCount = 3,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateLength(1,10)]
[string]$TestFilesDirName = "TestFiles",

[ValidateLength(1,10)]
[string]$DirBaseName = "Ordner",

[ValidateLength(1,10)]
[string]$FileBaseName = "Datei",

[switch]$force
)
if($Path.EndsWith("\") -ne $true)
{
    $Path += "\"
}

#Funktionen deklarieren
function New-TestFiles
{
[cmdletBinding()]
param(
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[Parameter(Mandatory=$true, Position=0)]
[string]$Path,

[ValidateRange(1,99)]
[int]$FileCount = 9,

[ValidateLength(1,10)]
[string]$FileBaseName = "Datei",

[switch]$force
)

$files = Get-ChildItem -Path $Path -File 
if(($files | Measure-Object).Count -ne 0)
{
    if($force)
    {
        $files | Remove-Item -Force
    }
    else
    {
        throw "Der ordner beeinhalten bereits Dateien"
    }

    for($i = 1; $i -le $FileCount; $i++)
    {
        #$FileBaseName + mit ["{0:D2}" -f ] wird an den Dateinamen eine 2 stellige Nummer angehängt
        $FileName = "$FileBaseName$("{0:D2}" -f $i).txt"
        New-Item -Path $Path -Name $FileName -ItemType File
    }
}
}
#endFuntkion


$TestFilesDir = ($Path + $TestFilesDirName)

if(Test-Path -Path $TestFilesDir)
{#Handling wenn Ordner vorhanden ist
    Write-Verbose -Message "Ordner: $TestFilesDirName war bereits vorhanden"
        
    if($force)
    {  
        Write-Verbose -Message "Ordnerinhalt wird gelöscht"
        Get-ChildItem -Path $TestFilesDir | Remove-Item -Force -Recurse
    }
    else
    {
        throw "Ordner bereits vorhanden. Ziehen Sie in Betracht den Paramter -Force zu verwenden"
    }
}
else
{# Wenn Ordner nicht vorhanden ist anlegen
    $TestFilesDir = (New-Item -Path $Path -Name $TestFilesDirName -ItemType Directory).FullName 
}

#Verwendung der eigenen Funktion
New-TestFiles -Path $TestFilesDir -FileCount $FileCount -FileBaseName $FileBaseName -force:$force

for($i = 1; $i -le $DirCount; $i++)
{
    $DirName = "$DirBaseName$("{0:D2}" -f $i)"
    $dir = New-Item -Path $TestFilesDir -Name $DirName -ItemType Directory

    New-TestFiles -Path $dir.FullName -FileCount $FileCount -FileBaseName $FileBaseName -force:$force
}