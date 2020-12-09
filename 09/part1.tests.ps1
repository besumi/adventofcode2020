Describe 'part1.ps1' {
    Context 'Sample data' {
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
        It 'Returns correct result' {
            $answer = .$PSScriptRoot\part1.ps1 -PreambleLength 5
            $answer[0] | Should -Be 127
            $answer.Count | Should -Be 1
        }
    }
    Context 'Fabricated data' {
        It 'Returns correct result for 26' {
            Mock Get-Content {
            @"
20
2
3
4
5
6
7
8
9
10
21
22
23
24
25
11
12
13
14
15
16
17
18
19
1
26
"@
            }

            $answer = .$PSScriptRoot\part1.ps1
            $answer.Count | Should -Be 0
        }

        It 'Returns correct result for 49' {
            Mock Get-Content {
            @"
20
2
3
4
5
6
7
8
9
10
21
22
23
24
25
11
12
13
14
15
16
17
18
19
1
49
"@
            }
            
            $answer = .$PSScriptRoot\part1.ps1
            $answer.Count | Should -Be 0
        }

        It 'Returns correct result for 100' {
            Mock Get-Content {
            @"
20
2
3
4
5
6
7
8
9
10
21
22
23
24
25
11
12
13
14
15
16
17
18
19
1
100
"@
            }
            
            $answer = .$PSScriptRoot\part1.ps1
            $answer[0] | Should -Be 100
            $answer.Count | Should -Be 1
        }

        It 'Returns correct result for 50' {
            Mock Get-Content {
            @"
20
2
3
4
5
6
7
8
9
10
21
22
23
24
25
11
12
13
14
15
16
17
18
19
1
50
"@
            }
            
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 50
        }
    }
}