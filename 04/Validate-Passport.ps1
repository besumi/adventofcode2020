[CmdletBinding()]
param(
    [Hashtable]$Passport,
    [Switch]$CheckValues
)

$requiredKeys = @(
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
    "cid"
)

$validKeyCount = 0

Foreach ($key in $requiredKeys) {
    $keyPresent = $Passport.Keys -contains $key

    If (!$keyPresent -and $key -eq "cid") {
        Write-Debug "CID missing but that's okay"
        $validKeyCount += 1
    }
    ElseIf ($keyPresent) {
        Write-Debug "$($key): $($Passport[$key])"

        If ($CheckValues) {
            If ($key -eq "byr") {
                If ($Passport[$key] -ge 1000 -and $Passport[$key] -ge 1920 -and $Passport[$key] -le 2002) {
                    Write-Debug "Key valid"
                    $validKeyCount += 1
                }
            }
            ElseIf ($key -eq "iyr") {
                If ($Passport[$key] -ge 1000 -and $Passport[$key] -ge 2010 -and $Passport[$key] -le 2020) {
                    Write-Debug "Key valid"
                    $validKeyCount += 1
                }
            }
            ElseIf ($key -eq "eyr") {
                If ($Passport[$key] -ge 1000 -and $Passport[$key] -ge 2020 -and $Passport[$key] -le 2030) {
                    Write-Debug "Key valid"
                    $validKeyCount += 1
                }
            }
            ElseIf ($key -eq "hgt") {
                If ($Passport[$key] -match "cm") {
                    $Passport[$key] = $Passport[$key].Substring(0, ($Passport[$key].Length - 2))
                    Write-Debug "Height with cm removed: $($Passport[$key])"
                    If ($Passport[$key] -ge 150 -and $Passport[$key] -le 193) {
                        Write-Debug "Key valid"
                        $validKeyCount += 1
                    }
                }
                ElseIf ($Passport[$key] -match "in") {
                    $Passport[$key] = $Passport[$key].Substring(0, ($Passport[$key].Length - 2))
                    Write-Debug "Height with in removed: $($Passport[$key])"
                    If ($Passport[$key] -ge 59 -and $Passport[$key] -le 76) {
                        Write-Debug "Key valid"
                        $validKeyCount += 1
                    }
                }
            }
            ElseIf ($key -eq "hcl") {
                If ($Passport[$key][0] -eq "#") {
                    $validChars = @("a", "b", "c", "d", "e", "f", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
                    $Passport[$key] = $Passport[$key].Substring(1)
                    $charArray = $Passport[$key].ToString().ToLower().ToCharArray()

                    If ($charArray.Length -eq 6) {
                        $charArray = $Passport[$key].ToString().ToLower().ToCharArray()
                        $invalidChar = $false
                        Foreach ($char in $charArray) {
                            If ($validChars -notcontains $char) {
                                $invalidChar = $true
                            }
                        }
                        
                        If (!$invalidChar) {
                            Write-Debug "Key valid"
                            $validKeyCount += 1
                        }
                    }
                }
            }
            ElseIf ($key -eq "ecl") {
                $validColors = @("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
                If ($validColors -contains $Passport[$key]) {
                    Write-Debug "Key valid"
                    $validKeyCount += 1
                }
            }
            ElseIf ($key -eq "pid") {
                $validChars = @("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
                $charArray = $Passport[$key].ToString().ToCharArray()
                $invalidChar = $false
                If ($charArray.Length -eq 9) {
                    Foreach ($char in $charArray) {
                        If ($validChars -notcontains $char) {
                            $invalidChar = $true
                        }
                    }
                    
                    If (!$invalidChar) {
                        Write-Debug "Key valid"
                        $validKeyCount += 1
                    }
                }
            }
            ElseIf ($key -eq "cid") {
                $validKeyCount += 1
            }
        }
        Else {
            Write-Debug "Key valid"
            $validKeyCount += 1
        }
    }
}

($validKeyCount -eq 8)