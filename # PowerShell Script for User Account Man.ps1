# PowerShell Script for User Account Management

# Function to create a new user account
function Create-User {
    param (
        [string]$Username,
        [string]$Password,
        [string]$FullName,
        [string]$Description
    )
    New-LocalUser -Name $Username -Password (ConvertTo-SecureString $Password -AsPlainText -Force) -FullName $FullName -Description $Description
    Add-LocalGroupMember -Group "Users" -Member $Username
    Write-Output "User $Username created successfully."
}

# Function to modify an existing user account
function Modify-User {
    param (
        [string]$Username,
        [string]$NewFullName,
        [string]$NewDescription
    )
    $user = Get-LocalUser -Name $Username
    if ($user) {
        Set-LocalUser -Name $Username -FullName $NewFullName -Description $NewDescription
        Write-Output "User $Username modified successfully."
    } else {
        Write-Output "User $Username not found."
    }
}

# Function to disable a user account
function Disable-User {
    param (
        [string]$Username
    )
    $user = Get-LocalUser -Name $Username
    if ($user) {
        Disable-LocalUser -Name $Username
        Write-Output "User $Username disabled successfully."
    } else {
        Write-Output "User $Username not found."
    }
}

# Main script logic
$action = Read-Host "Enter action (Create, Modify, Disable)"
switch ($action) {
    "Create" {
        $username = Read-Host "Enter username"
        $password = Read-Host "Enter password"
        $fullname = Read-Host "Enter full name"
        $description = Read-Host "Enter description"
        Create-User -Username $username -Password $password -FullName $fullname -Description $description
    }
    "Modify" {
        $username = Read-Host "Enter username"
        $newFullName = Read-Host "Enter new full name"
        $newDescription = Read-Host "Enter new description"
        Modify-User -Username $username -NewFullName $newFullName -NewDescription $newDescription
    }
    "Disable" {
        $username = Read-Host "Enter username"
        Disable-User -Username $username
    }
    default {
        Write-Output "Invalid action. Please enter Create, Modify, or Disable."
    }
}

