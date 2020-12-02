Describe 'part1.ps1' {
    It 'Returns a matching password from input' {
        Mock Get-Content {
            @(
                501,
                1519,
                888,
                12
            )
        }

        $answer = .\part1.ps1
        $answer | Should -Be 761019
    }

    It 'Returns correct password from example' {
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

        $answer = .\part1.ps1
        $answer | Should -Be 514579
    }
}