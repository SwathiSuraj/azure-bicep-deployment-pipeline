targetScope = 'subscription'

param location string = 'eastus'

param resourceGroupName string = 'ebay-dev-bicep-rg-11'

@description('SSH public key used to access the Linux VM.')
param sshPublicKey string

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}
module storageAccount 'modules/storage.bicep' = {
  name: 'storageAccountDeployment'
  scope: rg
  params: {
    location: location
    storageAccountName: 'stbicepdev2026sw'
  }
}
module virtualMachine 'modules/vm.bicep' = {
  name: 'virtualMachineDeployment'
  scope: rg
  params: {
    location: location
    vmName: 'vm-bicep-dev-001'
    sshPublicKey: sshPublicKey
  }
}
