[CmdletBinding()]
param()

$rawInput = Get-Content .\input.txt
[System.Collections.ArrayList]$allInstructions = @()

Foreach ($line in $rawInput) {
    $operation = ($line -split " ")[0]
    $amount = ($line -split " ")[1]

    $instruction = [PSCustomObject]@{
        Operation = $operation
        Amount = $amount
        Executed = $false
    }

    $null = $allInstructions.Add($instruction)
}

$accumulator = 0
For ($i = 0; $i -lt $allInstructions.Count; $i++) {
    $currentInstruction = $allInstructions[$i]
    Write-Verbose "Processing $currentInstruction"
    
    If ($currentInstruction.Executed) {
        Write-Verbose "Already executed; exiting loop"
        Break
    }

    $number = [int]($currentInstruction.Amount)
    
    If ($currentInstruction.Operation -eq "nop") {
        Write-Verbose "Noop"
    }
    ElseIf ($currentInstruction.Operation -eq "acc") {
            $accumulator += $number
    }
    ElseIf ($currentInstruction.Operation -eq "jmp") {
        $i += ($number-1)
    }

    $currentInstruction.Executed = $true
    Write-Verbose "Accumulator: $accumulator"
}

$accumulator