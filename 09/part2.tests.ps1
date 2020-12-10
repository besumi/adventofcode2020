Describe 'part2.ps1' {
    Context 'Sample data' {
        It 'Returns correct result' {
            Mock Get-Content {
                @"
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"@
            }
            $answer = .$PSScriptRoot\part2.ps1 -PreambleLength 5 -Verbose
            $answer | Should -Be 62
        }
    }
}