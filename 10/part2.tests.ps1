Describe 'part2.ps1' {
    Context 'Sample data' {
        It 'returns expected value on small list' {
            Mock Get-Content {
                (@"
16
10
15
5
1
11
7
19
6
12
4
"@) -split "`n"
            }

            $answer = .$PSScriptRoot\part2.ps1
            $answer | Should -Be 8
        }

        It 'returns expected value on large list' {
            Mock Get-Content {
                (@"
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"@) -split "`n"
            }
        
            $answer = .$PSScriptRoot\part2.ps1 -Verbose
            $answer | Should -Be 19208
        }
     }
}