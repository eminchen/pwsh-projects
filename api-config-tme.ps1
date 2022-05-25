$ApiParams = @{
        BasePath          = "https://intersight.com"
        ApiKeyId          = Get-Content -Path ../pwsh-key-tme.txt -Raw
        ApiKeyFilePath    = ”../pwsh-secret-tme.txt"
        HttpSigningHeader = @("(request-target)", "Host", "Date", "Digest")
    }
    
Set-IntersightConfiguration @ApiParams