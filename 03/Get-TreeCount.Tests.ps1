Describe 'Get-TreeCount' {
    Context 'Using input data' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "...#....#.#...##......#.#...##.",
                    ".#..#...##..#....##........##..",
                    "..##.##...##.#.#....#..#......#",
                    "....#....#..#..#.#....#..###...",
                    "####.....##.#.##...##..#....#..",
                    "#........##...#..###..#.#.#.##.",
                    ".......###........##...#...#...",
                    "#.#...#..#..#...#...##.##......",
                    "..#...........#......##.#.#...."
                )
            }
        }

        It 'Returns correct tree count for Part1' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1
            $treeCount | Should -Be 6
        }

        It 'Returns correct count for 1, 2' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1 -Right 1 -Down 2
            $treeCount | Should -Be 1
        }
    }

    Context 'Using example data' {
        BeforeAll {
            Mock Get-Content {
                @(
                    "..##.......",
                    "#...#...#..",
                    ".#....#..#.",
                    "..#.#...#.#",
                    ".#...##..#.",
                    "..#.##.....",
                    ".#.#.#....#",
                    ".#........#",
                    "#.##...#...",
                    "#...##....#",
                    ".#..#...#.#"
                )
            }
        }

        It 'Returns correct count for Part1' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1
            $treeCount | Should -Be 7
        }
    
        It 'Returns correct count for 1, 1' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1 -Right 1 -Down 1
            $treeCount | Should -Be 2
        }

        It 'Returns correct count for 5, 1' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1 -Right 5 -Down 1
            $treeCount | Should -Be 3
        }

        It 'Returns correct count for 7, 1' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1 -Right 7 -Down 1
            $treeCount | Should -Be 4
        }

        It 'Returns correct count for 1, 2' {
            $treeCount = .$PSScriptRoot\Get-TreeCount.ps1 -Right 1 -Down 2
            $treeCount | Should -Be 2
        }
    }
}