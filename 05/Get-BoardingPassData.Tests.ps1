Describe "Get-BoardingPassData" {
    Context "Sample Data" {
        It "Calculates sample FBFBBFFRLR" {
            $pass = .$PSScriptRoot\Get-BoardingPassData.ps1 -RawData "FBFBBFFRLR"
            $pass.Row | Should -Be 44
            $pass.Seat | Should -Be 5
            $pass.SeatID | Should -Be 357
        }
        It "Calculates sample BFFFBBFRRR" {
            $pass = .$PSScriptRoot\Get-BoardingPassData.ps1 -RawData "BFFFBBFRRR"
            $pass.Row | Should -Be 70
            $pass.Seat | Should -Be 7
            $pass.SeatID | Should -Be 567
        }
        It "Calculates sample FFFBBBFRRR" {
            $pass = .$PSScriptRoot\Get-BoardingPassData.ps1 -RawData "FFFBBBFRRR"
            $pass.Row | Should -Be 14
            $pass.Seat | Should -Be 7
            $pass.SeatID | Should -Be 119
        }
        It "Calculates sample BBFFBBFRLL" {
            $pass = .$PSScriptRoot\Get-BoardingPassData.ps1 -RawData "BBFFBBFRLL"
            $pass.Row | Should -Be 102
            $pass.Seat | Should -Be 4
            $pass.SeatID | Should -Be 820
        }
    }
}