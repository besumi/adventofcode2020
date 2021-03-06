[CmdletBinding()]
param(
    [string]$BagYouHave = "shiny gold"
)

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$rawInput = Get-Content .\input.txt
$allRules = .$executingScriptDirectory\Get-BagRules.ps1 $rawInput

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