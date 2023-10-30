# Win11RegAdjustment
Contact:  
- Just add an issue if you would like this tinkered with at all or adjusted slightly for your use case  

Requirements:  
- Powershell/Admin   

Does the following:  
- Add keys and subkeys based on the path.       


This currently forcibly adds keys meaning it will overwrite everything if the keys already exist.  
Make sure to add all properties under each key.  

## EXAMPLE KEY
AdjustmentName = @{  
    #We should have a comment here to explain what the edits do  
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
                                                         #Somehow if values don't match and you run into problems, let me know  
                                                         #There are several more Reg Types I don't account for, but they are very uncommon  
  
                  
                Data = ""                                #Needs to stay Data  
            }  
        }  
    }  
}   