[CmdletBinding()]
param(
    [int]$Joltage,
    [array]$Adapters
)

$possibleMatches = $Adapters | Where-Object {$_ -gt $Joltage -and $_ -le ($Joltage + 3)} | Sort-Object
Write-Verbose "Matching adapters: $($possibleMatches -join ',')"

$possibleMatches