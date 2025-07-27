param name string
param location string
param sku string
resource plan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: name
  location: location
  sku: {
    name: sku
    tier: 'FreeF1'
  }
  properties: {
    reserved: false
  }
}
output planId string = plan.id
