[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [int]$DayNumber
)

$numberPadded = ([string]$DayNumber).PadLeft(2,'0')

If ((Get-ChildItem -Directory).Name -contains $numberPadded) {
    throw "Folder $numberPadded already exists"
}

$null = New-Item -Name $numberPadded -ItemType Directory
$null = New-Item -Name input.txt -ItemType File -Path $numberPadded
$null = New-Item -Name part1.ps1 -ItemType File -Path $numberPadded
$null = New-Item -Name part1.tests.ps1 -ItemType File -Path $numberPadded

Set-Content -Path $numberPadded\input.txt -NoNewline -Value (Get-Clipboard -Raw)
Set-Content -Path $numberPadded\part1.ps1 -NoNewline -Value @"
[CmdletBinding()]
param()

`$executingScriptDirectory = Split-Path -Path `$MyInvocation.MyCommand.Definition -Parent
`$returnValue = 0

`$rawInput = Get-Content .\input.txt

`$returnValue
"@
Set-Content -Path $numberPadded\part1.tests.ps1 -NoNewline -Value @"
Describe 'part1.ps1' {
    Context 'Sample data' {
        BeforeAll {
            Mock Get-Content {
                `$rawData = `@"
sample
data
here
"`@
            }
        }
        
        It 'returns expected value' {
            `$answer = .`$PSScriptRoot\part1.ps1
            `$answer | Should -Be 0
        }
    }
}
"@