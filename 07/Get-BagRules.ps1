[CmdletBinding()]
param(
    [array]$BagData
)

[System.Collections.ArrayList]$allRules = @()

Foreach ($line in $rawInput) {
    $bagKey = ($line -split " bags contain ")[0]
    Write-Verbose $bagKey
    $bagContents = ($line -split " bags contain ")[1] -split ", "

    [System.Collections.ArrayList]$contentsFormatted = @()
    Foreach ($content in $bagContents) {
        If ($content -notlike '*no other*') {
            $amount = ($content -split " ")[0]
            $bagType = ($content -split " ")[1..2] -join " "
            $newContent = [PSCustomObject]@{
                Name = $bagType
                Amount = $amount
            }
            
            Write-Verbose "$amount $bagType"

            $null = $contentsFormatted.Add($newContent)
        }
    }

    $newRule = [PSCustomObject]@{
        Name = $bagKey
        Contents = $contentsFormatted
    }
    $null = $allRules.Add($newRule)
}

$allRules