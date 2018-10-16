//
//  ViewController.swift
//  OverlayTest
//
//  Created by Marius Montebaur on 22.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showOverlay(_ sender: UIButton) {
        performSegue(withIdentifier: "overlaySegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let darkView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        darkView.backgroundColor = UIColor.black
        darkView.alpha = 0
        darkView.tag = 51
        self.view.addSubview(darkView)
        
        let ani = UIViewPropertyAnimator.init(duration: 0.3, curve: .linear, animations: {
            darkView.alpha = 0.6
        })
        
        ani.startAnimation()
        
        let target = segue.destination
        target.modalPresentationStyle = .custom
    }
    
    
    func hideOverlay () {
        let darkView = self.view.viewWithTag(51)
        
        let ani = UIViewPropertyAnimator.init(duration: 0.4, curve: .linear, animations: {
            darkView?.alpha = 0
        })
        
        ani.addCompletion({
            _ in
            darkView?.removeFromSuperview()
        })
        
        ani.startAnimation()
 
    }
    
}

