[CmdletBinding()]
param()

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$rawInput = Get-Content .\input.txt
[System.Collections.ArrayList]$passes = @()

Foreach ($line in $rawInput) {
    $pass = .$executingScriptDirectory\Get-BoardingPassData.ps1 -RawData $line
    $null = $passes.Add($pass)
}

[System.Collections.ArrayList]$possibleAnswers = @()
$passes = $passes | Sort-Object
$lowestSeatId = $passes.SeatID | Select-Object -First 1
$highestSeatId = $passes.SeatID | Select-Object -Last 1

For ($i = $lowestSeatId; $i -lt $highestSeatId; $i++) {
    $counter++
    If ($passes.SeatID -notcontains $i) {
        If (($passes.SeatID -contains ($i-1)) -and ($passes.SeatID -contains ($i+1))) {
            $null = $possibleAnswers.Add($i)
        }
    }
}

$possibleAnswers