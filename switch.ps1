#Switch DNS Modifier v0.5.3 Written by Unbinilium https://unbinilium.github.io/Switch/
$ErrorActionPreference = "Continue"

#Check if Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process -FilePath "powershell" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

#Start Up with Base64 Encoded
$Start_Up = "V3JpdGUtSG9zdCAtRm9yZWdyb3VuZENvbG9yIEdyYXkgIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIg0KV3JpdGUtSG9zdCAtRm9yZWdyb3VuZENvbG9yIEdyYXkgIiAgICAgICAgICAgICAgICoqKioiDQpXcml0ZS1Ib3N0IC1Gb3JlZ3JvdW5kQ29sb3IgR3JheSAiICAgICAgICAgICAgKioqKioqKiogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqKiINCldyaXRlLUhvc3QgLUZvcmVncm91bmRDb2xvciBHcmF5ICIgICAgICAgICAgICoqKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoqIg0KV3JpdGUtSG9zdCAtRm9yZWdyb3VuZENvbG9yIEdyYXkgIiAgICAgICAgICAgICAqKiogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKioiDQpXcml0ZS1Ib3N0IC1Gb3JlZ3JvdW5kQ29sb3IgR3JheSAiICAgICAgICAgICAgICAgKioqICAgICAgICAgICAgICAgICAgICoqICAgICoqICAgICAgICAgICAqKiINCldyaXRlLUhvc3QgLUZvcmVncm91bmRDb2xvciBHcmF5ICIgICAgICAgICAgICAgICAgICoqKiAgICAgICAgICAgICAgICAgICAgICAgKiogICAgKioqKioqICoqKioqKioqIg0KV3JpdGUtSG9zdCAtRm9yZWdyb3VuZENvbG9yIEdyYXkgIiAgICAgICAgICAgICAgICAgICAqKiogICAgICAqICAgICoqKiAqKiAqKioqKioqKiAqKiAgICAgKiogICAgKioiDQpXcml0ZS1Ib3N0IC1Gb3JlZ3JvdW5kQ29sb3IgR3JheSAiICAgICAgICAgICAqKioqKioqKiogICoqKiAgKioqICAqKiogICoqICAgICoqICAgICoqICAgICAqKiAgICAqKiINCldyaXRlLUhvc3QgLUZvcmVncm91bmRDb2xvciBHcmF5ICIgICAgICAgICAgICAgKioqKiogICAgICAqKiogICAqKiogICAgKiogICAgKioqKiogKioqKioqICoqICAgICoqIg0KV3JpdGUtSG9zdCAtRm9yZWdyb3VuZENvbG9yIEdyYXkgIi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIg0KV3JpdGUtSG9zdCAtRm9yZWdyb3VuZENvbG9yIEdyYXkgIiAgICAgICAgICAgICAgICAgU3dpdGNoIEROUyBNb2RpZmllciBXcml0dGVuIGJ5IFVuYmluaWxpdW0iDQpXcml0ZS1Ib3N0IC1Gb3JlZ3JvdW5kQ29sb3IgR3JheSAiLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0i"

#Display Start Up
$Start_Up_TMP = [System.IO.Path]::GetTempFileName() | Rename-Item -NewName { $_ -replace 'tmp', 'StartUp.ps1' } -PassThru
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($Start_Up)) | Out-File -FilePath "$Start_Up_TMP"
powershell "$Start_Up_TMP"
Remove-Item -Path "$Start_Up_TMP"

#DNS List with Base64 Encoded
$DNS_List = "IzExNEROUy8iMTE0LjExNC4xMTQuMTE0IiwiMTE0LjExNC4xMTUuMTE1Ig0KI0dvb2dsZS8iOC44LjguOCIsIjguOC40LjQiDQojQ2xvdWRmbGFyZS8iMS4xLjEuMSIsIjEuMC4wLjEiDQojQWxpeXVuLyIyMjMuNS41LjUiLCIyMjMuNi42LjYiDQojQ05OSUMvIjEuMi40LjgiLCIyMTAuMi40LjgiDQojQmFpZHUvIjE4MC43Ni43Ni43NiINCiNEbnNwb2QvIjExOS4yOS4yOS4yOSIsIjE4Mi4yNTQuMTE2LjExNiINCiNPcGVuRE5TLyIyMDguNjcuMjIyLjIyMiIsIjIwOC42Ny4yMjAuMjIwIg0KI01pY3Jvc29mdC8iNC4yLjIuMSIsIjQuMi4yLjIiDQojQ3VzdG9tLw0KI0RlZmF1bHQv"

