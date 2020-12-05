[CmdletBinding()]
param()

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$rawInput = Get-Content .\input.txt
[System.Collections.ArrayList]$seatIds = @()

Foreach ($line in $rawInput) {
    $pass = .$executingScriptDirectory\Get-BoardingPassData.ps1 -RawData $line
    $null = $seatIds.Add($pass.SeatID)
}

$seatIds = $seatIds | Sort-Object -Descending

$seatIds[0]