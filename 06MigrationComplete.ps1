#test001
Import-Csv -Path .\migrationConfigFile.csv | foreach {
    # List replicating VMs and filter the result for selecting a replicating VM. This cmdlet will not return all properties of the replicating VM.
    $ReplicatingServer = Get-AzMigrateServerReplication -ProjectName $_.MigrateProject -ResourceGroupName $_.ResourceGroup -MachineName $_.MachineName
    
    # Stop replication for a migrated server
    $StopReplicationJob = Remove-AzMigrateServerReplication -InputObject $ReplicatingServer
    
    # Track job status to check for completion
    while (($StopReplicationJob.State -eq 'InProgress') -or ($StopReplicationJob.State -eq 'NotStarted')){
            #If the job hasn't completed, sleep for 10 seconds before checking the job status again
            sleep 10;
            $StopReplicationJob = Get-AzMigrateJob -InputObject $StopReplicationJob
    }
    # Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded".
    Write-Output $StopReplicationJob.State
    }