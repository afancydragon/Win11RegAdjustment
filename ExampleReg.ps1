<#
EXAMPLE REGEDIT
Ideally just copy/paste this under the last adjustment inside of $Win11RegAdj
#>
AdjustmentName = @{

    #We should comment here to explain what the RegEdits do
    #<- This makes a comment so we can track what the reg edits do
    #Comments off to the side below are not needed, but here for an explanation


    key1 = @{                                            #Key or folder, name of this doesn't matter
                                                         #you can make as many keys as needed under each adjustment.

        Path = "HKLM:\..."                               #This line needs to be PATH, and it should be the path to the reg
                                                         #Path is needed for each key - Reference below for the start of the key

                                                         #HKCR - Classes Root
                                                         #HKCR - Current user
                                                         #HKLM - Local Machine
                                                         #HKU  - Users
                                                         #HKCC - Current Config

        Properties = @{                                  #Needs to stay Properties
                                                         #At least 1 property is needed.

            prop1 = @{                                   #The property name, we can have as many as needed and can be any name like the keys
                                                         #Ideally we name these if we know what the key does.

                Name = "Default"                         #Needs to stay Name

                Type = "REG_SZ"                          #Needs to stay Type and be one of the values below
                                                         #If no values match the script will assume REG_SZ

                Data = ""                                #Needs to stay Data
            }
        }
    }
}