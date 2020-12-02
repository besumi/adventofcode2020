[CmdletBinding()]
param()

$rawInput = Get-Content .\input.txt
[System.Collections.ArrayList]$goodLines = @()

Foreach ($line in $rawInput) {
    $key = ($line -split ':')[0]
    $password = (($line -split ':')[1]).Trim()

    $range = $key.Substring(0, $key.length - 2)
    $character = $key.Substring($key.length - 1, 1)
    $firstIndex = (($range -split '-')[0]) - 1
    $secondIndex = (($range -split '-')[1]) - 1

    $firstCharacter = $password[$firstIndex]
    $secondCharacter = $password[$secondIndex]
    Write-Debug "Password/character/first char/second char: $password/$character/$firstCharacter/$secondCharacter"

    If ($firstCharacter -ne $secondCharacter) {
        If ($firstCharacter -eq $character -or $secondCharacter -eq $character) {
            Write-Debug "Valid password found"
            $null = $goodLines.Add($line)
        }
    }
}

$goodLines