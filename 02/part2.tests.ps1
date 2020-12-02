Describe 'part2.ps1' {
    It 'Returns a matching password from input' {
        Mock Get-Content {
            @(
                "3-4 q: qqqq",
                "6-7 m: mqmlltc"
                "8-10 k: kkkfkhkkkpkkkk"
            )
        }

        $goodPasswords = .\part2.ps1
        $goodPasswords.Count | Should -Be 1
        $goodPasswords | Should -Be "8-10 k: kkkfkhkkkpkkkk"
    }

    It 'Returns correct password from example' {
        Mock Get-Content {
            @(
                "1-3 a: abcde",
                "1-3 b: cdefg"
                "2-9 c: ccccccccc"
            )
        }

        $goodPasswords = .\part2.ps1
        $goodPasswords.Count | Should -Be 1
        $goodPasswords | Should -Be "1-3 a: abcde"
    }
}