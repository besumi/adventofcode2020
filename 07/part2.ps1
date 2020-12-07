[CmdletBinding()]
param(
    [string]$BagYouHave="shiny gold"
)

Function Get-ChildBagCount {
    param(
        [string]$BagName,
        [array]$Rules
    )

    $total = 0

    $thisBag = $allRules | Where-Object {$_.Name -eq $BagName}
    If ($thisBag.Contents.Count -gt 0) {
        Foreach ($bag in $thisBag.Contents) {
            $newBags = (Get-ChildBagCount -BagName $bag.Name -Rules $Rules * $bag.Amount)
            $total += ($newBags * $bag.Amount) + $bag.Amount
        }
    }

    $total
}

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$rawInput = Get-Content .\input.txt
$rules = (.$executingScriptDirectory\Get-BagRules.ps1 $rawInput)[0..4]

Get-ChildBagCount -BagName $BagYouHave -Rules $allRules