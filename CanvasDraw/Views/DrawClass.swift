//
//  DrawClass.swift
//  Canvas Draw
//
//  Created by Isaac Raval on 5/13/19.
//  Copyright © 2019 Isaac Raval. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    // Create a path to connect lines
    let path = UIBezierPath()
    
    var previousPoint:CGPoint
    var lineWidth:CGFloat = 5.0
    
    override init(frame: CGRect) {
        //Reset value of previous point
        previousPoint = CGPoint.zero
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.backgroundColor = .white
        
        //Add pan gesture recognizer
        var recognizer = UIPanGestureRecognizer(target: self, action:  #selector(pan))
        recognizer.maximumNumberOfTouches=1
        self.addGestureRecognizer(recognizer)
    }
    
    required init(coder aDecoder: NSCoder) {
        //Reset value of previous point
        previousPoint = CGPoint.zero
        super.init(coder: aDecoder)!
        self.backgroundColor = .white
        
        // Capture touches
        let panGestureRecognizer=UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.cancelsTouchesInView = false
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        //Retrieve current color
        let defaults = UserDefaults.standard
        let colorStr = UserDefaults.standard.string(forKey: "key") ?? ""
        let color:UIColor = convStrColorToUIColor(withStrColor: colorStr)
        
        //Color the line
        color.setStroke()
        
        path.stroke()
        path.lineWidth = lineWidth
    }
    
    // Capture the pan events into a bezier path by connecting the points with lines
    @objc func pan(panGestureRecognizer:UIPanGestureRecognizer) -> Void {
        //Get currenty location of finger
        let currentPoint = panGestureRecognizer.location(in: self)
        //Get midpoint of last point and current point
        let midPoint = self.midPoint(p0: previousPoint, p1: currentPoint)
        
        //Move path appropriatly
        if panGestureRecognizer.state == .began {
            path.move(to: currentPoint)
        }
        else if panGestureRecognizer.state == .changed {
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        //Save previous point of touch for refrence
        previousPoint = currentPoint
        self.setNeedsDisplay()
    }
    
    //Get midpoint of any given set of points
    func midPoint(p0:CGPoint, p1:CGPoint) -> CGPoint {
        let x = (p0.x + p1.x)/2
        let y = (p0.y + p1.y)/2
        return CGPoint(x: x, y: y)
    }
}

extension DrawingView {
    func convStrColorToUIColor(withStrColor strColor:String) -> UIColor {
        if(strColor == "red") {
            return UIColor.red
        }
        else if(strColor == "blue") {
            return UIColor.blue
        }
        else if(strColor == "purple") {
            return UIColor.purple
        }
        else if(strColor == "black") {
            return UIColor.black
        }
        
        let defaultColor = UIColor.green
        return defaultColor
        
    }
}
