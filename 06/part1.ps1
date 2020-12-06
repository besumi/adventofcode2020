[CmdletBinding()]
param()

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

$rawInput = Get-Content .\input.txt
[System.Collections.ArrayList]$groups = @()
[System.Collections.ArrayList]$currentGroup = @()

Foreach ($line in $rawInput) {
    If ($line -eq "") {
        $null = $groups.Add($currentGroup)
        $currentGroup = @()
    }
    Else {
        $null = $currentGroup.Add($line)
    }
}

If ($currentGroup.Count -gt 0) {
    $null = $groups.Add($currentGroup)
}

$total = 0

Foreach ($group in $groups) {
    $total += .$executingScriptDirectory\Get-UniqueAnswers.ps1 $group
}

$total