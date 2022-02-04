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

Write-Progress -Id 0 -Activity "Erstellung TestFilesOrdner" -Status "TestFilesDir vorbereiten" -PercentComplete (100/4)

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

Write-Progress -Id 0 -Activity "Erstellung TestFilesOrdner" -Status "TestFilesDir vorbereiten" -PercentComplete ((100/4) * 2)
for($i = 1; $i -le $FileCount; $i++)
{
    Write-Progress -ParentId 0 -Id 1 -Activity "Erstellung Dateien Root" -Status "File $i von $Filecount" -PercentComplete ((100/$FileCount) * $i)

    #$FileBaseName + mit ["{0:D2}" -f ] wird an den Dateinamen eine 2 stellige Nummer angehängt
    $FileName = "$FileBaseName$("{0:D2}" -f $i).txt"
    New-Item -Path $TestFilesDir -Name $FileName -ItemType File
}

Write-Progress -Id 0 -Activity "Erstellung TestFilesOrdner" -Status "TestFilesDir vorbereiten" -PercentComplete ((100/4) * 3)
for($i = 1; $i -le $DirCount; $i++)
{
    Write-Progress -ParentId 0 -Id 1 -Activity "Erstellung Ordner" -Status "Ordner $i von $DirCount" -PercentComplete ((100/$Dircount) * $i)

    $DirName = "$DirBaseName$("{0:D2}" -f $i)"
    $dir = New-Item -Path $TestFilesDir -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileCount; $j++)
    {
        Write-Progress -ParentId 1 -Id 2 -Activity "Erstellung Dateien" -Status "File $j von $Filecount" -PercentComplete ((100/$FileCount) * $j)

        $FileName = "$FileBaseName$("{0:D2}" -f $j).txt"
        New-Item -Path $dir.FullName -Name $FileName -ItemType File
    }
}
Write-Progress -Id 0 -Activity "Erstellung TestFilesOrdner" -Status "TestFilesDir vorbereiten" -PercentComplete (100)