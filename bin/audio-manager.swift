import CoreAudio
import Foundation

// Helper to get device name
func getDeviceName(deviceID: AudioDeviceID) -> String? {
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyDeviceNameCFString,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    
    var name: Unmanaged<CFString>? = nil
    var propertySize = UInt32(MemoryLayout<Unmanaged<CFString>?>.size)
    
    let status = AudioObjectGetPropertyData(
        deviceID,
        &address,
        0,
        nil,
        &propertySize,
        &name
    )
    
    if status == noErr, let unmanagedName = name {
        return unmanagedName.takeRetainedValue() as String
    }
    return nil
}

// Helper to check if a device is an input device (microphone)
func isInputDevice(deviceID: AudioDeviceID) -> Bool {
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioDevicePropertyStreamConfiguration,
        mScope: kAudioObjectPropertyScopeInput,
        mElement: kAudioObjectPropertyElementMain
    )
    
    var propertySize: UInt32 = 0
    var status = AudioObjectGetPropertyDataSize(deviceID, &address, 0, nil, &propertySize)
    
    guard status == noErr else { return false }
    
    let bufferListPointer = UnsafeMutablePointer<AudioBufferList>.allocate(capacity: Int(propertySize))
    defer { bufferListPointer.deallocate() }
    
    status = AudioObjectGetPropertyData(deviceID, &address, 0, nil, &propertySize, bufferListPointer)
    
    guard status == noErr else { return false }
    
    let buffers = UnsafeMutableAudioBufferListPointer(bufferListPointer)
    var totalChannels = 0
    for buffer in buffers {
        totalChannels += Int(buffer.mNumberChannels)
    }
    
    return totalChannels > 0
}

// Get all device IDs
func getAllDevices() -> [AudioDeviceID] {
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDevices,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    
    var propertySize: UInt32 = 0
    var status = AudioObjectGetPropertyDataSize(
        AudioObjectID(kAudioObjectSystemObject),
        &address,
        0,
        nil,
        &propertySize
    )
    
    guard status == noErr else { return [] }
    
    let deviceCount = Int(propertySize) / MemoryLayout<AudioDeviceID>.size
    var deviceIDs = [AudioDeviceID](repeating: 0, count: deviceCount)
    
    status = AudioObjectGetPropertyData(
        AudioObjectID(kAudioObjectSystemObject),
        &address,
        0,
        nil,
        &propertySize,
        &deviceIDs
    )
    
    return status == noErr ? deviceIDs : []
}

// Get default input device ID
func getDefaultInputDeviceID() -> AudioDeviceID? {
    var deviceID = AudioDeviceID(0)
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDefaultInputDevice,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    
    var propertySize = UInt32(MemoryLayout<AudioDeviceID>.size)
    let status = AudioObjectGetPropertyData(
        AudioObjectID(kAudioObjectSystemObject),
        &address,
        0,
        nil,
        &propertySize,
        &deviceID
    )
    
    return status == noErr ? deviceID : nil
}

// Set default input device ID
func setDefaultInputDeviceID(deviceID: AudioDeviceID) -> Bool {
    var devID = deviceID
    var address = AudioObjectPropertyAddress(
        mSelector: kAudioHardwarePropertyDefaultInputDevice,
        mScope: kAudioObjectPropertyScopeGlobal,
        mElement: kAudioObjectPropertyElementMain
    )
    
    let status = AudioObjectSetPropertyData(
        AudioObjectID(kAudioObjectSystemObject),
        &address,
        0,
        nil,
        UInt32(MemoryLayout<AudioDeviceID>.size),
        &devID
    )
    
    return status == noErr
}

// Main logic
let arguments = CommandLine.arguments

guard arguments.count > 1 else {
    print("Usage:")
    print("  audio-manager get          - Get the name of the current default input device")
    print("  audio-manager list         - List all available input devices")
    print("  audio-manager set <name>   - Set the default input device by name")
    exit(1)
}

let command = arguments[1]

switch command {
case "get":
    if let currentID = getDefaultInputDeviceID(), let name = getDeviceName(deviceID: currentID) {
        print(name)
    } else {
        print("Error: Could not retrieve current default input device.")
        exit(1)
    }

case "list":
    let devices = getAllDevices()
    for device in devices {
        if isInputDevice(deviceID: device), let name = getDeviceName(deviceID: device) {
            print(name)
        }
    }

case "set":
    guard arguments.count > 2 else {
        print("Error: Please specify the device name to set.")
        exit(1)
    }
    let targetName = arguments[2...].joined(separator: " ")
    let devices = getAllDevices()
    var foundDeviceID: AudioDeviceID? = nil
    
    for device in devices {
        if isInputDevice(deviceID: device), let name = getDeviceName(deviceID: device) {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == targetName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                foundDeviceID = device
                break
            }
        }
    }
    
    if let deviceID = foundDeviceID {
        if setDefaultInputDeviceID(deviceID: deviceID) {
            print("Successfully set input device to: \(targetName)")
        } else {
            print("Error: Failed to set input device.")
            exit(1)
        }
    } else {
        print("Error: Audio input device '\(targetName)' not found.")
        print("Available input devices:")
        for device in devices {
            if isInputDevice(deviceID: device), let name = getDeviceName(deviceID: device) {
                print("  - \(name)")
            }
        }
        exit(1)
    }

default:
    print("Unknown command: \(command)")
    exit(1)
}
