#test003
Import-Csv -Path .\migrationConfigFile.csv | foreach {

    # List replicating VMs and filter the result for selecting a replicating VM. This cmdlet will not return all properties of the replicating VM.
    $ReplicatingServer = Get-AzMigrateServerReplication -ProjectName $_.MigrateProject -ResourceGroupName $_.ResourceGroup -MachineName $_.MachineName
    
    # Start migration for a replicating server and turn off source server as part of migration
    #$MigrateJob = Start-AzMigrateServerMigration -InputObject $ReplicatingServer -TurnOffSourceServer
    $MigrateJob = Start-AzMigrateServerMigration -InputObject $ReplicatingServer
    # Track job status to check for completion
    while (($MigrateJob.State -eq 'InProgress') -or ($MigrateJob.State -eq 'NotStarted')){
            #If the job hasn't completed, sleep for 10 seconds before checking the job status again
            sleep 10;
            $MigrateJob = Get-AzMigrateJob -InputObject $MigrateJob
    }
    #Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded".
    Write-Output $MigrateJob.State
    }