//
//  ViewController.swift
//  CountdownAnimationDemo
//
//  Created by Marius Montebaur on 21.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var stp_duration: Double = 2
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centerView.layer.cornerRadius = 20
    }

    @IBAction func timeStepper(_ sender: UIStepper) {
        stp_duration = Double(sender.value)/10.0
        timeLbl.text = String(describing: stp_duration) + " sek"
    }
    
    
    @IBAction func startAnimation(_ sender: UIButton) {
        //let p = centerView.convert(centerView.center, to: self.view)
        let p = centerView.superview?.convert(centerView.center, to: self.view)
        startTimerAnimation(duration: stp_duration, startPoint: p!, circleRadius: centerView.bounds.width/2, barsAmount: 16, barSize: CGSize(width: 3, height: 15), barColor: UIColor.red, belowView: centerView, completion: { print("done") })
    }
    
    //Erzeugt eine Animation die dem Nutzer zeigt, dass im Hintergrund etwas passiert
    private func startTimerAnimation (duration: Double, startPoint: CGPoint, circleRadius: CGFloat,
                                      barsAmount: Int, barSize: CGSize, barColor: UIColor, belowView: UIView,
                                      completion: @escaping () -> ()) {
        print(startPoint)
        let ani1_radius: CGFloat = circleRadius+barSize.height
        let ani2_radius: CGFloat = circleRadius+barSize.height*1.5
        
        let time = duration
        
        let ani1_time = 0.3 //0.5
        let ani2_time = 0.1 //0.2
        let ani3_time = 0.15 //0.3
 
        let startTime = NSDate.timeIntervalSinceReferenceDate
        print(startTime)
        
    
        for i in 0..<barsAmount {
            let v = UIView(frame: CGRect(x: startPoint.x, y: startPoint.y, width: barSize.width, height: barSize.height))
            v.center = startPoint
            v.backgroundColor = UIColor.red
            let angle_deg = (360/CGFloat(barsAmount))*CGFloat(i+1)
            let angle_rad = angle_deg * CGFloat((2*Double.pi)/360)
            print(angle_deg)
            v.transform = CGAffineTransform(rotationAngle: angle_rad)
            
            //self.view.insertSubview(v, belowSubview: belowView)
            self.view.addSubview(v)
            let ani1 = UIViewPropertyAnimator(duration: ani1_time, curve: .easeOut, animations: {
                v.center = self.posAroundCircle(centerPoint: startPoint, angle_rad: angle_rad, radius: ani1_radius)
            })
            
            let ani2 = UIViewPropertyAnimator(duration: ani2_time, curve: .easeInOut, animations: {
                v.center = self.posAroundCircle(centerPoint: startPoint, angle_rad: angle_rad, radius: ani2_radius)
            })
            ani2.addCompletion({
                _ in
                let ani3 = UIViewPropertyAnimator(duration: ani3_time, curve: .easeIn, animations: {
                    v.center = startPoint
                })
                ani3.addCompletion({
                    _ in
                    if i == barsAmount-1 {
                        let endTime = NSDate.timeIntervalSinceReferenceDate
                        print(endTime)
                        print(endTime-startTime)
                        completion()
                    }
                    v.removeFromSuperview()
                })
                ani3.startAnimation()
            })
            let delay = (Double(i)/Double(barsAmount-1))*(time-ani1_time) - (ani2_time+ani3_time) + ani1_time
            print("delay: " + String(delay))
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
    
}

