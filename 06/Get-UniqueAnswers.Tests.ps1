Describe "Get-UniqueAnswers" {
    Context "Sample data" {
        It "Returns correct count for abc" {
            $group = @(
                "abc"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 3
        }
        It "Returns correct count for a/b/c" {
            $group = @(
                "a",
                "b",
                "c"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 3
        }
        It "Returns correct count for ab/ac" {
            $group = @(
                "ab",
                "ac"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 3
        }
        It "Returns correct count for a/a/a/a" {
            $group = @(
                "a",
                "a",
                "a",
                "a"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 1
        }
        It "Returns correct count for b" {
            $group = @(
                "b"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 1
        }
    }
    Context "Input excerpts" {
        It "Returns correct count for i/x" {
            $group = @(
                "i",
                "x",
                "i",
                "i"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 2
        }
        It "Returns correct count for i/x" {
            $group = @(
                "oxgpa",
                "ogaxp",
                "pgoxa"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group
            $count | Should -Be 5
        }
    }
}
Describe "Get-UniqueAnswers -Unanimous" {
    Context "Sample data" {
        It "Returns correct count for abc" {
            $group = @(
                "abc"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 3
        }
        It "Returns correct count for a/b/c" {
            $group = @(
                "a",
                "b",
                "c"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 0
        }
        It "Returns correct count for ab/ac" {
            $group = @(
                "ab",
                "ac"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 1
        }
        It "Returns correct count for a/a/a/a" {
            $group = @(
                "a",
                "a",
                "a",
                "a"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 1
        }
        It "Returns correct count for b" {
            $group = @(
                "b"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 1
        }
    }
    Context "Input excerpts" {
        It "Returns correct count for i/x" {
            $group = @(
                "i",
                "x",
                "i",
                "i"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 0
        }
        It "Returns correct count for i/x" {
            $group = @(
                "oxgpa",
                "ogaxp",
                "pgoxa"
            )
    
            $count = .$PSScriptRoot\Get-UniqueAnswers.ps1 -Group $group -Unanimous
            $count | Should -Be 5
        }
    }
}