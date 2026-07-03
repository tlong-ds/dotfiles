on preferredDevicePath()
    return "/Users/bunnypro/.preferred_microphone"
end preferredDevicePath

on logMessage(msg)
    try
        do shell script "echo \"$(date '+%Y-%m-%d %H:%M:%S') - " & msg & "\" >> \"/Users/bunnypro/Library/Logs/microphone-protector.log\""
    end try
end logMessage

on getPreferredDevice()
    try
        set dev to (do shell script "cat " & quoted form of preferredDevicePath() & " 2>/dev/null || echo ''")
        if dev is not "" then
            return dev
        end if
    end try
    -- Fallback/initialize if file is empty or doesn't exist
    set currentDev to (do shell script "/Users/bunnypro/bin/audio-manager get")
    do shell script "echo " & quoted form of currentDev & " > " & quoted form of preferredDevicePath()
    return currentDev
end getPreferredDevice

on setPreferredDevice(devName)
    try
        do shell script "echo " & quoted form of devName & " > " & quoted form of preferredDevicePath()
    end try
end setPreferredDevice

on run
    try
        set preferredDevice to getPreferredDevice()
        logMessage("Daemon started. Preferred device locked to: '" & preferredDevice & "'")
        display notification "Locked microphone input to: " & preferredDevice with title "Microphone Protector" subtitle "Monitoring started"
    on error errMsg
        logMessage("Error on startup: " & errMsg)
    end try
end run

on idle
    try
        -- Get the current preferred device from config file
        set preferredDevice to getPreferredDevice()
        
        -- Get the current default input device name
        set currentDevice to (do shell script "/Users/bunnypro/bin/audio-manager get")
        
        -- Check if it has changed
        if currentDevice is not preferredDevice then
            -- Check if System Settings is the frontmost application
            set systemSettingsFrontmost to false
            try
                set frontmostApp to (do shell script "lsappinfo info -only name `lsappinfo front` 2>/dev/null")
                if frontmostApp contains "System Settings" then
                    set systemSettingsFrontmost to true
                end if
            on error
                set systemSettingsFrontmost to false
            end try
            
            if systemSettingsFrontmost then
                -- The user changed it in System Settings, so update preferred device in config file
                logMessage("Preferred device updated via System Settings: '" & preferredDevice & "' -> '" & currentDevice & "'")
                setPreferredDevice(currentDevice)
            else
                -- The change was automatic (e.g. bluetooth connection), revert it back!
                logMessage("Auto-switch detected to '" & currentDevice & "'. Reverting back to: '" & preferredDevice & "'")
                do shell script "/Users/bunnypro/bin/audio-manager set " & quoted form of preferredDevice
                display notification "Prevented auto-switch to '" & currentDevice & "'" with title "Microphone Protector" subtitle "Restored: " & preferredDevice
            end if
        end if
    on error errMsg
        logMessage("Error in idle loop: " & errMsg)
    end try
    
    -- Check every 1.5 seconds
    return 1.5
end idle
