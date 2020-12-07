[CmdletBinding()]
param()

Describe 'part1.ps1' {
    Context 'Sample data' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "light red bags contain 1 bright white bag, 2 muted yellow bags.",
                    "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
                    "bright white bags contain 1 shiny gold bag.",
                    "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
                    "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
                    "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
                    "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
                    "faded blue bags contain no other bags.",
                    "dotted black bags contain no other bags."
                )
            }
        }
        It 'returns expected result' {
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 4
        }
    }
    Context 'Nested bags' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
                    "bright white bags contain 1 shiny gold bag.",
                    "light red bags contain 1 bright white bag, 2 muted yellow bags.",
                    "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
                    "dark olive bags contain 3 light red bags, 4 dotted black bags."
                )
            }
        }
        It 'returns expected result' {
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 4
        }
    }
    Context 'Duplicate bags' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "bright white bags contain 1 shiny gold bag.",
                    "light red bags contain 1 bright white bag, 2 muted yellow bags.",
                    "muted yellow bags contain 1 shiny gold bag.",
                    "dotted black bags contain 1 muted yellow bag."
                )
            }
        }
        It 'returns expected result' {
            $answer = .$PSScriptRoot\part1.ps1
            $answer | Should -Be 4
        }
    }
}