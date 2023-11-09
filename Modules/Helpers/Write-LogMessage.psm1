# Function to write log message in log file
function Write-LogMessage {
    param (
      [string] $message
    ) 
  Add-Content -Path './log/conversion-log.txt' -Value "$message | $(Get-Date -f yyy-MM-dd-hh:mm:ss)"
}

Export-ModuleMember -Function  Write-LogMessage

