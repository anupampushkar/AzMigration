#test 009
Import-Csv -Path .\migrationConfigFile.csv | foreach {
    # List replicating VMs and filter the result for selecting a replicating VM. This cmdlet will not return all properties of the replicating VM.
    $ReplicatingServer = Get-AzMigrateServerReplication -ProjectName $_.MigrateProject -ResourceGroupName $_.ResourceGroup -MachineName $_.MachineName
    
    # Retrieve the Azure virtual network created for testing
    $TestVirtualNetwork = Get-AzVirtualNetwork -Name $_.TestRecVirtualNetwork
    
    # Start test migration for a replicating server
    $TestMigrationJob = Start-AzMigrateTestMigration -InputObject $ReplicatingServer -TestNetworkID $TestVirtualNetwork.Id
    
    # Track job status to check for completion
    while (($TestMigrationJob.State -eq 'InProgress') -or ($TestMigrationJob.State -eq 'NotStarted')){
            #If the job hasn't completed, sleep for 10 seconds before checking the job status again
            sleep 10;
            $TestMigrationJob = Get-AzMigrateJob -InputObject $TestMigrationJob
    }
    # Check if the Job completed successfully. The updated job state of a successfully completed job should be "Succeeded".
    Write-Output $TestMigrationJob.State
    }