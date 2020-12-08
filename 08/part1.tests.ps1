Describe 'part1.ps1' {
    Context 'Sample data' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "nop +0",
                    "acc +1",
                    "jmp +4",
                    "acc +3",
                    "jmp -3",
                    "acc -99",
                    "acc +1",
                    "jmp -4",
                    "acc +6"
                )
            }
        }

        It 'Returns correct result' {
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 5
        }
    }
    Context 'Fabricated data' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "acc +1",
                    "nop +0",
                    "jmp +4",
                    "jmp -3",
                    "acc +3",
                    "acc +1",
                    "acc -99",
                    "jmp -4",
                    "acc +6"
                )
            }
        }

        It 'Returns correct result' {
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be -98
        }
    }
}