#testing 001
Import-Csv -Path .\monitordata.csv | foreach {
    # List replicating VMs and filter the result for selecting a replicating VM. This cmdlet will not return all properties of the replicating VM.
    $ReplicatingServer = Get-AzMigrateServerReplication -ProjectName $_.MigrateProject -ResourceGroupName $_.ResourceGroup -MachineName $_.MachineName
    
    # Retrieve all properties of a replicating VM 
    $ReplicatingServer = Get-AzMigrateServerReplication -TargetObjectID $ReplicatingServer.Id
    
    Write-Output $replicatingserver.ProviderSpecificDetail
    write-host $replicatingserver.ProviderSpecificDetail
    }
    

$ReplicatingServer = Get-AzMigrateServerReplication -ProjectName "AZ-MIG-Demo" -ResourceGroupName "RG_HelloWorld" -MachineName "CL-WIN-WEB-01"
 
$ReplicatingServer = Get-AzMigrateServerReplication -TargetObjectID $ReplicatingServer.Id
    