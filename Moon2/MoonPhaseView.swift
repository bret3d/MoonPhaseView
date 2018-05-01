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
    
    @IBInspectable var moonPhase: CGFloat
    
    @IBInspectable var shadowAlpha: CGFloat
    
    @IBInspectable var shadowColor: UIColor
    
    required init?(coder aDecoder: NSCoder) {
        
        self.moonPhase = 0.10
        self.shadowAlpha = 0.4
        self.shadowColor = UIColor.gray
        super.init(coder: aDecoder)
    }
    
    
    // needed for IBDesignable
    override init(frame: CGRect) {
        
        self.moonPhase = 0.10
        self.shadowAlpha = 0.4
        self.shadowColor = UIColor.gray
        super.init(frame: frame)
        
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        
        // let radius: CGFloat = (rect.size.height < rect.size.width ? rect.size.height / 2.0 : rect.size.width / 2.0) - 1.0
        
        let radius = bounds.midY
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        shadowColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let paintColor = UIColor(red:r, green:g, blue: b, alpha: shadowAlpha)
        
        paintColor.setStroke()
        paintColor.setFill()
        
        let centerInBounds = CGPoint(x: bounds.midX, y: bounds.midY)
        
        // new moon around 0 and 1, also protects around erroneous cases
        if (self.moonPhase < 0.01 || self.moonPhase > 0.99 ) {
            
            UIBezierPath(arcCenter: centerInBounds, radius: radius, startAngle: 0.0, endAngle:.pi * 2.0, clockwise: true).fill()
            
            return
        }
        
        let c1 = self.moonPhase > 0.5 ? radius : -radius * (self.moonPhase - 0.25 ) * 4.0
        
        let c2 = self.moonPhase < 0.5 ? radius :  radius * (self.moonPhase - 0.75 ) * 4.0
        
        UIBezierPath().drawMoonArc(arcCenter: centerInBounds, radius: radius, lineSegmentC: c1, firstArc: true  )
            .drawMoonArc(arcCenter: centerInBounds, radius: radius, lineSegmentC: c2, firstArc: false )
            .fill()
        
    }
    
    func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return (.pi * degrees) / 180.0
    }
    
    func rotateShadow(_ degrees: CGFloat) {
        transform = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
    }
}

extension UIBezierPath {
    
    func drawMoonArc(arcCenter: CGPoint, radius: CGFloat, lineSegmentC: CGFloat, firstArc: Bool) -> UIBezierPath {
        
        if (lineSegmentC == 0.0) {
            return self // to avoid the divide by zero error and draw a straight line which we want anyway
        }
        
        let clockwise = lineSegmentC > 0.0
        
        let direction = firstArc ? clockwise : !clockwise
        
        let lineSegmentA = radius
        
        let lineSegmentB = radius
        
        let lineSegmentD = lineSegmentA * lineSegmentB / lineSegmentC
        
        let bigRadius = CGFloat(fabs(lineSegmentC + lineSegmentD) / 2.0)
        
        let bigCirclePosition = (bigRadius - fabs(lineSegmentC)) * (direction ? 1:-1 )
        
        let dCenter = CGPoint(x: arcCenter.x - bigCirclePosition, y: arcCenter.y)
        
        let aDegrees = CGFloat(direction ? 0:180.0)
        
        let angle1 = degreesToRadians(aDegrees) - (asin(radius/bigRadius) * (clockwise ? 1 : -1))
        
        let angle2 = degreesToRadians(aDegrees) + (asin(radius/bigRadius) * (clockwise ? 1 : -1))
        
        self.addArc(withCenter: dCenter, radius: bigRadius, startAngle: angle1, endAngle: angle2, clockwise: clockwise )
        
        return self
        
    }
    
    func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return (.pi * degrees) / 180.0
    }
    
}


