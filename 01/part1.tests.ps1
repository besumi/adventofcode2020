Describe 'part1.ps1' {
    It 'Returns correct product' {
        Mock Get-Content {
            @(
                501,
                1519,
                888,
                12
            )
        }

        $answer = .$PSScriptRoot\part1.ps1
        $answer | Should -Be 761019
    }

    It 'Returns correct product from example' {
        Mock Get-Content {
            @(
                1721,
                979,
                366,
                299,
                675,
                1456
            )
        }

        $answer = .$PSScriptRoot\part1.ps1
        $answer | Should -Be 514579
    }
}