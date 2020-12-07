[CmdletBinding()]
param(
    [string]$BagYouHave = "shiny gold"
)

$rawInput = Get-Content .\input.txt
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

[System.Collections.ArrayList]$validBags = @()
$validBags += $allRules | Where-Object { $_.Contents.Name -eq $BagYouHave }
[System.Collections.ArrayList]$bagsToCheck = @()
$validBags | Foreach-Object {
    $null = $bagsToCheck.Add($_)
}

$iterate = $true

While ($iterate) {
    Write-Verbose "Checking bags $($bagsToCheck.Name -join ",")"
    [System.Collections.ArrayList]$newBags = @()

    $bagsAdded = $false
    Foreach ($bag in $bagsToCheck) {
        [array]$matchingBags = $allRules | Where-Object { ($_.Contents.Name -eq $bag.Name) -and ($_.Name -notin $validBags.Name) -and ($_.Name -ne $BagYouHave)}

        If ($matchingBags.Count -gt 0) {
            Write-Verbose "Adding bag $($matchingBags.Name -join ',')"
            $bagsAdded = $true
            $null = $validBags.AddRange($matchingBags)
            $null = $newBags.AddRange($matchingBags)
        }
    }

    If (!$bagsAdded) {
        $iterate = $false
    }
    Else {
        $bagsToCheck = @()
        $newBags | Foreach-Object {
            $null = $bagsToCheck.Add($_)
        }
    }
}

Write-Verbose "Checked $($rawInput.Count) items"
$validBags.Count