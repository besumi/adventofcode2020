[CmdletBinding()]
param()

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$joltageDifferences = ""
$joltageVariations = [PSCustomObject]@{
    1 = 1
    2 = 2
    3 = 4
    4 = 7
    5 = 13
}

$rawInput = Get-Content .\input.txt | ForEach-Object { [int]$_ } | Sort-Object
$firstNumber = 0

foreach ($number in $rawInput)
{
    If ($number-$firstNumber -eq 1) {
        $joltageDifferences = "$($joltageDifferences)1"
    }
    Else {
        $joltageDifferences = "$($joltageDifferences)3"
    }

    $firstNumber = $number
}

Write-Verbose $joltageDifferences
$groupings = ($joltageDifferences -split '3') | Group-Object -Property Length
$total = 1

Foreach ($group in $groupings) {
    If ($group.Name -ne "0" -and $group.Name -ne "1") {
        $count = $group.Count
        Write-Verbose "$($group.Name): $count"
        $multiplier = $joltageVariations.($group.Name)
        Write-Verbose "Multiplier: $multiplier"
        If ($multiplier -gt 0) {
            $total *= [System.Math]::Pow($multiplier, $count)
        }
        Else {
            throw "No multiplier for $($group.Name)"
        }
    }
}

$total