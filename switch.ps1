#Switch v0.3.1 written by Unbinilium

#Check if Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

#Set Error Action and Start up
$ErrorActionPreference = "Continue"
Write-Host "-----------------------------------------------------------------"
Write-Host "          ****"
Write-Host "        ********"
Write-Host "      ***                                          **"
Write-Host "        ***                                        **"
Write-Host "          ***                   **    **           **"
Write-Host "            ***                       **    ****** ********"
Write-Host "              ***      *    *** ** ******** **     **    **"
Write-Host "      *********  ***  ***  ***  **    **    **     **    **"
Write-Host "        *****      ***   ***    **    ***** ****** **    **"
Write-Host "-----------------------------------------------------------------"
Write-Host "            Switch DNS Modifier Written by Unbinilium"
Write-Host "-----------------------------------------------------------------"

#DNS List with Base64 Encoded
#114DNS/"114.114.114.114","114.114.115.115"
#Google/"8.8.8.8","8.8.4.4"
#Cloudflare/"1.1.1.1","1.0.0.1"
#Aliyun/"223.5.5.5","223.6.6.6"
#CNNIC/"1.2.4.8","210.2.4.8"
#Baidu/"180.76.76.76"
#Dnspod/"119.29.29.29","182.254.116.116"
#OpenDNS/"208.67.222.222","208.67.220.220"
#Microsoft/"4.2.2.1","4.2.2.2"
#Custom/
#Default/
$DNS_List = "IzExNEROUy8iMTE0LjExNC4xMTQuMTE0IiwiMTE0LjExNC4xMTUuMTE1Ig0KI0dvb2dsZS8iOC44LjguOCIsIjguOC40LjQiDQojQ2xvdWRmbGFyZS8iMS4xLjEuMSIsIjEuMC4wLjEiDQojQWxpeXVuLyIyMjMuNS41LjUiLCIyMjMuNi42LjYiDQojQ05OSUMvIjEuMi40LjgiLCIyMTAuMi40LjgiDQojQmFpZHUvIjE4MC43Ni43Ni43NiINCiNEbnNwb2QvIjExOS4yOS4yOS4yOSIsIjE4Mi4yNTQuMTE2LjExNiINCiNPcGVuRE5TLyIyMDguNjcuMjIyLjIyMiIsIjIwOC42Ny4yMjAuMjIwIg0KI01pY3Jvc29mdC8iNC4yLjIuMSIsIjQuMi4yLjIiDQojQ3VzdG9tLw0KI0RlZmF1bHQv"

#Generate DNS List TMP Path and decode DNS List
$DNS_List_TMP = [System.IO.Path]::GetTempFileName()
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($DNS_List)) | Out-File -FilePath "$DNS_List_TMP"

#Specialize DNS Provider
Write-Host "Supported DNS Providers:"
$DNS_Provider_Name_TMP = [System.IO.Path]::GetTempFileName()
foreach($DNS_Provider_Name in Get-Content -Path "$DNS_List_TMP") {
   $DNS_Provider_Name = (($DNS_Provider_Name) -split "/" | Select-Object -First 1).replace('#',', ')
   Out-File -FilePath "$DNS_Provider_Name_TMP" -InputObject "$DNS_Provider_Name" -Append -NoNewline
}
$DNS_Provider_Name = (Get-Content -Path "$DNS_Provider_Name_TMP").substring(2)
Write-Host -Object "$DNS_Provider_Name"
$DNS_Provider = Read-Host -Prompt 'Please Enter DNS Provider name to process (Use " " to spilt)'

#Extract DNS Server from DNS List TMP
$DNS_Server_TMP = [System.IO.Path]::GetTempFileName()
foreach ($DNS in $DNS_Provider.Split(" ")) {
    if ($DNS | Select-String -Pattern 'Custom') { 
        $Custom_DNS_Address = Read-Host -Prompt 'Please Enter Custome DNS Address (Use "," to spilt)'
        $Custom_DNS_Address = $Custom_DNS_Address.replace(',','","')
        Out-File -FilePath "$DNS_Server_TMP" -InputObject "`"$Custom_DNS_Address`"," -Append -NoNewline
    } else {
        $DNS_Address = (Select-String -Path $DNS_List_TMP -Pattern "$DNS") -split "/" | Select-Object -Skip 1 -First 1
        Out-File -FilePath "$DNS_Server_TMP" -InputObject "$DNS_Address," -Append -NoNewline
    }
}
$DNS_Server = (Get-Content -Path "$DNS_Server_TMP").TrimEnd(',')

#Generate Network Adapter TMP Path and extract Net Adapter Index as table
$Net_Adapter_TMP = [System.IO.Path]::GetTempFileName()
Get-NetAdapter | Select-Object -Property "ifIndex" | Format-Table -AutoSize | Out-File -FilePath "$Net_Adapter_TMP"
$Net_Adapter_Index = (Get-Content -Path "$Net_Adapter_TMP") -creplace "ifIndex", "" -creplace "-", "" | ForEach-Object {$_.Trim()} | Where-Object { $_ } | Sort-Object

#Execute DNS change for each Network Adapter
foreach ($Net_Adapter in $Net_Adapter_Index) {
    if ($DNS_Provider | Select-String -Pattern 'Default') {
        Set-DnsClientServerAddress -InterfaceIndex "$Net_Adapter" -ResetServerAddresses
    } else {
        Set-DnsClientServerAddress -InterfaceIndex "$Net_Adapter" -ServerAddresses ($DNS_Server) -Validate
    }
}

#Clean up TEMP
Remove-Item -Path "$DNS_List_TMP"
Remove-Item -Path "$DNS_Provider_Name_TMP"
Remove-Item -Path "$DNS_Server_TMP"
Remove-Item -Path "$Net_Adapter_TMP"

#Press Enter to exit
Read-Host -Prompt 'DNS Change Execution Finished, Please Press Enter to EXIT'
