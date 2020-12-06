Describe "part2.ps1" {
    It "Returns correct count from example" {
        Mock Get-Content {
            @(
                "abc",
                "",
                "a",
                "b",
                "c",
                "",
                "ab",
                "ac",
                "",
                "a",
                "a",
                "a",
                "a",
                "",
                "b"
            )
        }

        $answer = .$PSScriptRoot\part2.ps1
        $answer | Should -Be 6
    }

    It "Returns correct count from input" {
        Mock Get-Content {
            @(
                "vdytrl",
                "rcltq",
                "ztlmkoi",
                "tylr",
                "gtlba",
                "",
                "oxgpa",
                "ogaxp",
                "pgoxa",
                "",
                "edi",
                "jtm",
                "b",
                "jmug"
            )
        }

        $answer = .$PSScriptRoot\part2.ps1
        $answer | Should -Be 7
    }
}