Install-Module Az
Update-Module -Name Az
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Connect-AzAccount -UseDeviceAuthentication


##create a resource group with user input location and name 

$resname = Read-Host 'What is your resource group name'
$resloc = Read-Host "What is the location you want to set up"

New-AzResourceGroup -Name $resname -Location $resloc

##Creating a virtual network

$count = Read-Host "Press.1 to create a virtual network"

if($count -eq 1)
{
$myVnet = Read-Host "Enter the Vnet name"
$vnet = @{
    Name = $myVnet
    ResourceGroupName = $resname
    Location = $resloc
    AddressPrefix = '10.0.0.0/16'
}
$virtualNetwork = New-AzVirtualNetwork @vnet
}

##SUBNET CREATION
$flag = Read-Host "Press.1 to add subnet to existing Vnet"
if($flag -eq 1)
{
$firstsubnet= Read-Host "Enter subnet name"

#assigning subnet with vnet
Add-AzVirtualNetworkSubnetConfig -Name $firstsubnet -VirtualNetwork $virtualNetwork -AddressPrefix "10.0.2.0/24"

#setting virtual network
$virtualNetwork | Set-AzVirtualNetwork
}