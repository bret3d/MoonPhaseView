//
//  ViewController.swift
//  Moon2
//
//  Created by Bret Dahlgren on 3/30/15.
//  Copyright (c) 2015 Bret Dahlgren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moonPhase: MoonPhaseView!
    
    var phase:CGFloat = 0.0
    
    
    func nextPhase() {
        self.moonPhase.moonPhase = self.phase
        self.moonPhase.setNeedsDisplay()
        
        self.phase = self.phase > 0.994 ? 0.005 : self.phase + 0.005
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.moonPhase.shadowAlpha = 0.4
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "nextPhase", userInfo: nil, repeats: true)
        
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

