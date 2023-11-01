#Creating bulk users from a .csv to the "Email Only" OU



$ADUsers = Import-csv -Path "c:\users.csv"

foreach ($User in $ADUsers) {

    $Username    = $User.username
    $Password    = $User.password
    $Firstname   = $User.firstname
    $Lastname    = $User.lastname
    $Department  = $User.department
    $OU          = $User.ou

    New-ADUser `
        -SamAccountName $Username `
        -UserPrincipalName "$Username@kavousi.com" `
        -Name "$Firstname $Lastname" `
        -GivenName $Firstname `
        -Surname $Lastname `
        -Enabled $True `
        -ChangePasswordAtLogon $False `
        -DisplayName "$Lastname, $Firstname" `
        -Department $Department `
        -Path $OU `
        -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
}