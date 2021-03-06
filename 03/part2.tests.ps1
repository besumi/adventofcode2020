Describe 'part2.ps1' {
    Context 'Using input data' {
        It 'Returns correct product' {
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
    
            $product = .$PSScriptRoot\part2.ps1
            $product | Should -Be 36
        }
    }

    Context 'Using example data' {
        BeforeEach {
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

        It 'Returns correct product' {
            $product = .$PSScriptRoot\part2.ps1
            $product | Should -Be 336
        }
    }
}