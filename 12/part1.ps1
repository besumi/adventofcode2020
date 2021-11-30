[CmdletBinding()]
param(
    [array]$RawInput
)

If (!$RawInput) {
    $RawInput = Get-Content .\input.txt
}

$directions = @('N', 'E', 'S', 'W')

$direction = 'E'
$location = @{
    "xUnits" = 0
    "yUnits" = 0
}

Foreach ($instruction in $rawInput) {
    Write-Host "Instruction: $instruction"
    $letter = $instruction.Substring(0,1)
    $number = $instruction.Substring(1)
    Write-Debug "Letter: $letter Number: $number"

    If ($letter -eq 'F') {
        If ($direction -eq 'E') {
            $location.xUnits += $number
        }
        ElseIf ($direction -eq 'W') {
            $location.xUnits -= $number
        }
        ElseIf ($direction -eq 'S') {
            $location.yUnits -= $number
        }
        Else {
            $location.yUnits += $number
        }
    }
    ElseIf ($letter -eq 'N') {
        $location.yUnits += $number
    }
    ElseIf ($letter -eq 'S') {
        $location.yUnits -= $number
    }
    ElseIf ($letter -eq 'E') {
        $location.xUnits += $number
    }
    ElseIf ($letter -eq 'W') {
        $location.xUnits -= $number
    }
    ElseIf ($letter -in ('R', 'L')) {
        $currentIndex = $directions.IndexOf($direction)
        Write-Host "Current index: $currentIndex"
        $directionsToMove = $number / 90
        $newIndex = 0
        If ($letter -eq 'R') {
            $newIndex = ($currentIndex + $directionsToMove) % ($directions.Count)
        }
        Else {
            $newIndex = ($currentIndex - $directionsToMove) % ($directions.Count)
        }
        Write-Host "Old direction: $direction"
        $direction = $directions[$newIndex]
        Write-Host "New direction: $direction"
    }

    $currentY = 'N'
    If ($location.yUnits -lt 0) {
        $currentY = 'S'
    }
    $currentX = 'E'
    If ($location.xUnits -lt 0) {
        $currentX = 'W'
    }

    Write-Host "Current placement: $currentX $([Math]::Abs($location.xUnits)) $currentY $([Math]::Abs($location.yUnits))"
}

Write-Host "Final placement"
[Math]::Abs($location.xUnits) + [Math]::Abs($location.yUnits)