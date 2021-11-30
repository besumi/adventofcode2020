[CmdletBinding()]
param(
    [array]$RawInput
)

If (!$RawInput) {
    $RawInput = Get-Content .\input.txt
}

$waypoint = @{
    "xUnits" = 10
    "yUnits" = 1
}
$location = @{
    "xUnits" = 0
    "yUnits" = 0
}

Foreach ($instruction in $rawInput) {
    Write-Host "Instruction: $instruction"
    $letter = $instruction.Substring(0,1)
    [int]$number = $instruction.Substring(1)
    Write-Debug "Letter: $letter Number: $number"

    If ($letter -eq 'F') {
        $location.xUnits = $location.xUnits + ($number * $waypoint.xUnits)
        $location.yUnits = $location.yUnits + ($number * $waypoint.yUnits)
    }
    ElseIf ($letter -eq 'N') {
        $waypoint.yUnits = $waypoint.yUnits + $number
    }
    ElseIf ($letter -eq 'S') {
        $waypoint.yUnits = $waypoint.yUnits - $number
    }
    ElseIf ($letter -eq 'E') {
        $waypoint.xUnits = $waypoint.xUnits + $number
    }
    ElseIf ($letter -eq 'W') {
        $waypoint.xUnits = $waypoint.xUnits - $number
    }
    ElseIf ($letter -eq 'R') {
        $turns = $number / 90

        For ($i = 0; $i -lt $turns; $i++) {
            Write-Host "Turn $($i + 1)"
            $newX = [Math]::Abs($waypoint.yUnits)
            If ($waypoint.yUnits -lt 0) {
                $newX = -$newX
            }
            Else {
                $newX = [Math]::Abs($newX)
            }

            $newY = [Math]::Abs($waypoint.xUnits)
            If ($waypoint.xUnits -gt 0) {
                $newY = -$newY
            }
            Else {
                $newY = [Math]::Abs($newY)
            }
            $waypoint.xUnits = $newX
            $waypoint.yUnits = $newY

            Write-Host "New direction: $(If ($waypoint.xUnits -gt 0) { 'E' } Else { 'W' }) $([Math]::Abs($waypoint.xUnits)) $(If ($waypoint.yUnits -gt 0) { 'N' } Else { 'S' }) $([Math]::Abs($waypoint.yUnits))"
        }
    }
    ElseIf ($letter -eq 'L') {
        $turns = $number / 90

        For ($i = 0; $i -lt $turns; $i++) {
            $newX = [Math]::Abs($waypoint.yUnits)
            If ($waypoint.yUnits -gt 0) {
                $newX = -$newX
            }
            Else {
                $newX = [Math]::Abs($newX)
            }

            $newY = [Math]::Abs($waypoint.xUnits)
            If ($waypoint.xUnits -lt 0) {
                $newY = -$newY
            }
            Else {
                $newY = [Math]::Abs($newY)
            }
            $waypoint.xUnits = $newX
            $waypoint.yUnits = $newY

            Write-Host "New direction: $(If ($waypoint.xUnits -gt 0) { 'E' } Else { 'W' }) $([Math]::Abs($waypoint.xUnits)) $(If ($waypoint.yUnits -gt 0) { 'N' } Else { 'S' }) $([Math]::Abs($waypoint.yUnits))"
        }
    }

    $currentY = 'N'
    If ($location.yUnits -lt 0) {
        $currentY = 'S'
    }
    $currentX = 'E'
    If ($location.xUnits -lt 0) {
        $currentX = 'W'
    }

    Write-Host "Current waypoint: $(If ($waypoint.xUnits -gt 0) { 'E' } Else { 'W' }) $([Math]::Abs($waypoint.xUnits)) $(If ($waypoint.yUnits -gt 0) { 'N' } Else { 'S' }) $([Math]::Abs($waypoint.yUnits))"
    Write-Host "Current location: $currentX $([Math]::Abs($location.xUnits)) $currentY $([Math]::Abs($location.yUnits))"
}

Write-Host "Final placement"
[Math]::Abs($location.xUnits) + [Math]::Abs($location.yUnits)