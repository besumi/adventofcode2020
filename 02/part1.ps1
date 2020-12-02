$rawInput = Get-Content .\input.txt
[System.Collections.ArrayList]$goodLines = @()

Foreach ($line in $rawInput) {
    $key = ($line -split ':')[0]
    $password = (($line -split ':')[1]).Trim()

    $range = $key.Substring(0, $key.length - 2)
    $character = $key.Substring($key.length - 1, 1)
    $lowestNumber = ($range -split '-')[0]
    $highestNumber = ($range -split '-')[1]

    $numberOfOccurrences = ($password -split $character).Count - 1

    If ($numberOfOccurrences -ge $lowestNumber -and $numberOfOccurrences -le $highestNumber) {
        $null = $goodLines.Add($line)
    }
}

$goodLines