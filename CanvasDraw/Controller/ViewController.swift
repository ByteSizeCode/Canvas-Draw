//
//  ViewController.swift
//  Canvas Draw
//
//  Created by Isaac Raval on 5/13/19.
//  Copyright © 2019 Isaac Raval. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Drawing surface
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let drawing = DrawingView(frame: frame)
        view.addSubview(drawing)
        
        //Add color picker
        let colorFrame = CGRect(x: UIScreen.main.bounds.size.width / UIScreen.main.bounds.size.height - 20, y: 0, width: UIScreen.main.bounds.size.width, height: 130)
        let colorPicker = ColorSelection(frame: colorFrame)
        colorPicker.backgroundColor = .gray
        view.addSubview(colorPicker)
        
    }
}

