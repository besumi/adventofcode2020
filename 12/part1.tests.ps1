Describe 'part1.ps1' {
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
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 25
        }
    }

    Context 'Turns' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "R180", # W
                    "F3", # W 3 N 0
                    "L90", # S
                    "F3", # W 3 S 3
                    "L180", # N
                    "F6" # W 3 N 3
                )
            }
        }
        
        It 'returns expected value' {
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 6
        }
    }
}