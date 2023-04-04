$bldg = Read-Host "Please Enter Building"
$room = Read-Host "Please Enter Room Number"
$timeout = New-TimeSpan -Seconds 5
$endTime = (Get-Date).Add($timeout)
$appdata = $env:APPDATA
$pathzip = "$($appdata)"
$archive = ".\EULA.zip"
$testpath = test-path "$($env:APPDATA)\Ookla"

if ($testpath -eq "True") {

}

else {
Expand-Archive $archive -DestinationPath $pathzip | Out-Null
}


do {
    Write-Output "Waiting for Network..."
    $ping = test-connection -comp google.com -count 1 -Quiet
} until ($ping -eq "True" -or ((Get-Date) -gt $endTime))


if ($ping -eq 'True') {

$ip = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
$date = Get-Date -Format "yyyy/MM/dd"
Write-Output "Network Active!"
Write-Output "Running Test, Please Wait..."
$st = .\speedtest.exe --f=csv

Write-output """$($date)"",""$($bldg)"",""$($room)"",""$($ip)"",$($st)" >> test.csv |out-null

Write-Output "DONE!"
Write-Output "Exiting Script"
sleep 5

}

else {

$ip = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' }) | out-null
$date = Get-Date -Format "yyyy/MM/dd"
Write-Output "Test Failure Occured"
Write-output """$($date)"",""$($bldg)"",""$($room)"",""$($ip)"",""FAIL""" >> test.csv |out-null
Write-Output "Exiting Script"
sleep 5

}