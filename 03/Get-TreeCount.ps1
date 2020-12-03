[CmdletBinding()]
param(
    [int]$Down = 1,
    [int]$Right = 3
)

[System.Collections.ArrayList]$mapData = Get-Content .\input.txt
$treeCount = 0
$position = $Right
$downCounter = 0

Foreach ($line in $mapData) {
    If ($downCounter -eq $Down) {
        $positionToCheck = $position % $line.Length
        $charArray = $line.ToCharArray()
    
        If ($charArray[$positionToCheck] -eq '#') {
            $treeCount += 1
        }
            
        $charArray[$positionToCheck] = 'X'
        $treeMarker = [String]::New($charArray)
        Write-Debug $treeMarker
    
        $position += $Right
        $downCounter = 0
    }
    Else {
        Write-Debug $line
    }

    $downCounter += 1

}
    
$treeCount