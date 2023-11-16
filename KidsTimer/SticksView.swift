//
//  SticksView.swift
//  KidsTimer
//
//  Created by denis on 15/07/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

class SticksView: UIView {

    override func draw(_ rect: CGRect) {
        drawRingFittingInsideView()
    }
    
    var radiusIn: CGFloat
    var lineLegthIn: CGFloat
    
    var strokeColor: CGColor
    var lineWidth: CGFloat
    var strokeEnd: CGFloat
    var angle: Double
    var count: Int
    
    var opacity: Float = 1.0
    
    init(strokeColor: CGColor, radius: CGFloat, lineLegth: CGFloat, lineWidth: CGFloat, strokeEnd: CGFloat, angle: Double, count: Int) {
        
        self.strokeColor = strokeColor
        self.radiusIn = radius
        self.lineLegthIn = lineLegth
        self.lineWidth = lineWidth
        self.strokeEnd = strokeEnd
        self.angle = angle
        self.count = count
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stickArray = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    
    internal func drawRingFittingInsideView()->() {
        
        let numberOfSticks = count - 1
        
        for index in 0...numberOfSticks {
            
            let pathStick = CGMutablePath()
            
            let angleGradus = angle * Double(index) / Double(numberOfSticks)
            let angleRadians = angleGradus * Double.pi / 180
            
            let centerStick = CGPoint(x: 0, y: 0)
            
            let radius: CGFloat = radiusIn
            let lineLeutgh: CGFloat = lineLegthIn
            
            let stertPoint = CGPoint(x: centerStick.x + radius * CGFloat(cos(angleRadians)), y: centerStick.y + radius * CGFloat(sin(angleRadians)))
            
            let endPoint = CGPoint(x: centerStick.x + (radius + lineLeutgh) * CGFloat(cos(angleRadians)), y: centerStick.y + (radius + lineLeutgh) * CGFloat(sin(angleRadians)))
            
            pathStick.move(to: stertPoint)
            pathStick.addLine(to: endPoint)
            
            stickArray[index].path = pathStick
            stickArray[index].strokeColor = strokeColor
            stickArray[index].lineWidth = lineWidth
            stickArray[index].lineCap = .round
            stickArray[index].strokeEnd = strokeEnd
            stickArray[index].opacity = opacity
            layer.addSublayer(stickArray[index])
        }
        
    }
    
    func animateOpacity(opacity: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.toValue = opacity
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        for stick in stickArray {
            stick.add(basicAnimation, forKey: key)
        }
    }
    
    func animateSrokeEnd(strokeEnd: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = strokeEnd
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        for stick in stickArray {
            stick.add(basicAnimation, forKey: key)
        }
    }
    
    func animateSrokeStart(strokeStart: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeStart")
        
        basicAnimation.toValue = strokeStart
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        for stick in stickArray {
            stick.add(basicAnimation, forKey: key)
        }
    }

}
