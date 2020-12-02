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

Write-Host "First number: $firstNumber"
Write-Host "Second number: $secondNumber"

$firstNumber*$secondNumber