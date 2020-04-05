# Update-Domain

### This is used to perform a bulk update of UserName's Domain on Office 365

---

_**Kindly Note**_

This works together with the ***Get-Msoluser*** CMDLET 

This also works with a CSV file with a column named ***UserPrincipalName*** to bulk update Office 365 User's Domain

---

Download the ***Update-Domain.psm1*** Module

Open PowerShell _(Run As Administrator)_ then run this CMDLET _**$env:PSModulePath**_ to check for directories  

Save it in a Folder named **_Update-Domain_** in either of the directories listed by the output of above CMDLET

**Example of list of directories are below**

* C:\Users\Admin\Documents\PowerShell\Modules

* C:\Program Files\PowerShell\Modules

* c:\program files\powershell\7-preview\Modules

* C:\Program Files\WindowsPowerShell\Modules

* C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules

* c:\Users\Admin\.vscode\extensions\ms-vscode.powershell-2020.3.0\modules

---

**How to run CMDLET**

Open PowerShell _(Run As Administrator)_

First Connect to Office 365 using PowerShell with this CMDLET _**Connect-MsolService**_

For More assitance with connecting to Office 365 vist [LINK](https://docs.microsoft.com/en-us/office365/enterprise/powershell/connect-to-office-365-powershell#connect-with-the-microsoft-azure-active-directory-module-for-windows-powershell)

Run _**Import-Module -Name Update-Domain**_ to import the module 

Then Run this CMDLET to check if the Module has been Imported _**Get-Module -Name Update-Domain**_

After importing the module run the CMDLET below to get help on how to use the **_Update-Domain_** CMDLET

_**Get-Help -Name "Update-Domain" -Full**_

---
**EXAMPLE IS BELOW**

    EXAMPLE
        Get-MsolUser | Update-Domain -Domain "contoso.com"
        Get-MsolUser | Update-Domain -Dn "contoso.com"
        Get-MsolUser | Update-Domain "contoso.com"
        Get-MsolUser | Update-Domain -Domain "contoso.com" -Verbose
        Get-MsolUser | Where-Object{$_.UserPrincipalName -like "*@contoso.onmicrosoft.com*"} | Update-Domain "contoso"
        Get-MsolUser | Where-Object{$_.UserPrincipalName -like "*@contoso.onmicrosoft.com*"} | Update-Domain "contoso" -Verbose
        Get-MsolUser | Where-Object{$_.UserPrincipalName -like "*@contoso.onmicrosoft.com*"} | Update-Domain "contoso" -Verbose -WhatIf
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
    NOTES
        When Using a CSV File, remember to name the column header which has the usernames as *UserPrincipalName*

☺️ for further inquiries reach out to [Ogie](https://www.linkedin.com/in/ibhadogiemu-okougbo-311a5ab3)
