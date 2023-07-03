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
