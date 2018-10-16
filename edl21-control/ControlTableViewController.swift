//
//  ZusatzfunktionViewController.swift
//  edl21-control
//
//  Created by Marius Montebaur on 15.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class ControlTableViewController: UITableViewController {
    
    //MARK: - Properties
    @IBOutlet weak var aktionBtn: UIButton!
    @IBOutlet weak var weiterBtn: UIButton!
    
    var animationInProgress = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        guard let tabBarCon = self.navigationController?.tabBarController else {
            return
        }
        guard let rootBarCon = tabBarCon as? RootTabBarController else {
            return
        }
        rootBarCon.childViewCons["controlVC"] = self as UITableViewController
    }

    
    
    //MARK: - Actions
    @IBAction func controlAktion(_ sender: UIButton) {
        if animationInProgress { return }
        setBtn(enabled: false)
        
        startTimerAnimation(duration: 5.2, startPoint: sender.center, circleRadius: sender.frame.width/2,
                            barsAmount: 20, barSize: CGSize(width: 2, height: 10), barColor: UIColor(named: "uiMainColor")!,
                            belowView: sender as UIView,
                            completion: { self.setBtn(enabled: true)})
    }
    
    @IBAction func controlWeiter(_ sender: UIButton) {
        if animationInProgress { return }
        setBtn(enabled: false)
        startTimerAnimation(duration: 0, startPoint: sender.center, circleRadius: sender.frame.width/2,
                            barsAmount: 20, barSize: CGSize(width: 2, height: 10), barColor: UIColor(named: "uiMainColor")!,
                            belowView: sender as UIView, completion: { return })
        
        let job = DispatchWorkItem {
            sleepForSeconds(0.3)
            self.setBtn(enabled: true)
        }
        
        DispatchQueue.global(qos: .userInitiated).async(execute: job)
    }
    

    //MARK: - Animations
    //Erzeugt eine Animation die dem Nutzer zeigt, dass im Hintergrund etwas passiert
    private func startTimerAnimation (duration: Double, startPoint: CGPoint, circleRadius: CGFloat, barsAmount: Int, barSize: CGSize, barColor: UIColor, belowView: UIView, completion: @escaping () -> ()) {
        
        let ani1_radius: CGFloat = circleRadius+barSize.height
        let ani2_radius: CGFloat = circleRadius+barSize.height*1.5
        
        //let time = duration
        
        let ani1_time = 0.2 //0.5 / Erscheinen
        let ani2_time = 0.1 //0.2 / Raus
        let ani3_time = 0.1 //0.3 / Rein
        
        //let startTime = NSDate.timeIntervalSinceReferenceDate
        //print(startTime)
        
        
        for i in 0..<barsAmount {
            let v = UIView(frame: CGRect(x: startPoint.x, y: startPoint.y, width: barSize.width, height: barSize.height))
            v.backgroundColor = barColor
            let angle_deg = (360/CGFloat(barsAmount))*CGFloat(i+1)
            let angle_rad = angle_deg * CGFloat((2*Double.pi)/360)
            //print(angle_deg)
            let barStartPoint = posAroundCircle(centerPoint: startPoint, angle_rad: angle_rad, radius: (circleRadius*0.8)-(barSize.width/2))
            v.center = barStartPoint
            v.transform = CGAffineTransform(rotationAngle: angle_rad)
            
            belowView.superview?.insertSubview(v, belowSubview: belowView)
            
            let ani1 = UIViewPropertyAnimator(duration: ani1_time, curve: .easeOut, animations: {
                v.center = self.posAroundCircle(centerPoint: startPoint, angle_rad: angle_rad, radius: ani1_radius)
            })
            
            let ani2 = UIViewPropertyAnimator(duration: ani2_time, curve: .easeInOut, animations: {
                v.center = self.posAroundCircle(centerPoint: startPoint, angle_rad: angle_rad, radius: ani2_radius)
            })
            ani2.addCompletion({
                _ in
                let ani3 = UIViewPropertyAnimator(duration: ani3_time, curve: .easeIn, animations: {
                    v.center = barStartPoint
                })
                ani3.addCompletion({
                    _ in
                    if i == barsAmount-1 {
                        //let endTime = NSDate.timeIntervalSinceReferenceDate
                        //print(endTime)
                        //print(endTime-startTime)
                        completion()
                    }
                    v.removeFromSuperview()
                })
                ani3.startAnimation()
            })
            var delay : Double = 0
            if duration > 0 {
                delay = (Double(i)/Double(barsAmount-1))*(duration-ani1_time) - (ani2_time+ani3_time) + ani1_time
            }
            //print("delay: " + String(delay))
            ani1.startAnimation()
            ani2.startAnimation(afterDelay: max(0, delay))
            
            
            /*
             Animation: (pro Balken)
             1. Nach außen bewegen, also sichtbar werden
             2. Weiter nach außen kommen, wenn Zeit gekommen
             3. nach innen verschwinden
             */
        }
        
    }
    
    //Gibt absolute Koordinate eines Punktes zurück, der in der Entfernung radius und dem Winkel angle_rad zu den Startkoordinaten steht
    private func posAroundCircle(centerPoint: CGPoint, angle_rad: CGFloat, radius: CGFloat) -> CGPoint {
        //Trigonometrie rockt
        let x_offset = sin(angle_rad)*radius
        let y_offset = -cos(angle_rad)*radius
        
        return CGPoint(x: centerPoint.x + x_offset, y: centerPoint.y + y_offset)
    }
    
    
    //MARK: - Private Functions
    private func setBtn(enabled: Bool) {
        turnFlash(on: !enabled)
        animationInProgress = !enabled
    }
    
    
    // MARK: - Navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationController?.navigationBar.tintColor = UIColor(named: "uiMainColor")
    }
     */
}
