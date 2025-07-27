param location string = resourceGroup().location
param environment string
param appName string
module storage './modules/storage.bicep' = {
  name: 'storageDeploy'
  params: {
    name: '${appName}stg${environment}'
    location: location
  }
}
module plan './modules/appservice.bicep' = {
  name: 'appServicePlanDeploy'
  params: {
    name: '${appName}plan${environment}'
    location: location
    sku: 'F1'
  }
}
module app './modules/app.bicep' = {
  name: 'webAppDeploy'
  params: {
    name: '${appName}-${environment}'
    location: location
    planId: plan.outputs.planId
    insightsInstrumentationKey: insights.outputs.instrumentationKey
  }
}
module insights './modules/insights.bicep' = {
  name: 'appInsightsDeploy'
  params: {
    name: '${appName}-ai-${environment}'
    location: location
  }
}
module keyvault './modules/keyvault.bicep' = {
  name: 'kvDeployljg'
  params: {
    name: '${appName}-kv-${environment}'
    location: location
  }
}

// az deployment group create \
//  --resource-group my-rg \
//  --template-file main.bicep \
//  --parameters @parameters.dev.json
