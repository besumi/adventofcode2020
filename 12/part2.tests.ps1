Describe 'part2.ps1' {
    Context 'Sample data' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "F10",
                    "N3",
                    "F7",
                    "R90",
                    "F11"
                )
            }
        }
        
        It 'returns expected value' {
            $answer = .$PSScriptRoot\part2.ps1
            $answer | Should -Be 286
        }
    }
}