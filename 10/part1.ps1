[CmdletBinding()]
param()

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$joltages = [PSCustomObject]@{
    OneJolt = 0
    ThreeJolt = 1
}

$rawInput = Get-Content .\input.txt | ForEach-Object { [int]$_ }
$deviceJoltage = ($rawInput | Measure-Object -Maximum).Maximum + 3
Write-Verbose "Device joltage: $deviceJoltage"

$joltageToCheck = 0

While (($joltageToCheck -ge 0) -and $joltageToCheck -lt ($deviceJoltage-3)) {
    Write-Verbose "Checking next adapter for joltage $joltageToCheck..."
    $next = .$executingScriptDirectory\Get-NextValidAdapter.ps1 -Joltage $joltageToCheck -Adapters $rawInput

    Write-Verbose "Adapter: $next"
    $rawInput = $rawInput | Where-Object {$_ -ne $next}

    If ($next - $joltageToCheck -eq 1) {
        $joltages.OneJolt += 1
    }
    ElseIf ($next - $joltageToCheck -eq 3) {
        $joltages.ThreeJolt += 1
    }
    Else {
        Write-Verbose "Not a one or three jolt difference: $next - $joltageToCheck"
    }
    
    $joltageToCheck = $next
}

Write-Verbose "Adapters left: $($rawInput -join ',')"
$joltages