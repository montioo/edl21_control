//
//  FlashControl.swift
//  edl21-control
//
//  Created by Marius Montebaur on 15.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit
import AVFoundation


//MARK: - Flash durations

var signalOn: Float = 0.1
var signalOff: Float = 0.1
var signalBreak: Float = 3.1
var signalDelete: Float =  5.5

var job: DispatchWorkItem?

//Ultra billig
var abortBlink : Bool = true


func sleepForSeconds(_ seconds: Float) {
    usleep(UInt32(seconds * 1000000.0))
}


func initFlash (hostVC: UIViewController, durations: [Float]) {
    
    //print(durations)
    
    let placePhoneAlert = UIAlertController(title: "Bereit?",
                                            message: "Halten Sie Ihr iPhone so nah wie möglich vor den EDL21 Zähler, damit das Blitzlicht des iPhones die optische Schnittstelle im Zähler erreicht.",
                                            preferredStyle: .alert)
    
    let ac1 = UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
        _ in
        return
    })
    let ac2 = UIAlertAction(title: "Los geht's!", style: .default, handler: {
        _ in
        abortBlink = false
        executeBlink(hostVC: hostVC, durations: durations)
    })
    
    placePhoneAlert.addAction(ac1)
    placePhoneAlert.addAction(ac2)
    
    hostVC.present(placePhoneAlert, animated: true, completion: nil)
}

func executeBlink (hostVC: UIViewController, durations: [Float]) {
    
    let device: AVCaptureDevice! = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
    
    let placePhoneAlert = UIAlertController(title: "Bitte warten",
                                            message: "Halten Sie Ihr iPhone bitte möglichst ruhig",
                                            preferredStyle: .alert)
    
    let ac1 = UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
        _ in
        abortBlink = true
        device.setTorch(intensity: 0)
        return
    })
    
    placePhoneAlert.addAction(ac1)
    
    hostVC.present(placePhoneAlert, animated: true, completion: nil)
    
    job = DispatchWorkItem {
        
        var on = false
        for dur in durations {
            if (abortBlink) {
                return;
            }
            if on {
                device.setTorch(intensity: 0)
                sleepForSeconds(dur)
            } else {
                device.setTorch(intensity: 1)
                sleepForSeconds(dur)
            }
            on = !on
        }
        device.setTorch(intensity: 0)
        DispatchQueue.main.async {
            placePhoneAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    DispatchQueue.global().async(execute: job!);
}


func turnFlash (on: Bool) {
    let device: AVCaptureDevice! = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
    if on {
        device.setTorch(intensity: 1)
    } else {
        device.setTorch(intensity: 0)
    }
   
}


extension AVCaptureDevice {
    var isLocked: Bool {
        do {
            try lockForConfiguration()
            return true
        } catch {
            print(error)
            return false
        }
    }
    func setTorch(intensity: Float) {
        guard hasTorch && isLocked else { return }
        defer { unlockForConfiguration() }
        if intensity > 0 {
            if torchMode == .off {
                torchMode = .on
            }
            do {
                try setTorchModeOn(level: intensity)
            } catch {
                print(error)
            }
        } else {
            torchMode = .off
        }
    }
}
