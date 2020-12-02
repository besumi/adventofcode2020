Describe 'part1.ps1' {
    It 'Returns a matching password from input' {
        Mock Get-Content {
            @(
                501,
                344,
                888,
                12,
                1175
            )
        }

        $answer = .\part2.ps1
        $answer | Should -Be 202504200
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

        $answer = .\part2.ps1
        $answer | Should -Be 241861950
    }
}