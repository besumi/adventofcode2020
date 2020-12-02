Describe 'part2.ps1' {
    It 'Returns correct product' {
        Mock Get-Content {
            @(
                501,
                344,
                888,
                12,
                1175
            )
        }

        $answer = .$PSScriptRoot\part2.ps1
        $answer | Should -Be 202504200
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

        $answer = .$PSScriptRoot\part2.ps1
        $answer | Should -Be 241861950
    }
}