Describe "part1.ps1" {
    Context "Sample Data" {
        BeforeAll {
            Mock Get-Content {
                @(
                    "FBFBBFFRLR",
                    "BFFFBBFRRR",
                    "FFFBBBFRRR",
                    "BBFFBBFRLL"
                )
            }
        }
        It "Returns highest seat" {
            $return = .$PSScriptRoot\part1.ps1
            $return | Should -Be 820
        }
    }
}