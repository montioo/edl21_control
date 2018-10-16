//
//  OverlayViewController.swift
//  OverlayTest
//
//  Created by Marius Montebaur on 22.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {
    
    
    @IBOutlet weak var iphoneImage: UIImageView!
    @IBOutlet weak var edlBackground: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve

        edlBackground.layer.cornerRadius = 4
        dismissButton.layer.cornerRadius = 4
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let iIStartPoint = CGPoint(x: self.view.frame.width + iphoneImage.frame.width/2, y: self.view.center.y)
        iphoneImage.center = iIStartPoint
        
        let ani = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [.repeat], animations: {
            self.iphoneImage.center = self.view.center
        }, completion: {
            _ in
            
            let ani2 = UIViewPropertyAnimator(duration: 0.4, curve: .linear, animations: {
                self.iphoneImage.alpha = 0
            })
            ani2.addCompletion({
                _ in
                self.iphoneImage.center = iIStartPoint
                self.iphoneImage.alpha = 1
            })
            
            ani2.startAnimation()
        })
        
        ani.startAnimation()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    @IBAction func dismissOverlay(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
