[CmdletBinding()]
param(
    [int]$PreambleLength = 25
)

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$numberToFind = .$executingScriptDirectory\part1.ps1 -PreambleLength $PreambleLength

If ($numberToFind.Count -gt 0) {
    $numberToFind = $numberToFind | Select-Object -First 1
}

Write-Verbose "Number to find: $numberToFind"
$rawInput = (Get-Content input.txt) -split "`n" | Foreach-Object { [bigint]$_ }
$startIndex = 0
[System.Collections.ArrayList]$foundNumbers = @()

Foreach ($number in $rawInput) {
    $sum = $number
    $counter = 0
    While ($sum -lt $numberToFind) {
        $nextNumber = $rawInput[$startIndex + $counter + 1]
        $sum += $nextNumber
        $counter += 1
    }

    If ($sum -eq $numberToFind) {
        $null = $foundNumbers.AddRange($rawInput[$startIndex..($startIndex+$counter)])
        Break
    }

    $startIndex += 1
}

$maxFound = ($foundNumbers | Measure-Object -Minimum).Minimum
$minFound = ($foundNumbers | Measure-Object -Maximum).Maximum

Write-Verbose "All numbers: $($foundNumbers -join ',')"
Write-Verbose "Max: $maxFound"
Write-Verbose "Min: $minFound"

$maxFound + $minFound