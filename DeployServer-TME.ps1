<#
Copyright (c) 2021 Cisco and/or its affiliates.
This software is licensed to you under the terms of the Cisco Sample
Code License, Version 1.0 (the "License"). You may obtain a copy of the
License at
               https://developer.cisco.com/docs/licenses
All use of the material herein must be in accordance with the terms of
the License. All rights not expressly granted by the License are
reserved. Unless required by applicable law or agreed to separately in
writing, software distributed under the License is distributed on an "AS
IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
or implied.
#>

# This script deployes server profile to a server by serial number .

[cmdletbinding()]
param(
#supply powershell CLI parameter for desired server profile name
    [parameter(Mandatory = $true)]
    [string]$ServerProfileName,
#supply powershell CLI parameter for already claimed unconfigured Cisco UCS server
    [parameter(Mandatory = $true)]
    [string]$ServerSerialNumber,
#supply powershell CLI parameter for existing server profile template name used to create new server profile
    [parameter(Mandatory = $true)]
    [string]$ServerProfileTemplateName
)

# configure api key sign in params
. "$PSScriptRoot\api-config-tme.ps1"

# loading server profile template
$source = Get-IntersightServerProfileTemplate -Name $ServerProfileTemplateName

#setting up Org name where profile is getting created
$orgRef = Get-IntersightOrganizationOrganization -Name default

#initialize new server profile in specified org
$targetProfile = Initialize-IntersightServerProfile -Name $ServerProfileName -Description "cloned from template" -Organization (Get-IntersightMoMoRef -ManagedObject ($orgRef))

#derriving server profile from template
New-IntersightBulkMoCloner -Sources $source -Targets $targetProfile

Write-Host $ServerSerialNumber
Write-Host $ServerProfileName

#look up server by serial number
$targetserver = Get-IntersightComputeRackUnit -Serial $ServerSerialNumber

#assign server profile to server
Get-IntersightServerProfile -Name $ServerProfileName | Set-IntersightServerProfile -AssignedServer (Get-IntersightMoMoRef -ManagedObject ($targetserver))

#get configured server profile
$updatedprofile = Get-IntersightServerProfile -Name $ServerProfileName

#get server profile status
$updatedprofile.ConfigContext.OperState

#deploy server profile
$updatedprofile = Set-IntersightServerProfile -Moid $updatedprofile.Moid -Action "Deploy"

#wait until deployment completes
do { 
    $updatedprofile = Get-IntersightServerProfile -Name $ServerProfileName
    $updatedprofile.ConfigContext.OperState
    sleep 30
 } while (
    $updatedprofile.ConfigContext.OperState -eq "Configuring"
    )
