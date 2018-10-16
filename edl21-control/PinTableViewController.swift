//
//  PinTableViewController.swift
//  edl21-control
//
//  Created by Marius Montebaur on 20.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit
import AVFoundation

class PinTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    //MARK: - Properties
    
    var pinTextFields : [UITextField] = []
    
    @IBOutlet weak var savePinSwitch: UISwitch!
    @IBOutlet weak var pin1: UITextField!
    @IBOutlet weak var pin2: UITextField!
    @IBOutlet weak var pin3: UITextField!
    @IBOutlet weak var pin4: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinTextFields = [pin1, pin2, pin3, pin4]
        for field in pinTextFields {
            field.delegate = self
        }
        
        loadPin()
       
        
        guard let tabBarCon = self.navigationController?.tabBarController else {
            return
        }
        guard let rootBarCon = tabBarCon as? RootTabBarController else {
            return
        }
        rootBarCon.childViewCons["pinVC"] = self as UITableViewController
    }
    
    
    //MARK: - Actions
    
    @IBAction func unlock_powermeter(_ sender: UIButton) {
    
        var pin : [Int] = []
        for i in 0..<4 {
            guard let digit = Int(pinTextFields[i].text!) else {
                let alertKorrektePin = UIAlertController(title: "Falsche Pin", message: "Bitte geben Sie eine korrekte Pin ein", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertKorrektePin.addAction(okButton)
                self.present(alertKorrektePin, animated: true, completion: nil)
                
                return
            }
            pin.append(digit)
        }
        
        
        if savePinSwitch.isOn {
            saveOption(key: "pin", value: pin as AnyObject)
        }
        
        var durations: [Float] = [0.5,0.5,0.5,0.5]
        
        for (index, amount) in pin.enumerated() {
            for flash in 0..<amount {
                durations += [signalOn]
                
                if flash < amount-1 {
                    durations += [signalOff]
                }
            }
            if index < 3 && amount != 0 {
                var zerosToCome = 0
                for i in index+1..<pin.count {
                    if pin[i] == 0 {
                        zerosToCome += 1
                    } else {
                        break
                    }
                }
                durations += [signalBreak*Float(zerosToCome+1)]
            }
            
        }
        
        //durations.removeLast()
        
        var gesDur: Float = 0
        for e in durations {
            gesDur += e
        }
        //print(gesDur)
        
        initFlash(hostVC: self as UIViewController, durations: durations)
        
        
    }
    
    @IBAction func lock_powermeter(_ sender: UIButton) {
        let durations: [Float] = [signalOn, signalOff, signalOn, signalOff, signalOn, signalOff, signalOn, signalOff, signalOn, signalOff, signalOn, signalOff, signalOn, signalOff, signalOn, signalOff, signalDelete]
        initFlash(hostVC: self as UIViewController, durations: durations)
        
    }
    
    @IBAction func saveSwitch(_ sender: UISwitch) {
        if !sender.isOn {
            removeObject(key: "pin")
        }
    }
    
    
    //MARK: - Textfield Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let _ = Int(string) else {
            return false
        }
        
        
        for (index, field) in pinTextFields.enumerated() {
            if field === textField {
                
                if index == 3 {
                    //Letztes Feld
                    pinTextFields[3].text = string
                    pinTextFields[3].resignFirstResponder()
                    return false
                }
                
                if index < 3 {
                    //Eines der vorderen Felder
                    pinTextFields[index].text = string
                    pinTextFields[index].resignFirstResponder()
                    pinTextFields[index+1].becomeFirstResponder()
                    pinTextFields[index+1].text = ""
                    return false
                }
            }
        }
        
        return true
    }
    
    
    //MARK: - Private Functions
    
    private func loadPin () {
        guard let pin = loadOption(key: "pin") as? [Int] else {
            savePinSwitch.isOn = false
            return
        }
        for (index, field) in pinTextFields.enumerated() {
            field.text = String(pin[index])
        }
    }
    
    private func getPinEntryTime (pin: [Int]) -> Float {
        let initTime = 2*signalOn + signalOff + signalBreak
        var pinTime : Float = 0
        
        for amount in pin {
            pinTime += Float(amount) * (signalOn + signalOff)
            pinTime -= signalOff
            pinTime += signalBreak
        }
        pinTime -= signalBreak
        
        return initTime+pinTime
    }
    
    
}


