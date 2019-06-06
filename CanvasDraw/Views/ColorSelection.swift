//
//  ColorSelection.swift
//  Canvas Draw
//
//  Created by Isaac Raval on 5/13/19.
//  Copyright © 2019 Isaac Raval. All rights reserved.
//

import UIKit

class ColorSelection: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let center = UIScreen.main.bounds.size.width / (UIScreen.main.bounds.size.height / 2) + 180
        
        //Create circles
        createCircle(positionedAt: CGPoint(x: center + 100,y: 70), usingColor: UIColor.red, withName: "red")
        createCircle(positionedAt: CGPoint(x: center + 160,y: 70), usingColor: UIColor.blue, withName: "blue")
        createCircle(positionedAt: CGPoint(x: center + 220,y: 70), usingColor: UIColor.purple, withName: "purple")
        createCircle(positionedAt: CGPoint(x: center + 280,y: 70), usingColor: UIColor.black, withName: "black")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ColorSelection {
    //Create circle
    func createCircle(positionedAt position: CGPoint, usingColor colorToUse: UIColor, withName name: String) {
        let circlePath = UIBezierPath(arcCenter: position, radius: CGFloat(20), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = colorToUse.cgColor
        shapeLayer.strokeColor = colorToUse.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.name = name
        shapeLayer.opacity = 0.2
        shapeLayer.contents = name
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension ColorSelection {
    //Detect any taps on color-circles
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        guard let point = touch?.location(in: self) else { return }
        guard let sublayers = self.layer.sublayers as? [CAShapeLayer] else { return }
        
        for layer in sublayers{
            if let path = layer.path, path.contains(point) {
                
                //Gray-out all color-circles
                sublayers.forEach {
                    $0.opacity = 0.2
                }
                //Animate tapped color-circle to be highlighted
                UIView.animate(withDuration: 2.0) {
                    layer.opacity = 1
                }
                
                //Save the color the user tapped on
                let defaults = UserDefaults.standard
                let saveColor = layer.contents as? String
                //Color the user tapped on
                defaults.set(saveColor, forKey: "key")
                
            }
        }
    }
}




