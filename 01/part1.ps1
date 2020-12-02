[CmdletBinding()]
param()

$input = Get-Content input.txt | Foreach-Object {
    [int]$_
} | Sort-Object

$firstNumber = 0
$secondNumber = 0

Foreach ($number in $input) {
    $difference = 2020 - $number
    If ($input -contains $difference) {
        $firstNumber = $number
        $secondNumber = $difference
    }
}

Write-Debug "First number/second number: $firstNumber/$secondNumber"

$firstNumber*$secondNumber