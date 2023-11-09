# Function to stop process by name
function Stop-ProcessByName {
  param (
      [string]$processName
  )

  $process = Get-Process | Where-Object { $_.Name -match $processName }

  if ($null -ne $process) {
      Stop-Process $process.Id
  }
}
Export-ModuleMember -Function  Stop-ProcessByName
