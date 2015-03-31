//
//  MoonPhaseView.swift
//  MoonPhase
//
//  Created by Bret Dahlgren on 3/25/15.
//  Copyright (c) 2015 Bret Dahlgren. All rights reserved.
//

import UIKit

@IBDesignable

class MoonPhaseView: UIView {
    
    @IBInspectable var moonPhase:CGFloat
    
    @IBInspectable var shadowAlpha:CGFloat

    required init(coder aDecoder: NSCoder) {
        
        self.moonPhase = 0.10
        self.shadowAlpha = 0.4

        super.init(coder: aDecoder)
    }
    

    override init(frame: CGRect) {
        
        
        self.moonPhase = 0.10
        self.shadowAlpha = 0.4
        
        super.init(frame: frame)
        
        
    }
    


    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

        // Drawing code
        
        
        let radius:CGFloat = rect.size.height < rect.size.width ? rect.size.height / 2.0 : rect.size.width / 2.0
        let paintColor = UIColor(white: 0.0, alpha: shadowAlpha)
        
        paintColor.setStroke()
        paintColor.setFill()
        
        let centerInBounds = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2)
        
        
        
        // new moon around 0 and 1
        if (self.moonPhase < 0.01 || self.moonPhase > 0.99 ) {
            
            let circlePath = UIBezierPath(arcCenter: centerInBounds, radius: radius, startAngle: 0.0, endAngle: degreesToRadians(360.0), clockwise: true)
            
            circlePath.fill()
            
            return
        }
        
        
        var circlePath = UIBezierPath()
        
        let c1 =  self.moonPhase > 0.5  ? radius : ( -radius * (self.moonPhase - 0.25 ) * 4.0)
        
        circlePath = drawArc(circlePath, center: centerInBounds, radius: radius, lineSegmentC: c1 , firstArc: true )
        

        let c2 = self.moonPhase < 0.5 ? radius : ( radius * (self.moonPhase - 0.75 ) * 4.0)

        
        circlePath = drawArc(circlePath, center: centerInBounds, radius: radius, lineSegmentC: c2 , firstArc: false )
        
        
        circlePath.fill()
        
    }
    
    func drawArc(circlePath:UIBezierPath, center:CGPoint, radius:CGFloat, lineSegmentC: CGFloat, firstArc: Bool) -> UIBezierPath {
        
        if (lineSegmentC == 0.0) {
            return circlePath; // will get divide by zero error
        }
        
        let clockwise = lineSegmentC > 0.0
        
        let needDegrees = firstArc ? clockwise : !clockwise
        
        let lineSegmentA = radius
        let lineSegmentB = radius
        
        let lineSegmentD = lineSegmentA * lineSegmentB / lineSegmentC
        
        let bigRadius = CGFloat(fabs(lineSegmentC + lineSegmentD) / 2.0)
        
        //let bigCirclePosition = bigRadius - lineSegmentC // TODO: -/+ of c needs to be addressed here
        
        let bigCircleDistance = sqrt((bigRadius * bigRadius) - (radius * radius)) * (needDegrees ? 1:-1 ) // needDegrees is poorly named
        
        let dCenter = CGPointMake(center.x - bigCircleDistance, center.y)
        
        let aDegrees = CGFloat(needDegrees ? 0:180.0)
        
        let angle1 = degreesToRadians(aDegrees) - (asin(radius/bigRadius) * (clockwise ? 1 : -1))
        
        let angle2 = degreesToRadians(aDegrees) + (asin(radius/bigRadius) * (clockwise ? 1 : -1))
        
        circlePath.addArcWithCenter(dCenter, radius: bigRadius, startAngle: angle1, endAngle: angle2, clockwise: clockwise )
        
        return circlePath;
        
        
    }
    
    
    func degreesToRadians(degrees:CGFloat) -> CGFloat {
        return (CGFloat(M_PI) * degrees) / 180.0;
    }


}
