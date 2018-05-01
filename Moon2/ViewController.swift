//
//  ViewController.swift
//  MoonPhase
//
//  Created by Bret Dahlgren on 3/25/15.
//  Copyright (c) 2015 Bret Dahlgren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var moonPhase: MoonPhaseView!
    
    var timer: Timer?
    var moonPhaseValue: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.moonPhase.shadowAlpha = 0.4

        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(moonPhaseUpdate), userInfo: nil, repeats: true)
    }

    @objc func moonPhaseUpdate() {
        self.moonPhase.moonPhase = self.moonPhaseValue
        self.moonPhase.setNeedsDisplay()
        self.moonPhaseValue = self.moonPhaseValue + 0.001 > 1.0 ? 0.0 : self.moonPhaseValue + 0.001
    }

}

