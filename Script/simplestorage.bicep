param storageAccounts_ghdst0019dev_name string = 'ghdst0019dev'

resource storageAccounts_ghdst0019dev_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_ghdst0019dev_name
  location: 'westus'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_ghdst0019dev_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_ghdst0019dev_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_ghdst0019dev_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_ghdst0019dev_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_ghdst0019dev_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_ghdst0019dev_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_ghdst0019dev_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_ghdst0019dev_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}
