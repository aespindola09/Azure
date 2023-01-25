<#
.SYNOPSIS
    Script to backups tags resources in subscription
.DESCRIPTION
    Script to backups tags resources in the subscription
.PARAMETER Days
    Specifies the subscription

.EXAMPLE
    ./Backup-TagsForSubscription.ps1 -SubscriptionName suscrption-testing
.NOTES
    Alexis Espindola
    aespindola09@gmail.com
    VERSION HISTORY
    1.0 2023/01/25    Initial Version
    TODO
        Send-Mailmessage in begin
#>

Param(
    [Parameter(Mandatory, HelpMessage = "Please provide a valid SubscriptionName Name")]
    $SubscriptionName
)
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('MM-dd-yyyy_hh-mm-ss')

$path = "$pwd/BackupsTagSubscriptions"
If(!(test-path -PathType container $path)) 
    { 
        New-Item -ItemType Directory -Path $path
        }


$ListResource = (Get-AzResource | Select-Object Name, ResourceGroupName, ResourceType, Location, ResourceID, Tags | Convertto-json | ConvertFrom-json) 
Write-Host -ForegroundColor green "Backup of resource tags in $SubscriptionName"

$ListCSV = "BackupTags_$SubscriptionName-$CurrentDate.csv"
$ListResource | Export-Csv -path $path/$ListCSV -NoTypeInformation
Write-Host -ForegroundColor green "Export in Backups/$ListCSV"


