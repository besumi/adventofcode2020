Describe 'Validate-Passport' {
    It 'Accepts passport with all properties' {
        $passport = @{
            "BirthYear" = "1921"
            "IssueYear" = "2019"
            "ExpirationYear" = "2023"
            "Height" = "155cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blu"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Not -Throw
    }

    It 'Accepts passport with 193cm hgt' {
        $passport = @{
            "BirthYear" = "1921"
            "IssueYear" = "2019"
            "ExpirationYear" = "2023"
            "Height" = "193cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blu"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Not -Throw
    }

    It 'Rejects bad byr' {
        $passport = @{
            "BirthYear" = "1900"
            "IssueYear" = "2019"
            "ExpirationYear" = "2023"
            "Height" = "155cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blu"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad iyr' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2009"
            "ExpirationYear" = "2023"
            "Height" = "155cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blu"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad eyr' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2031"
            "Height" = "59in"
            "HairColor" = "#123abc"
            "EyeColor" = "gry"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad hgt - in' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "58in"
            "HairColor" = "#123abc"
            "EyeColor" = "gry"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad hgt - cm' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "149cm"
            "HairColor" = "#123abc"
            "EyeColor" = "gry"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad hcl - no leading pound' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "150cm"
            "HairColor" = "123abc"
            "EyeColor" = "gry"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad hcl - too many chars' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "150cm"
            "HairColor" = "#123abcd"
            "EyeColor" = "gry"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad hcl - invalid char' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "150cm"
            "HairColor" = "#123abp"
            "EyeColor" = "gry"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad ecl' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "150cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blue"
            "PassportID" = "000003321"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad pid - too many chars' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "150cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blu"
            "PassportID" = "0000033212"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
    It 'Rejects bad pid - not all digits' {
        $passport = @{
            "BirthYear" = "2002"
            "IssueYear" = "2020"
            "ExpirationYear" = "2030"
            "Height" = "150cm"
            "HairColor" = "#123abc"
            "EyeColor" = "blu"
            "PassportID" = "00000332a"
            "CountryID" = "toots"
        }
    
        { .$PSScriptRoot\Validate-Passport.ps1 @passport } | Should -Throw
    }
}