[CmdletBinding()]
param()

$rawInput = Get-Content input.txt
[System.Collections.ArrayList]$allInstructions = @()
$index = 0

Foreach ($line in $rawInput) {
    $operation = ($line -split " ")[0]
    $amount = ($line -split " ")[1]

    $instruction = [PSCustomObject]@{
        Index = $index
        Operation = $operation
        Amount = $amount
        Executed = $false
    }

    $null = $allInstructions.Add($instruction)
    $index += 1
}

$accumulator = 0
[System.Collections.ArrayList]$allNopOrJmps = ($allInstructions | Where-Object {$_.Operation -eq "jmp" -or $_.Operation -eq "nop"}).Index
$lineUpdated = -1
$validRun = $false

While (!$validRun) {
    For ($i = 0; $i -lt $allInstructions.Count; $i++) {
        $currentInstruction = $allInstructions[$i]
        Write-Verbose "Processing $currentInstruction"
        
        If ($currentInstruction.Executed) {
            Write-Verbose "Already executed; trying to fix"
            
            If ($allNopOrJmps.Count -lt 1) {
                throw "No more lines left to update; still looping"
            }

            If ($lineUpdated -ge 0) {
                Write-Verbose "A line was updated previously; reverting $lineUpdated"
                If ($allInstructions[$lineUpdated].Operation -eq "jmp") {
                    $allInstructions[$lineUpdated].Operation="nop"
                }
                Else {
                    $allInstructions[$lineUpdated].Operation="jmp"
                }
            }

            $lineToUpdate = $allNopOrJmps[0]
            Write-Verbose "Updating line $lineToUpdate"
            $allNopOrJmps.RemoveAt(0)

            If ($allInstructions[$lineToUpdate].Operation -eq "jmp") {
                $allInstructions[$lineToUpdate].Operation="nop"
            }
            Else {
                $allInstructions[$lineToUpdate].Operation="jmp"
            }

            $lineUpdated = $lineToUpdate
            Write-Verbose "Resetting all Executed properties"
            $allInstructions | Foreach-Object {
                $_.Executed = $false
            }
            Write-Verbose "Starting over"
            $i = -1
            $accumulator = 0
            Continue
        }
    
        $number = [int]($currentInstruction.Amount)
        
        If ($currentInstruction.Operation -eq "nop") {
            $indexOfLastNopOrJmp = $i
            Write-Verbose "Noop"
        }
        ElseIf ($currentInstruction.Operation -eq "acc") {
                $accumulator += $number
        }
        ElseIf ($currentInstruction.Operation -eq "jmp") {
            $indexOfLastNopOrJmp = $i
            $i += ($number-1)
        }
    
        $currentInstruction.Executed = $true
    }

    $validRun = $true
}

$accumulator