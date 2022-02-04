[cmdletBinding()]
param(

)
class Fahrzeug
{
    [int]$Sitzplätze
}

class Auto : Fahrzeug
{
    [string]$Marke
    [string]$Model
    [int]$AnzahlReifen
    [double]$PS   
    [Antriebsart]$Antrieb

    Auto()
    {
    }

    Auto([string]$Model)
    {
        $this.Model = $Model
    }

    fahre([int]$Fahrstrecke)
    {
        for($i = 0; $i -lt $Fahrstrecke; $i++)
        {
            #Clear-Host
            [string] $Ausgabe = ("-" * $i) + "🚗"
            Write-Host -Object $Ausgabe
        }
    }
    [string]ToString()
    {
        return $this.Marke + " | " + $this.Model
    }
}

enum Antriebsart
{
    Undefined
    Elektrisch
    Hybrid
    Benzin
    Diesel
    Wasserstoff = 10
}

[Auto]$BMW = New-Object -TypeName Auto
$BMW.Marke = "BMW"
$BMW.Antrieb = 3
$BMW.AnzahlReifen = 4
$BMW.Sitzplätze = 5
$BMW.Model = "F31"
$BMW.PS = 252

return $BMW