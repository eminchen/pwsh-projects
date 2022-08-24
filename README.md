# pwsh-projects

The current project exhibits an example how to configure Cisco UCS server using Intersight Server profile using powershell. 

The project assumes powershell for Windows or Mac is already deployed on the management station. For information on how to install Inersight powershell follow this resource: https://github.com/CiscoDevNet/intersight-powershell

Step-by-step guide

1. Use existing Intersight account or register for new account at intersight.com

   Intersight help on how to register for an evaluation Intersight.com account: 
   https://developer.cisco.com/learning/modules/intersight-rest-api/cisco-intersight-rest-api-keys/introduction-to-the-cisco-intersight-rest-api/

2. Create and download API key to the current powershell directory and change name to "pwsh-key-tme.txt". In the example, this file name is used to load API Key. 
   
   Intersight help on how to obtain API key: 
   https://developer.cisco.com/learning/modules/intersight-rest-api/cisco-intersight-rest-api-keys/introduction-to-the-cisco-intersight-rest-api/

3. Claim or use exixting unconfigured stand alone Cisco UCS C-series server serial number

   Intersight help on how to claim UCS server in the created Intersight account: 
   https://developer.cisco.com/learning/modules/intersight-rest-api/cisco-intersight-rest-api-keys/introduction-to-the-cisco-intersight-rest-api/

4. Create desired Intersight Server Profile template that will be used to clone server profile from

   https://intersight.com/help/saas/features/servers/configure#server_profile_templates

5. Execute DeployServer-TME.ps1 and supply requred parameters
