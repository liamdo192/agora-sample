import Foundation
import AVFoundation
import MediaPlayer

@objc(GSAudioManager)
class GSAudioManager : NSObject {
  
  @objc enum AudioRoute: Int {
    case speaker
    case headphone
    case bluetooth
  }
  
  @objc func setAudioCategory() {
    let category = AVAudioSession.sharedInstance().category
    let mode = AVAudioSession.sharedInstance().mode
    var isChanged: Bool = false
    if(category != AVAudioSession.Category.playAndRecord){
      isChanged = true;
      try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: [
        .allowBluetoothA2DP, .allowBluetooth])
    }
    
    if(mode != AVAudioSession.Mode.voiceChat){
      isChanged = true;
      try? AVAudioSession.sharedInstance().setMode(AVAudioSession.Mode.voiceChat);
    }
   
    if(isChanged){
      try? AVAudioSession.sharedInstance().setActive(true)
    }
  }
  
  
  
  func disableNowPlayingControls() {
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
  }
  
  @objc func getAudioRouteAvailable(){
    let audioSession = AVAudioSession.sharedInstance()
    let availableInputs = audioSession.availableInputs
    let currentRoute = audioSession.currentRoute
        // List all output ports
        if currentRoute.outputs.isEmpty {
            print("No outputs found.")
        } else {
            for output in currentRoute.outputs {
                print("Output: \(output.portName) - \(output.portType.rawValue)")
            }
        }
  }
  
  @objc func setAudioRoute(_ route: AudioRoute){
    print("Select \(route)")
    let audioSession = AVAudioSession.sharedInstance()
    
    switch route {
    case .speaker:
      try? audioSession.overrideOutputAudioPort(.speaker)
    case .headphone:
      try? audioSession.overrideOutputAudioPort(.none)
    case .bluetooth:
      if let availableInputs = audioSession.availableInputs {
        print("=================== \(availableInputs)")
          for input in availableInputs {
              if input.portType == .bluetoothA2DP ||
                 input.portType == .bluetoothLE ||
                 input.portType == .bluetoothHFP {
                  
                  // Set the preferred input to the Bluetooth device
                  try? audioSession.overrideOutputAudioPort(.none)
                  try? audioSession.setPreferredInput(input)
                  break
              }
          }
      }
    }
    
    try? AVAudioSession.sharedInstance().setActive(true)
  }
  
  func getCurrentAudioRoute() {
      let session = AVAudioSession.sharedInstance()
      // Get the current audio route
      let currentRoute = session.currentRoute
      
      if currentRoute.outputs.isEmpty {
          print("No audio output available")
      } else {
          // Iterate through the outputs
          for output in currentRoute.outputs {
              print("Output port type: \(output.portType.rawValue)")
              
              switch output.portType {
              case .builtInSpeaker:
                  print("Audio is playing through the built-in speaker.")
              case .headphones:
                  print("Audio is playing through headphones.")
              case .bluetoothA2DP, .bluetoothLE, .bluetoothHFP:
                  print("Audio is playing through Bluetooth.")
              case .airPlay:
                  print("Audio is playing via AirPlay.")
              default:
                  print("Audio is playing through another route: \(output.portType.rawValue)")
              }
          }
      }
  }
  
  @objc func getAudioCategory() -> String {
    let category = AVAudioSession.sharedInstance().category.rawValue

    let mode = AVAudioSession.sharedInstance().mode.rawValue
    
    print("=================== \(category) - \(mode)")
    return category
  }
  
  @objc func deactiveAudioSession(){
    try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
  }
  
}

