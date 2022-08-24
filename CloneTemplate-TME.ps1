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

# This script derrives server profile from template.

[cmdletbinding()]
param(
    [parameter(Mandatory = $true)]
    [string]$ServerProfileTemplateName
    [parameter(Mandatory = $true)]
    [string]$ServerProfileName
)

# configure api signing params
. "$PSScriptRoot\api-config-tme.ps1"

$source = Get-IntersightServerProfileTemplate -Name $ServerProfileTemplateName

$orgRef = Get-IntersightOrganizationOrganization -Name default

$targetProfile = Initialize-IntersightServerProfile -Name $ServerProfileName -Description "cloned from template" -Organization (Get-IntersightMoMoRef -ManagedObject ($orgRef))

New-IntersightBulkMoCloner -Sources $source -Targets $targetProfile
