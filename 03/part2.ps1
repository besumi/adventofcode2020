[CmdletBinding()]
param()

[System.Collections.ArrayList]$treeCounts = @()
$traversalCombinations = @(
    @(1, 1),
    @(3, 1),
    @(5, 1),
    @(7, 1),
    @(1, 2)
)

Foreach ($combo in $traversalCombinations) {
    $treeCount = .\Get-TreeCount -Right $combo[0] -Down $combo[1]
    $null = $treeCounts.Add($treeCount)
}

If ($treeCounts.Count -gt 0) {
    $total = $treeCounts[0]
    
    For ($i = 1; $i -lt $treeCounts.Count; $i++) {
        $total *= $treeCounts[$i]
    }
    
    $total
}