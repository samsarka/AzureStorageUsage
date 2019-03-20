Connect-AzureRmAccount
Select-AzureRMSubscription -SubscriptionId "*********"
$liststracc = Get-AzureRmStorageAccount
foreach ($stracc in $liststracc)
{

    $resourceGroup = $stracc.ResourceGroupName
    $storageAccountName = $stracc.storageaccountname
    $location = $stracc.Location

    $storageAccount = Get-AzureRmStorageAccount -StorageAccountName $storageAccountName -ResourceGroupName $resourceGroup
    $ctx = $storageAccount.Context 
    $listcontainers = Get-AzureStorageContainer -Context $ctx
        
    $length = 0

    foreach ($container in $listcontainers)
    {
        $listOfBLobs = Get-AzureStorageBlob -Container $container.Name -Context $ctx 
        $listOfBlobs | ForEach-Object {$length = $length + $_.Length}
    }


    Write-Host  "$resourceGroup | $storageAccountName | $location" -ForegroundColor Yellow
    Write-Host "Blob Size = " ((($length/1024)/1024)/1024)"GB" 
}