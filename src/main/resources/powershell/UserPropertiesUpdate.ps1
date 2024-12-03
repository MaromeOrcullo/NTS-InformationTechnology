# Path to your CSV file
$csvFilePath = "C:\Work\NovusTechnicalServices\NTS-InformationTechnology\src\main\resources\csv\Novus-Employee-Master-2024C.csv"
# Path to the log file
$logFilePath = "C:\Work\NovusTechnicalServices\NTS-InformationTechnology\src\main\resources\logs\Novus-Employee-Master-2024C.logs"

# Start logging
Start-Transcript -Path $logFilePath

Connect-MgGraph -Scopes "User.ReadWrite.All"

# Import the CSV file
$users = Import-Csv -Path $csvFilePath

foreach ($user in $users) {
    # Get Entra User
    $currentUser = Get-EntraUser -UserId $user.UserPrincipalName -ErrorAction SilentlyContinue
    #Update-MgUser -UserId "marome.orcullo@novustechserv.com" -OfficeLocation "Fifth Avenue Place West Tower"
    #Update-MgUser -UserId $user.UserId -UsageLocation $user.UsageLocation -Department $user.Department
    #Update-MgUser -UserId $user.UserId -OfficeLocation $user.Office
    if("" -ne $user.officeLocation){
        Update-MgUser -UserId $currentUser.UserPrincipalName -OfficeLocation $user.officeLocation
        Write-Host "User: $($currentUser.UserPrincipalName) | $($user.officeLocation)"
    } else{
        Update-MgUser -UserId $currentUser.UserPrincipalName -OfficeLocation $user.officeLocation
        Write-Host "User: $($currentUser.UserPrincipalName) | $($user.officeLocation)"
    }
}

Stop-Transcript

#Disconnect-MgGraph



