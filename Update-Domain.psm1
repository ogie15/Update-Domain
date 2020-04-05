#Region Main Function
function Update-Domain {
    <#
    .SYNOPSIS
        This CMDLET is used to perform a bulk update of UserName's Domain on Office 365
    .DESCRIPTION
        This works together with the *Get-Msoluser* CMDLET 
        This also works with a CSV file with a column named *UserPrincipalName* to bulk update Office 365 User's Domain
    .EXAMPLE
        Get-MsolUser | Update-Upn -Domain "contoso.com"
        Get-MsolUser | Update-Upn -Dn "contoso.com"
        Get-MsolUser | Update-Upn "contoso.com"
        Get-MsolUser | Update-Upn -Domain "contoso.com" -Verbose
        --------------------------------------------------------------------------------------
        --This sets all the users domain in Office 365 to *contoso.com*--
        ** fabikram@contoso.onmicrosoft.com  to  fabikram@contoso.com **
        ** ibhadogiemu@contoso.onmicrosoft.com  to  ibhadogiemu@contoso.com **       
        ======================================================================================
        Import-Csv -Path .\DomainList.csv | Update-Upn -Domain "contoso.com"
        --------------------------------------------------------------------------------------
        --This sets all the users domain in the CSV File on Office 365 to *contoso.com*--
        ** fabikram@contoso.onmicrosoft.com  to  fabikram@contoso.com **
        ** ibhadogiemu@contoso.onmicrosoft.com  to  ibhadogiemu@contoso.com **

    .INPUTS
        Pipe line outputs from *Get-MsolUser*
        Pipe line outputs from *Imported Csv Files*
    .OUTPUTS
        None
    .NOTES
        When Using a CSV File, remember to name the column header which has the usernames as *UserPrincipalName*
    #>
    
    [CmdletBinding(PositionalBinding = $false, SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $false,
            Position = 0,
            HelpMessage = "Enter a Verified Domain name on your Office 365 Tenant")]
        [Alias("Dn")]
        [String]
        $Domain,

        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [String]
        $UserPrincipalName

    )
        
    begin {
        [Int32]$Script:Divisor = 0
        [Int32]$Script:i = 0 
    }
    
    # process {
        
    # }
    
    end {
        $input | Measure-Size 

        Write-Warning "This is a WARNING -----Running this will change the Domain Name of all piped in Username on Office 365" -WarningAction Inquire
        
        foreach ($UserPrincipalNames in $input) {

            if ($PSCmdlet.ShouldProcess($UserPrincipalNames.UserPrincipalName, "UPN update")) { 

                #Region Get Prefix
                $Symbol = $UserPrincipalNames.UserPrincipalName.IndexOf("@")

                $Prefix = $UserPrincipalNames.UserPrincipalName.Substring(0, $Symbol)

                $NewUpn = ($Prefix + "@" + $Domain)
                #Region Get Prefix

                #set write-progress incremental variable
                [Int32]$Script:i = [Int32]$Script:i + 1

                Write-Progress -Activity "Updating" -CurrentOperation "Updating UPN" -Status ($UserPrincipalNames.UserPrincipalName + " is Complete:") -PercentComplete ([Int32]$Script:i/[Int32]$Script:Divisor*100);

                Write-Verbose -Message ("I am trying to update " + $UserPrincipalNames.UserPrincipalName + " to " + $NewUpn)

                Start-Sleep -m 1

                try {
                    #Region Set New UserName
                    Set-MsolUserPrincipalName -UserPrincipalName $UserPrincipalNames.UserPrincipalName -NewUserPrincipalName $NewUpn
                    #EndRegion Set New UserName
                }
                catch {
                    Write-Error ";( Error is above"
                    break #break the code
                }
                
            }
            else {

            }
        }

    }
}
#EndRegion Main Function

# #Region Counter
function Measure-Size {
    [CmdletBinding(PositionalBinding = $false)]
    param (
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true)]
        [String]
        $UserPrincipalName
    )

    # begin {

    # }
    
    process {
        #Divisor Count 
        foreach ($UserPrincipalNames in $_.UserPrincipalName) { 
            $Script:Divisor = $Script:Divisor + 1
        }
    }
    
    end {

    }
}
#EndRegion Counter