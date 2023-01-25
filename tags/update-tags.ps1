# Fuerza heredar los tags del grupo de recrusos a los recursos.
#
Param(
    [Parameter(Mandatory, HelpMessage = "Please provide a valid Resource Group Name")]
    $ResourceGroupName
)

$mergedTags=(Get-AzResourceGroup -Name $resourceGroupName).tags
Get-AzResource -ResourceGroupName $resourceGroupName | foreach {
    Update-AzTag -ResourceId $_.ResourceId -Tag $mergedTags -Operation Merge
}