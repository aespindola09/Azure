<#
.SYNOPSIS
    Script to backups tags resources in Resource Group
.DESCRIPTION
    Script to backups tags resources in the Resource Group
.PARAMETER Days
    Specifies the ResourceGroupName

.EXAMPLE
    ./Backup-TagsForSResourceGroup.ps1 -ResourceGroupName testing-rg
.NOTES
    Alexis Espindola
    aespindola09@gmail.com
    VERSION HISTORY
    1.0 2023/01/25    Initial Version
    TODO
        Send-Mailmessage in begin
#>

Param(
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Resource Group Name")]
    $ResourceGroupName
)
$CurrentDate = Get-Date
$CurrentDate = $CurrentDate.ToString('MM-dd-yyyy_hh-mm-ss')

$path = "$pwd/BackupsTag"
If(!(test-path -PathType container $path)) 
    { 
        New-Item -ItemType Directory -Path $path
        }


$ListResource = (Get-AzResource -ResourceGroupName $ResourceGroupName | Select-Object Name, ResourceGroupName, ResourceID, Tags | Convertto-json | ConvertFrom-json) 
Write-Host -ForegroundColor green "Backup of resource tags in $ResourceGroupName"

$ListCSV = "BackupTags_$ResourceGroupName-$CurrentDate.csv"
$ListResource | Export-Csv -path $path/$ListCSV -NoTypeInformation
Write-Host -ForegroundColor green "Export in Backups/$ListCSV"


