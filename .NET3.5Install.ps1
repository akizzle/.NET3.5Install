$servicepath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Servicing'
$output = Write-Output 'Installing .Net Framework 3.5'
$cleanup = Write-Output 'Performing cleanup'

#.net 3.5 Install
if(!(Get-Item $servicepath)){
    Write-Output 'Path does not exist'
    New-Item $servicepath
    New-ItemProperty $servicepath -PropertyType ExpandString -Name LocalSourcePath
    New-ItemProperty $servicepath -PropertyType DWORD -Name RepairContentServerSource -Value 2
    $output
    Enable-WindowsOptionalFeature -FeatureName NetFx3 -Online
    $cleanup
    Remove-Item -Path $servicepath
}else{
    Write-Output 'Path already exists'
    New-ItemProperty $servicepath -PropertyType ExpandString -Name LocalSourcePath
    New-ItemProperty $servicepath -PropertyType DWORD -Name RepairContentServerSource -Value 2
    $output
    Enable-WindowsOptionalFeature -FeatureName NetFx3 -Online
    $cleanup
    Remove-ItemProperty $servicepath -Name LocalSourcePath, RepairContentServerSource
}
