[cmdletBinding()]
param(
    [Parameter(ParameterSetName="Display")]
    [switch]$OutDisplay,

    #Kommentar
    [ValidateRange(0,16)]
    [Parameter(ParameterSetName="Display", Mandatory = $true)]
    [Parameter(ParameterSetName="File", Mandatory = $false)]
    [int]$intColor,

    [Parameter(ParameterSetName="File")]
    [switch]$OutFile,

    [Parameter(ParameterSetName="File")]
    [string]$Path
)