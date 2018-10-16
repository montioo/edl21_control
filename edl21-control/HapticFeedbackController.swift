//
//  HapticFeedbackController.swift
//  edl21-control
//
//  Created by Marius Montebaur on 01.11.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

// Funktionen zur Steuerung des haptischen Feedbacks auf Geräten
// mehrerer Bauarten und Generationen


/*
 
        Funktion nicht fehlerfrei
 
        Deshalb ausschluss aus dieser Testversion
 
 


import UIKit
import AudioToolbox


class HapticFeedbackController {
    
    enum feedbackType {
        case haptic
        case vibration
        case none
    }
    
    private var deviceFeedbackType : feedbackType = .none
    
    private var hapticGenerator : UINotificationFeedbackGenerator? = nil
    
    var isEnabled = false
    
    init(enable: Bool) {
        isEnabled = false
        
        let device = Device()
        
        if (device.isSimulator) {
            return
        }
        /*
        let devWithTapticEngine : [Device] = [.iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus, .iPhoneX]
        
        if devWithTapticEngine.contains(device) {
            deviceFeedbackType = .haptic
            return
        }
        
        if device.isPhone {
            deviceFeedbackType = .vibration
            return
        }
        */
    }
    
    
    func prepare () {
        /*
        if !isEnabled {
            return
        }
        
        switch deviceFeedbackType {
        case .haptic:
            hapticGenerator = UINotificationFeedbackGenerator()
            hapticGenerator?.prepare()
        default:
            print("No haptic feedback of any kind available")
        } */
    }
    
    func trigger () {
        /*
        if !isEnabled {
            return
        }
        switch deviceFeedbackType {
        case .haptic:
            hapticGenerator?.notificationOccurred(.success)
            hapticGenerator = nil
        case .vibration:
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        default:
            return
        } */
    }
    
    
}
*/