#Generate DNS List TMP Path and Decode DNS List
$DNS_List_TMP = [System.IO.Path]::GetTempFileName() | Rename-Item -NewName { $_ -replace 'tmp', 'DnsList' } -PassThru
[System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($DNS_List)) | Out-File -FilePath "$DNS_List_TMP"

#Specialize DNS Provider
Write-Host "Supported DNS Providers:"
$DNS_Provider_Name_TMP = [System.IO.Path]::GetTempFileName() | Rename-Item -NewName { $_ -replace 'tmp', 'DNSProviderName' } -PassThru
foreach($DNS_Provider_Name in Get-Content -Path "$DNS_List_TMP") {
   $DNS_Provider_Name = (($DNS_Provider_Name) -split "/" | Select-Object -First 1).replace('#',', ')
   Out-File -FilePath "$DNS_Provider_Name_TMP" -InputObject "$DNS_Provider_Name" -Append -NoNewline
}
$DNS_Provider_Name = (Get-Content -Path "$DNS_Provider_Name_TMP").substring(2)
Write-Host -ForegroundColor Gray -Object "$DNS_Provider_Name"
$DNS_Provider = Read-Host -Prompt 'Please Enter DNS Provider Name to Process (Use " " to spilt)'

#Extract DNS Server from DNS List TMP
$DNS_Server_TMP = [System.IO.Path]::GetTempFileName() | Rename-Item -NewName { $_ -replace 'tmp', 'DNSServer' } -PassThru
foreach ($DNS in $DNS_Provider.Split(" ")) {
    if ($DNS | Select-String -Pattern 'Custom') { 
        $Custom_DNS_Address = Read-Host -Prompt 'Please Enter Custome DNS Address (Use "," to spilt)'
        $Custom_DNS_Address = $Custom_DNS_Address.replace(',','","')
        Out-File -FilePath "$DNS_Server_TMP" -InputObject "`"$Custom_DNS_Address`"," -Append -NoNewline
    }
    else {
        $DNS_Address = (Select-String -Path $DNS_List_TMP -Pattern "$DNS") -split "/" | Select-Object -Skip 1 -First 1
        Out-File -FilePath "$DNS_Server_TMP" -InputObject "$DNS_Address," -Append -NoNewline
    }
}
$DNS_Server = (Get-Content -Path "$DNS_Server_TMP" -Raw).TrimEnd(',')

#Generate Network Adapter TMP Path and Extract Net Adapter Index as table
$Net_Adapter_TMP = [System.IO.Path]::GetTempFileName() | Rename-Item -NewName { $_ -replace 'tmp', 'NetAdapter' } -PassThru
Get-NetAdapter | Select-Object -Property "ifIndex" | Format-Table -AutoSize | Out-File -FilePath "$Net_Adapter_TMP"
$Net_Adapter_Index = (Get-Content -Path "$Net_Adapter_TMP") -creplace "ifIndex", "" -creplace "-", "" | ForEach-Object {$_.Trim()} | Where-Object { $_ } | Sort-Object

#Execute DNS change for each Network Adapter
$Execute_DNS_TMP = [System.IO.Path]::GetTempFileName() | Rename-Item -NewName { $_ -replace 'tmp', 'ExecuteDNS.ps1' } -PassThru
if ($DNS_Provider | Select-String -Pattern 'Default') {
    foreach ($Net_Adapter in $Net_Adapter_Index) {
        Set-DnsClientServerAddress -InterfaceIndex "$Net_Adapter" -ResetServerAddresses
    }
}
else {
    foreach ($Net_Adapter in $Net_Adapter_Index) {
        Out-File -FilePath "$Execute_DNS_TMP" -InputObject "Set-DnsClientServerAddress -InterfaceIndex `"$Net_Adapter`" -ServerAddresses ($DNS_Server)" -Append
    }
    powershell "$Execute_DNS_TMP"
    Remove-Item -Path "$Execute_DNS_TMP"
}

#Clean up TEMP
Remove-Item -Path "$DNS_List_TMP"
Remove-Item -Path "$DNS_Provider_Name_TMP"
Remove-Item -Path "$DNS_Server_TMP"
Remove-Item -Path "$Net_Adapter_TMP"

#Show Results
Get-DnsClientServerAddress

#Press Enter to exit
Read-Host -Prompt 'DNS Change Execution Finished, Please Press Enter to Exit'
exit
