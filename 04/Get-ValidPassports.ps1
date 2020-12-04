[CmdletBinding()]
param(
    [Switch]$CheckValues
)

$executingScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$rawData = Get-Content .\input.txt
$totalGoodPassports = 0
$totalBadPassports = 0

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
    If ($CheckValues) {
        Try {
            .$executingScriptDirectory\Validate-Passport.ps1 -BirthYear $passport["byr"]`
            -IssueYear $passport["iyr"] -ExpirationYear $passport["eyr"] -Height $passport["hgt"]`
            -HairColor $passport["hcl"] -EyeColor $passport["ecl"] -PassportID $passport["pid"] -CountryID $passport["cid"]

            Write-Debug "Passport is valid"
            $totalGoodPassports += 1
        }
        Catch {
            Write-Debug "$($_.Exception.Message)"
            $totalBadPassports += 1
        }
    }
    Else {
        $requiredKeys = @(
            "byr",
            "iyr",
            "eyr",
            "hgt",
            "hcl",
            "ecl",
            "pid"
        )

        $passportKeys = $passport.Keys | Where-Object {$_ -ne "cid" }

        $matchedKeys = 0
        $requiredKeys | Foreach-Object {
            If ($_ -in $passportKeys) {
                $matchedKeys += 1
            }
        }

        If ($matchedKeys -eq $requiredKeys.Length) {
            $totalGoodPassports += 1
        }
        Else {
            $totalBadPassports += 1
        }
    }
}

Write-Debug "Bad passports: $totalBadPassports"
$totalGoodPassports