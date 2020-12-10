[CmdletBinding()]
param(
    [int]$PreambleLength = 25
)

$rawInput = (Get-Content input.txt) -split "`n" | Foreach-Object { [bigint]$_ }
$poolStart = 0
$poolEnd = $PreambleLength - 1
[System.Collections.ArrayList]$currentPool = $rawInput[$poolStart..$poolEnd]
[System.Collections.ArrayList]$badNumbers = @()

While ($poolEnd -lt ($rawInput.Length-1)) {
    $numberToCheck = $rawInput[$poolEnd + 1]
    Write-Verbose "Checking number $numberToCheck"

    [System.Collections.ArrayList]$matchingNumbers = @()

    :Outer While ($matchingNumbers.Count -eq 0) {
        Foreach ($firstNumber in $currentPool) {
            Foreach ($secondNumber in $currentPool) {
                If ($firstNumber -ne $secondNumber) {
                    If (($firstNumber + $secondNumber) -eq $numberToCheck) {
                        Write-Verbose "Found matching numbers $firstNumber and $secondNumber"
                        $null = $matchingNumbers.Add($firstNumber)
                        $null = $matchingNumbers.Add($secondNumber)
                        Break Outer
                    }
                }
            }
        }
        Break
    }

    If ($matchingNumbers.Count -eq 0) {
        $null = $badNumbers.Add($numberToCheck)
    }

    $poolStart += 1
    $poolEnd += 1
    $currentPool = $rawInput[$poolStart..$poolEnd]
}

$badNumbers