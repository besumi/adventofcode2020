[CmdletBinding()]
param()

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

[System.Collections.ArrayList]$treeCounts = @()
$traversalCombinations = @(
    @(1, 1),
    @(3, 1),
    @(5, 1),
    @(7, 1),
    @(1, 2)
)

Foreach ($combo in $traversalCombinations) {
    $treeCount = .$executingScriptDirectory\Get-TreeCount.ps1 -Right $combo[0] -Down $combo[1]
    $null = $treeCounts.Add($treeCount)
}

If ($treeCounts.Count -gt 0) {
    $total = 1
    Foreach ($count in $treeCounts) {
        $total *= $count
    }
    
    $total
}