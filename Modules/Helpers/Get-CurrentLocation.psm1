# Function to get current directory
function Get-CurrentLocation {
  $pwd = Get-Location
  $path = $pwd.Path
  return $path
}
Export-ModuleMember -Function Get-CurrentLocation