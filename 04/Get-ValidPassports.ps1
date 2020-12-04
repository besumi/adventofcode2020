[CmdletBinding()]
param(
    [Switch]$CheckValues
)

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$rawData = Get-Content .\input.txt
$totalGoodPassports = 0

[System.Collections.ArrayList]$allPassports = @()
$currentPassport = New-Object Hashtable

Foreach ($line in $rawData) {
    If ($line -eq "") {
        $null = $allPassports.Add($currentPassport)
        $currentPassport = New-Object Hashtable
    }
    Else {
        $properties = $line -split " "

        Foreach ($property in $properties) {
            $key = ($property -split ":")[0]
            $value = ($property -split ":")[1]
            $currentPassport[$key] = $value
        }
    }
}

If ($currentPassport.Keys.Count -gt 0) {
    $null = $allPassports.Add($currentPassport)
}

Foreach ($passport in $allPassports) {
    $isValid = .$executingScriptDirectory\Validate-Passport.ps1 $passport -CheckValues:$CheckValues.IsPresent
    If ($isValid) {
        Write-Debug "Passport is valid"
        $totalGoodPassports += 1
    }
    Else {
        Write-Debug "Passport is invalid"
    }
}

$totalGoodPassports
