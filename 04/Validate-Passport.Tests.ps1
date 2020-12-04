Describe 'Validate-Passport' {
    Context 'No value checks' {
        It 'Accepts passport with all properties' {
            $passport = @{
                "byr" = "x"
                "iyr" = "x"
                "eyr" = "x"
                "hgt" = "x"
                "hcl" = "x"
                "ecl" = "x"
                "pid" = "x"
                "cid" = "x"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport
            $answer | Should -Be $true
        }
    
        It 'Accepts passport missing only CID' {
            $passport = @{
                "byr" = "x"
                "iyr" = "x"
                "eyr" = "x"
                "hgt" = "x"
                "hcl" = "x"
                "ecl" = "x"
                "pid" = "x"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport
            $answer | Should -Be $true
        }
    
        It 'Rejects passport missing one key' {
            $passport = @{
                "iyr" = "x"
                "eyr" = "x"
                "hgt" = "x"
                "hcl" = "x"
                "ecl" = "x"
                "pid" = "x"
                "cid" = "x"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport
            $answer | Should -Be $false
        }
    
        It 'Rejects passport missing one key and CID' {
            $passport = @{
                "iyr" = "x"
                "eyr" = "x"
                "hgt" = "x"
                "hcl" = "x"
                "ecl" = "x"
                "pid" = "x"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport
            $answer | Should -Be $false
        }
    }

    Context 'With value checks' {
        It 'Accepts passport with all properties' {
            $passport = @{
                "byr" = "1921"
                "iyr" = "2019"
                "eyr" = "2023"
                "hgt" = "155cm"
                "hcl" = "#123abc"
                "ecl" = "blu"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValue
            $answer | Should -Be $true
        }

        It 'Rejects bad byr' {
            $passport = @{
                "byr" = "1900"
                "iyr" = "2019"
                "eyr" = "2023"
                "hgt" = "155cm"
                "hcl" = "#123abc"
                "ecl" = "blu"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad iyr' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2009"
                "eyr" = "2023"
                "hgt" = "155cm"
                "hcl" = "#123abc"
                "ecl" = "blu"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad eyr' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2031"
                "hgt" = "59in"
                "hcl" = "#123abc"
                "ecl" = "gry"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad hgt - in' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "58in"
                "hcl" = "#123abc"
                "ecl" = "gry"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad hgt - cm' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "149cm"
                "hcl" = "#123abc"
                "ecl" = "gry"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad hcl - no leading pound' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "150cm"
                "hcl" = "123abc"
                "ecl" = "gry"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad hcl - too many chars' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "150cm"
                "hcl" = "#123abcd"
                "ecl" = "gry"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad hcl - invalid char' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "150cm"
                "hcl" = "#123abp"
                "ecl" = "gry"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad ecl' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "150cm"
                "hcl" = "#123abc"
                "ecl" = "blue"
                "pid" = "000003321"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad pid - too many chars' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "150cm"
                "hcl" = "#123abc"
                "ecl" = "blu"
                "pid" = "0000033212"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
        It 'Rejects bad pid - not all digits' {
            $passport = @{
                "byr" = "2002"
                "iyr" = "2020"
                "eyr" = "2030"
                "hgt" = "150cm"
                "hcl" = "#123abc"
                "ecl" = "blu"
                "pid" = "00000332a"
                "cid" = "toots"
            }
    
            $answer = .$PSScriptRoot\Validate-Passport.ps1 $passport -CheckValues
            $answer | Should -Be $false
        }
    }
}