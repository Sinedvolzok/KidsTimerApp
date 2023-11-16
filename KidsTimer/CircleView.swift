//
//  CircleView.swift
//  KidsTimer
//
//  Created by denis on 15/07/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

class CircleView: UIView {

    override func draw(_ rect: CGRect) {
        drawRingFittingInsideView()
    }
    
    var radius: CGFloat
    
    var fillColor: CGColor = UIColor.clear.cgColor
    var strokeColor: CGColor = UIColor.clear.cgColor
    var lineWidth: CGFloat = 1
    var strokeEnd: CGFloat = 1
    
    init(fillColor: CGColor, radius: CGFloat) {
        
        self.fillColor = fillColor
        self.radius = radius
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    init(strokeColor: CGColor, radius: CGFloat, lineWidth: CGFloat, strokeEnd: CGFloat) {
        
        self.strokeColor = strokeColor
        self.radius = radius
        self.lineWidth = lineWidth
        self.strokeEnd = strokeEnd
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let circle = CAShapeLayer()
    
    internal func drawRingFittingInsideView()->() {
        
        let pathCircle = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0.0, endAngle: 2*CGFloat.pi, clockwise: true)
        circle.path = pathCircle.cgPath
        circle.fillColor = fillColor
        circle.strokeColor = strokeColor
        circle.lineWidth = lineWidth
        circle.lineCap = .round
        circle.strokeEnd = strokeEnd
        layer.addSublayer(circle)
    }
    
    func animateRadius(scale: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let basicAnimation = CASpringAnimation(keyPath: "transform.scale")
        basicAnimation.damping = 4
        basicAnimation.toValue = scale
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        circle.add(basicAnimation, forKey: key)
    }
    
    func animateStratch(scaleY: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let basicAnimation = CASpringAnimation(keyPath: "transform.scale.y")
        basicAnimation.damping = 2
        basicAnimation.toValue = scaleY
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        circle.add(basicAnimation, forKey: key)
    }
    
    func animateMove(scale: CGFloat, tx: CGFloat, ty: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let startPoint = [0, 0]
        let movePoint = [tx, ty]
        
        let basicAnimationMove = CASpringAnimation(keyPath: "position")
        basicAnimationMove.damping = 2
        basicAnimationMove.isAdditive = true
        basicAnimationMove.fromValue = startPoint
        basicAnimationMove.toValue = movePoint
        basicAnimationMove.duration = duration
        basicAnimationMove.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimationMove.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimationMove.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationMove.isRemovedOnCompletion = false
        
        circle.add(basicAnimationMove, forKey: key + "Scale")
        
        let basicAnimation = CABasicAnimation(keyPath: "transform.scale")
        basicAnimation.toValue = scale
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        circle.add(basicAnimation, forKey: key)
    }
    
    func animateStroke(strokeEnd: CGFloat, duration: CFTimeInterval, dalay: Double, key: String) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = strokeEnd
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + dalay
        
        // stay opacity after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        circle.add(basicAnimation, forKey: key)
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
        
        circle.add(basicAnimation, forKey: key)
    }

}
