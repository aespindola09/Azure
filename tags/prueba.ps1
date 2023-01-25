Get-AzSubscription | 
 % { 
   $subscrName = $_.Name
   Select-AzSubscription -Current -SubscriptionName $name
   (Get-AzResourceGroup).resourcegroupname | % {     
     [pscustomobject] @{
       Subscription = $subscrName
       ResourceGroup = $_
     }
   }
 }