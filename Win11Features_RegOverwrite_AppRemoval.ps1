$Win11AppList = (
    "MicrosoftWindows.Client.WebExperience", #Widgets
    "LenovoCompanion", #Lenovo Bloat
    "MicrosoftTeams" #Microsoft Teams
)

$Win11RegAdj = @{
    #This adds the Context Menu from 10 back to Win11 after a Reboot
    ContextMenu = @{
        key1 = @{
            Path = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
            Properties = @{
                Default = @{
                    Name = "(Default)"
                    Type = "REG_SZ"
                    Data = ""  
                }
                ITNote = @{
                    Name = "NOTE"
                    Type = "REG_SZ"
                    DATA = "Added by Win11Features_RegOverwrite"
                }
            }
        }
        key2 = @{      
            Path = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
            Properties = @{
                Default = @{
                    Name = "(Default)"
                    Type = "REG_SZ"
                    Data = ""             
                }
                ITNote = @{
                    Name = "NOTE"
                    Type = "REG_SZ"
                    DATA = "Added by Win11Features_RegOverwrite"
                }
            }
        }
    }
    #Enables Local Secuity Authority
    LSAEnable = @{
        key1 = @{
            Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
            Properties = @{
                RunAsPPL = @{
                    Name = "RunAsPPL"
                    Type = "REG_DWORD"
                    Data = "2"
                }
                RunAsPPLBoot = @{
                    Name = "RunAsPPLBoot"
                    Type = "REG_DWORD"
                    Data = "2"
                }
            }
        }
    }
    #Remove the TeamsChat Icon at the bottom of Win11, prevent reinstallation of teams
    TeamsChatOFF = @{
        key1 = @{
            Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications"
            Properties = @{
                ConfigureChatAutoInstall = @{
                    Name = "ConfigureChatAutoInstall"
                    Type = "REG_DWORD"
                    Data = "0"
                }
            }
        }
        key2 = @{
            Path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Chat"
            Properties = @{
                ChatIcon  = @{
                    Name = "ChatIcon"
                    Type = "REG_DWORD"
                    Data = "3"
                }
            }
        }
    }
    #Left Alignment Windows 11
    LeftAlign11 = @{
        key1 = @{
            Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
            Properties = @{
                TaskbarAl = @{
                    Name = "TaskbarAl"
                    Type = "REG_DWORD"
                    Data = "0" #1 is center
                }
            }
        }
    }
    #Core Isolation Enable
    CoreIsolation = @{
        key1 = @{
            Path = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios"
            Properties = @{
                HypervisorEnforcedCodeIntegrity = @{
                    Name = "HypervisorEnforcedCodeIntegrity"
                    Type = "REG_DWORD"
                    Date = "1"
                }
            }
        }
    }
}

ForEach($adjust in $Win11RegAdj.Keys){
    ForEach($key in $Win11RegAdj.$adjust.Keys){
        $Exist = (Test-Path -Path $Win11RegAdj.$adjust.$key.Path)
        If($Exist -eq $FALSE){
            New-Item -Path $Win11RegAdj.$adjust.$key.Path
        }
        ForEach($property in $Win11RegAdj.$adjust.$key.Properties.Keys){
            $Type = ""
            Switch($Win11RegAdj.$adjust.$key.Properties.$property.Type){
                "REG_NONE"       {$Type = "None"}
                "REG_SZ"         {$Type = "String"}
                "REG_EXPAND_SZ"  {$Type = "ExpandString"}
                "REG_Binary"     {$Type = "Binary"}
                "REG_DWORD"      {$Type = "Dword"}
                "REG_MULTI_SZ"   {$Type = "MultiString"}
                "REG_QWORD"      {$Type = "Qword"}
                "Unknown"        {$Type = "Unknown"}
                default{$Type = "String"}
            }
            New-ItemProperty `
            -Path $Win11RegAdj.$adjust.$key.Path `
            -Name $Win11RegAdj.$adjust.$key.Properties.$property.Name `
            -PropertyType $Type `
            -Value $Win11RegAdj.$adjust.$key.Properties.$property.Data `
            -Force
        }
    }
}

ForEach($app in $Win11AppList){
    Get-AppxPackage -AllUsers -Name "*$app*" | Remove-AppxPackage -AllUsers
}