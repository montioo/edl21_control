//
//  RootTabBarController.swift
//  edl21-control
//
//  Created by Marius Montebaur on 16.11.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    
    var childViewCons : [String : UITableViewController] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
