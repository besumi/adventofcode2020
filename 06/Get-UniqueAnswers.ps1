[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [System.Collections.ArrayList]$Group,
    [switch]$Unanimous
)

If ($Unanimous) {
    [char[]]$unanimousVotes = $Group[0].ToCharArray()
    $null = $Group.RemoveAt(0)
    Foreach ($item in $Group) {
        $charArray = $item.ToCharArray()
        
        $unanimousVotes = $charArray | Where-Object {$_ -in $unanimousVotes}
    }

    $unanimousVotes.Count
}
Else {
    [char[]]$characters = @()

    Foreach ($item in $Group) {
        $charArray = $item.ToCharArray()
        Foreach ($char in $charArray) {
            If ($Unanimous) {
    
            }
            Else {
                $characters += $char
            }
        }
    }
    
    $characters = $characters | Sort-Object -Unique
    $characters.Count
}


