#testing001
Import-Csv -Path .\migrationConfigFile.csv | foreach {
    $ReplicatingServer = Get-AzMigrateServerReplication -ProjectName $_.MigrateProject -ResourceGroupName $_.ResourceGroup -MachineName $_.MachineName
        # Clean-up test migration for a replicating server
    $CleanupTestMigrationJob = Start-AzMigrateTestMigrationCleanup -InputObject $ReplicatingServer
    
    # Track job status to check for completion
    while (($CleanupTestMigrationJob.State -eq "InProgress") -or ($CleanupTestMigrationJob.State -eq "NotStarted")){
            #If the job hasn't completed, sleep for 10 seconds before checking the job status again
            sleep 10;
            $CleanupTestMigrationJob = Get-AzMigrateJob -InputObject $CleanupTestMigrationJob
    }
    # Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded".
    Write-Output $CleanupTestMigrationJob.State
    }