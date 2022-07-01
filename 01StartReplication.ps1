# Start replication for VMs in an Azure Migrate project all 107% work with new details lets see
Import-Csv -Path .\migrationConfigFile.csv | foreach {
    $DiscoveredServer = Get-AzMigrateDiscoveredServer -ProjectName $_.MigrateProject -ResourceGroupName $_.MResourceGroup -DisplayName $_.MachineName
    $TargetResourceGroup = Get-AzResourceGroup -Name $_.ResourceGroup
    $TargetVirtualNetwork =  Get-AzVirtualNetwork -Name $_.TargetVirtualNetwork
    #$MigrateJob =  New-AzMigrateServerReplication -InputObject $DiscoveredServer -TargetResourceGroupId $TargetResourceGroup.ResourceId -TargetNetworkId $TargetVirtualNetwork.Id -LicenseType NoLicenseType -OSDiskID $DiscoveredServer.Disk[0].Uuid -TargetSubnetName $TargetVirtualNetwork.Subnets[0].Name -DiskType Standard_LRS -TargetVMName MyMigratedTestVM -TargetVMSize Standard_DS2_v2
    $MigrateJob =  New-AzMigrateServerReplication -InputObject $DiscoveredServer -TargetResourceGroupId $TargetResourceGroup.ResourceId -TargetNetworkId $TargetVirtualNetwork.Id -LicenseType NoLicenseType -OSDiskID $DiscoveredServer.Disk[0].Uuid -TargetSubnetName $_.TargetSubnetName -DiskType Standard_LRS -TargetVMName $_.RVmName -TargetVMSize Standard_DS2_v2
    }