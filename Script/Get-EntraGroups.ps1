# Import required module
Import-Module Microsoft.Graph.Groups

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All"

# Get all groups
$groups = Get-MgGroup -All

# Display results
$groups | Select-Object -Property Id, DisplayName, Mail, GroupTypes, CreatedDateTime | Format-Table -AutoSize

# Optional: Export to CSV
# $groups | Export-Csv -Path ".\groups_export.csv" -NoTypeInformation

Write-Host "Total groups retrieved: $($groups.Count)" -ForegroundColor Green
