Get-ChildItem -Include *tests.ps1 -Recurse -Name | Foreach-Object {
    $_ = $_.ToLower()
    $originalScript = $_.Replace(".tests", "")
    $results += Invoke-Pester $_ -CodeCoverage $originalScript
}