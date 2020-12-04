[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateRange(1920,2002)]
    [int]$BirthYear,
    [Parameter(Mandatory=$true)]
    [ValidateRange(2010,2020)]
    [int]$IssueYear,
    [Parameter(Mandatory=$true)]
    [ValidateRange(2020,2030)]
    [int]$ExpirationYear,
    [Parameter(Mandatory=$true)]
    [ValidatePattern("^[0-9]{2,3}(in|cm)$")]
    [string]$Height,
    [Parameter(Mandatory=$true)]
    [ValidatePattern("^#[0-9a-f]{6}$")]
    [string]$HairColor,
    [Parameter(Mandatory=$true)]
    [ValidateSet("amb","blu","brn","gry","grn","hzl","oth")]
    [string]$EyeColor,
    [Parameter(Mandatory=$true)]
    [ValidatePattern("^[0-9]{9}$")]
    [string]$PassportID,
    [Parameter(Mandatory=$false)]
    [string]$CountryID
)

$isValid = $false
$heightDigits = $Height.Substring(0,($Height.Length-2))
$unit = $Height.Substring($Height.Length-2,2)

If ($unit -eq "cm") {
    If ($heightDigits -ge 150 -and $heightDigits -le 193) {
        $isValid = $true
    }
}
Elseif ($unit -eq "in") {
    If ($heightDigits -ge 59 -and $heightDigits -le 76) {
        $isValid = $true
    }
}

If (!$isValid) {
    throw "Height $Height is invalid"
}