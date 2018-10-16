//
//  ViewController.swift
//  PickerTest
//
//  Created by Marius Montebaur on 19.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pV: UIPickerView!
    
    struct startEnd {
        let start: Int!
        let end: Int!
    }
    
    let months = ["Jan", "Feb", "Mar", "Apr", "Mai", "Juni", "Juli", "Aug", "Sep", "Okt", "Nov", "Dez"]
    
    let comps = [startEnd(start: 1, end: 31),
                 startEnd(start: 1, end: 12),
                 startEnd(start: 2015, end: 2018),
                 startEnd(start: 0, end: 23)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pV.delegate = self
        pV.dataSource = self
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return comps[component].end - comps[component].start + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let toRetrun = comps[component].start + row
        
        if component == 1 {
            return months[toRetrun-1]
        }
        
        if component == 3 {
            return String(toRetrun) + " Uhr"
        }
        
        return String(toRetrun)
    }

}

