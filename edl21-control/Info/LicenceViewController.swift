//
//  LicenceViewController.swift
//  edl21-control
//
//  Created by Marius Montebaur on 08.11.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class LicenceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem?.title = "Zurück"
        self.navigationItem.backBarButtonItem?.tintColor = UIColor(named: "uiMainColor")
        self.navigationItem.title = "Lizenzen"
    }


}
