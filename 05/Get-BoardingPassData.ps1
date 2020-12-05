[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern("^[FB]{7}[RL]{3}$")]
    [string]$RawData
)

$returnValue = [PSCustomObject]@{
    Seat   = 0
    Row    = 0
    SeatID = 0
}

$rowNumbers = 0..127
$rowArray = $RawData.ToCharArray()[0..6]

Foreach ($letter in $rowArray) {
    $half = $rowNumbers.Length / 2
    
    If ($letter -eq "F") {
        $rowNumbers = $rowNumbers[0..($half - 1)]
    }
    Else {
        $rowNumbers = $rowNumbers[($half)..($rowNumbers.Length - 1)]
    }
}

$returnValue.Row = $rowNumbers[0]

$seatNumbers = 0..7
$seatArray = $RawData.ToCharArray()[7..10]

Foreach ($letter in $seatArray) {
    $half = $seatNumbers.Length / 2
    
    If ($letter -eq "L") {
        $seatNumbers = $seatNumbers[0..($half - 1)]
    }
    Else {
        $seatNumbers = $seatNumbers[($half)..($seatNumbers.Length - 1)]
    }
}

$returnValue.Seat = $seatNumbers[0]
$returnValue.SeatID = ($returnValue.Row * 8) + $returnValue.Seat

$returnValue