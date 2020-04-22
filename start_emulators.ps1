function printAndLog
{
    param([string]$argstring = "unknown")
    Write-Output $argstring
    Add-Content C:\vagrant\service_loop.txt $argstring
}

printAndLog -argstring "--------------------------------"
printAndLog -argstring "Starting Azure Emulator Services"

Import-Module -Name "C:\Program Files\Azure Cosmos DB Emulator\PSModules\Microsoft.Azure.CosmosDB.Emulator" -Verbose

Do {
    $date1 = Get-Date -Date "01/01/1970"
    $date2 = Get-Date
    $epoch = (New-TimeSpan -Start $date1 -End $date2).TotalSeconds
    printAndLog -argstring "Service Loop: $epoch"

    Start-Sleep -s 60
    printAndLog -argstring "Start-CosmosDbEmulator"
    # "/computeport=0","/noui","/disableratelimiting"
    Start-Process "C:\Program Files\Azure Cosmos DB Emulator\CosmosDB.Emulator.exe" -ArgumentList "/allownetworkaccess","/key=C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==","/nofirewall" -ErrorAction Stop -PassThru
    printAndLog -argstring "AzureStorageEmulator.exe init /forceCreate"
    cmd.exe /c "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe init /forceCreate"
    printAndLog -argstring "AzureStorageEmulator.exe start"
    cmd.exe /c "C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe start"
    
} while($true)