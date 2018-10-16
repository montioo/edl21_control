//
//  InfoTableViewController.swift
//  
//
//  Created by Marius Montebaur on 09.11.17.
//

import UIKit


class InfoTableViewController: UITableViewController {

    @IBOutlet weak var feedbackTypeLbl: UILabel!
    @IBOutlet weak var enableFeedbackSwitchOutlet: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath)
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        if cell.tag == 41 {
            
            let actionController = UIAlertController(title: "Pin löschen?", message: "Das Löschen Ihrer gespeicherten Pin kann nicht rückgängig gemacht werden.", preferredStyle: .alert)
            
            let cancel_action = UIAlertAction(title: "Abbrechen", style: .cancel, handler: {
                _ in
                tableView.deselectRow(at: indexPath, animated: false)
            })
            
            let delete_action = UIAlertAction(title: "Löschen", style: .destructive, handler: {
                _ in
                
                tableView.deselectRow(at: indexPath, animated: false)
                removeObject(key: "pin")
                
                self.resetDisplayedPin()
            })
            
            actionController.addAction(delete_action)
            actionController.addAction(cancel_action)
            
            self.present(actionController, animated: true, completion: nil)
            
        }
    }

    
    func resetDisplayedPin () {
        
        guard let tabBarCon = self.navigationController?.tabBarController else {
            return
        }
        guard let rootBarCon = tabBarCon as? RootTabBarController else {
            return
        }
        guard let pinVC = rootBarCon.childViewCons["pinVC"] as? PinTableViewController else {
            return
        }
        pinVC.pin1.text = ""
        pinVC.pin2.text = ""
        pinVC.pin3.text = ""
        pinVC.pin4.text = ""
        
    }
    
}

