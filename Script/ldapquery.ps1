# PowerShell script to execute an LDAP query that will likely trigger Event ID 1644
# This event occurs when a query exceeds the maximum result size limit

# Domain Controller details
$domainController = "GHD-DC-01.company.com" # Replace with your DC name
$searchBase = "DC=company,DC=com" # Replace with your domain components

# Create a connection to the Domain Controller
$ldapConnection = New-Object System.DirectoryServices.DirectoryEntry("LDAP://$domainController/$searchBase")

# Create the searcher with a very broad query
$searcher = New-Object System.DirectoryServices.DirectorySearcher($ldapConnection)

# Set a filter that will return a large number of objects
# This filter selects all objects in the domain
$searcher.Filter = "(objectClass=*)"

# Configure search to intentionally trigger the size limit exceeded error
$searcher.PageSize = 0 # Disable paging to ensure all results come at once
$searcher.SizeLimit = 0 # Request unlimited results (the server will still enforce its limit)

# Set additional properties to maximize result size
$searcher.PropertiesToLoad.Add("*") # Request all properties for each object

try {
    Write-Host "Executing LDAP query that may trigger Event ID 1644..."
    $results = $searcher.FindAll()
    Write-Host "Query completed with $($results.Count) results"
} 
catch [System.DirectoryServices.DirectoryServicesCOMException] {
    # This exception is expected when the size limit is exceeded
    Write-Host "Expected error occurred: $($_.Exception.Message)"
    Write-Host "This should have triggered Event ID 1644 on the domain controller"
}
finally {
    # Clean up resources
    if ($null -ne $results) {
        $results.Dispose()
    }
    $searcher.Dispose()
    $ldapConnection.Dispose()
}

Write-Host "Check the Directory Service event log on $domainController for Event ID 1644"