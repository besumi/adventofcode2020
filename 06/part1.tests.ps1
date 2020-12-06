Describe "part1.ps1" {
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

        $answer = .$PSScriptRoot\part1.ps1
        $answer | Should -Be 11
    }

    It "Returns correct count from input" {
        Mock Get-Content {
            @(
                "vdytrl",
                "rcltq"
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

        $answer = .$PSScriptRoot\part1.ps1
        $answer | Should -Be (8+5+9)
    }
}