[CmdletBinding()]
param()

$input = Get-Content input.txt | Foreach-Object {
    [int]$_
} | Sort-Object

$firstNumber = 0
$secondNumber = 0
$thirdNumber = 0

Foreach ($number in $input) {
    $difference = 2020 - $number
    Foreach ($number2 in $input) {
        If ($number2 -ne $number) {
            $difference2 = $difference - $number2
            
            If ($input -contains $difference2) {
                $firstNumber = $number
                $secondNumber = $number2
                $thirdNumber = $difference2
            }
        }
    }
}

Write-Debug "First number/second number/third number: $firstNumber/$secondNumber/$thirdNumber"

$firstNumber*$secondNumber*$thirdNumber