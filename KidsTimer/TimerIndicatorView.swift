//
//  TimerGrphics.swift
//  KidsTimer
//
//  Created by denis on 31/01/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

class TimerIndicatorView: UIView {
    
    override func draw(_ rect: CGRect) {
        drawRingFittingInsideView()
    }
    
    // MARK:- Variables
    var circleCenter = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 - UIScreen.main.bounds.size.height*0.045)
    
    var strokeColor: CGColor
    var strokeStart: CGFloat = 0
    var strokeEnd: CGFloat = 1
    var startAngle: CGFloat = -CGFloat.pi / 2 + CGFloat.pi / 18
    var shapeLayerNum: Int
    
    init(strokeColor: CGColor, strokeStart: CGFloat, strokeEnd: CGFloat, shapeLayerNum: Int) {
        
        self.strokeColor = strokeColor
        self.strokeStart = strokeStart
        self.strokeEnd = strokeEnd
        self.shapeLayerNum = shapeLayerNum
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height*0.09))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let shapeLayerArray = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(),
        CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(),
        CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    
    // MARK:- Functions
    
    internal func drawRingFittingInsideView()->() {
        
        // MARK:- Functions draw circle
        if shapeLayerNum <= 9 {
            for index in 0...9 {
                // drawing circle whith less radius for animate
                shapeLayerArray[index].path = UIBezierPath(arcCenter: circleCenter, radius: 125+CGFloat(25*index), startAngle: startAngle, endAngle: CGFloat.pi / 1.8 - 3*CGFloat.pi, clockwise: false).cgPath
                
                // draw stroke
                shapeLayerArray[index].fillColor = UIColor.clear.cgColor
                shapeLayerArray[index].strokeColor = strokeColor
                shapeLayerArray[index].lineWidth = 25
                shapeLayerArray[index].lineCap = CAShapeLayerLineCap.round
                
                // draw for animations
                shapeLayerArray[index].strokeEnd = strokeEnd
                shapeLayerArray[index].opacity = 1.0
            }
        }
        
        // MARK:- Functions draw star
        
        if shapeLayerNum == 10 {
            
            let pathStar = CGMutablePath()
            
            let centerStar = CGPoint(x: (superview?.frame.size.width ?? 0)/2, y: (superview?.frame.size.height ?? 0)/2 - (superview?.frame.size.height ?? 0)*0.045)
            
            let radiusOut = 185.0
            let radiusInside = 85.0
            
            pathStar.move(to:
                
                CGPoint(
                    x: Double(centerStar.x) +  (radiusOut+radiusInside-15)/2 * cos(12.0 * Double.pi / 180),
                    y: Double(centerStar.y) + (radiusOut+radiusInside-15)/2 * sin(12.0 * Double.pi / 180))
            )
            
            for indexPoint in stride(from: 36.0, to: 361.0, by: 36.0) {
                
                let angleRadians1End = indexPoint * Double.pi / 180
                
                let angleRadians2End = (indexPoint+36) * Double.pi / 180
                
                print("Star Point")
                
                let pointOne =
                    CGPoint(
                        x: Double(centerStar.x) + (Int(indexPoint).isMultiple(of: 72) ? radiusOut : radiusInside) * cos(angleRadians1End),
                        y: Double(centerStar.y) + (Int(indexPoint).isMultiple(of: 72) ? radiusOut : radiusInside) * sin(angleRadians1End))
                print(pointOne.x,pointOne.y)
                let pointTwo =
                    CGPoint(
                        x: Double(centerStar.x) + (Int(indexPoint).isMultiple(of: 72) ? radiusInside : radiusOut) * cos(angleRadians2End),
                        y: Double(centerStar.y) + (Int(indexPoint).isMultiple(of: 72) ? radiusInside : radiusOut) * sin(angleRadians2End))
                
                pathStar.addArc(
                    tangent1End: pointOne,
                    tangent2End: pointTwo,
                    radius: 25)
            }
            pathStar.closeSubpath()
            
            shapeLayerArray[10].fillColor = UIColor.clear.cgColor
            shapeLayerArray[10].strokeColor = strokeColor
            shapeLayerArray[10].lineWidth = 25
            shapeLayerArray[10].lineCap = CAShapeLayerLineCap.round
            shapeLayerArray[10].path = pathStar
            
            // draw for animations
            shapeLayerArray[10].strokeEnd = strokeEnd
            shapeLayerArray[10].opacity = 1.0
        }
        
        
        
        // MARK:- Functions draw spiral
        
        if shapeLayerNum == 11 {
            
            let pathSpiral = CGMutablePath()
            
            var centerSpiral = CGPoint(x: (superview?.frame.size.width ?? 0)/2, y: (superview?.frame.size.height ?? 0)/2 - (superview?.frame.size.height ?? 0)*0.045)
            let startRadius = 125.0
            var radius = 125.0
            
            //        path.move(to: CGPoint(x: center.x, y: center.y + CGFloat(radius)))
            pathSpiral.move(to: CGPoint(x: centerSpiral.x, y: (superview?.frame.size.height ?? 0) - 87.5))
            
            let pointOneArc = CGPoint(x: centerSpiral.x, y: centerSpiral.y + CGFloat(radius) + 50)
            
            let angleRadiusArc = 135 * Double.pi / 180
            
            let pointTwoArc = CGPoint(x: Double(centerSpiral.x) + radius * cos(angleRadiusArc), y: Double(centerSpiral.y) + radius * sin(angleRadiusArc))
            
            pathSpiral.addArc(
                tangent1End: pointOneArc,
                tangent2End: pointTwoArc,
                radius: 100)
            
            //        path.addLine(to: CGPoint(x: center.x, y: center.y + CGFloat(radius) + 50))
            
            for i in stride(from: 135.0, to: 2401.0, by: 5) {
                
                let angleRadians = i * Double.pi / 180
                for rotateIndex in 1...20 {
                    if Int(i) == 180 * rotateIndex {
                        radius = Double(startRadius) + 12.5 * Double(rotateIndex)// startRadius is radius at start
                        if rotateIndex%2==0 {
                            centerSpiral.x = (superview?.frame.size.width ?? 0)/2
                        } else {
                            centerSpiral.x = (superview?.frame.size.width ?? 0)/2 + 12.5
                        }
                    }
                }
                let x = Double(centerSpiral.x) + radius * cos(angleRadians)
                let y = Double(centerSpiral.y) + radius * sin(angleRadians)
                pathSpiral.addLine(to: CGPoint(x: x, y: y))
            }
            
            shapeLayerArray[11].fillColor = UIColor.clear.cgColor
            shapeLayerArray[11].strokeColor = strokeColor
            shapeLayerArray[11].lineWidth = 25
            shapeLayerArray[11].lineCap = CAShapeLayerLineCap.square
            shapeLayerArray[11].path = pathSpiral
            
            // draw for animations
            shapeLayerArray[11].strokeEnd = strokeEnd
            shapeLayerArray[11].opacity = 1.0
        }
        
        // MARK:- Functions draw SeeAdventure
        
        if shapeLayerNum == 12 {
            
            let pathSee = CGMutablePath()
            
            let centerSee = CGPoint(x: (superview?.frame.size.width ?? 0)/2, y: (superview?.frame.size.height ?? 0)/2 - (superview?.frame.size.height ?? 0)*0.045)
            
            let radiusOutSee = 185.0
            let radiusInsideSee = 95.0
            
            pathSee.move(to:
                
                CGPoint(
                    x: Double(centerSee.x) +  (radiusOutSee+radiusInsideSee-15)/2 * cos(15.0 * Double.pi / 180),
                    y: Double(centerSee.y) + (radiusOutSee+radiusInsideSee-15)/2 * sin(15.0 * Double.pi / 180))
            )
            
            for indexPoint in stride(from: 45.0, to: 361.0, by: 45.0) {
                
                let angleRadians1End = indexPoint * Double.pi / 180
                
                let angleRadians2End = (indexPoint+45) * Double.pi / 180
                
                print("Star Point")
                
                let pointOne =
                    CGPoint(
                        x: Double(centerSee.x) + (Int(indexPoint).isMultiple(of: 90) ? radiusOutSee : radiusInsideSee) * cos(angleRadians1End),
                        y: Double(centerSee.y) + (Int(indexPoint).isMultiple(of: 90) ? radiusOutSee : radiusInsideSee) * sin(angleRadians1End))
                print(pointOne.x,pointOne.y)
                let pointTwo =
                    CGPoint(
                        x: Double(centerSee.x) + (Int(indexPoint).isMultiple(of: 90) ? radiusInsideSee : radiusOutSee) * cos(angleRadians2End),
                        y: Double(centerSee.y) + (Int(indexPoint).isMultiple(of: 90) ? radiusInsideSee : radiusOutSee) * sin(angleRadians2End))
                
                pathSee.addArc(
                    tangent1End: pointOne,
                    tangent2End: pointTwo,
                    radius: 25)
            }
            pathSee.closeSubpath()
            
            shapeLayerArray[12].fillColor = UIColor.clear.cgColor
            shapeLayerArray[12].strokeColor = strokeColor
            shapeLayerArray[12].lineWidth = 25
            shapeLayerArray[12].lineCap = CAShapeLayerLineCap.round
            shapeLayerArray[12].path = pathSee
            
            // draw for animations
            shapeLayerArray[12].strokeEnd = strokeEnd
            shapeLayerArray[12].opacity = 1.0
        }
        
        // MARK:- Functions draw VideoGames
        if shapeLayerNum == 13 {
            
            let pathVideoGames = CGMutablePath()
            let centerVideoGames = CGPoint(x: (superview?.frame.size.width ?? 0)/2, y: (superview?.frame.size.height ?? 0)/2 - (superview?.frame.size.height ?? 0)*0.045)
            
            let aPharam = 90
            let bPharam = 100
            let gapBetwenAB = 8
            
            pathVideoGames.move(to:
                
                CGPoint(
                    x: centerVideoGames.x + aPharam.cgFloat(),
                    y: centerVideoGames.y - bPharam.cgFloat())
            
            )
            
            (0...21).forEach{
                
                let point = CGPoint(
                    x: centerVideoGames.x + ($0 % 4 == 3 || $0 % 4 == 2 ? -1 : 1) * (aPharam + gapBetwenAB*$0 + ($0 % 2 == 1 ? -1 : 0)).cgFloat(),
                    y: centerVideoGames.y + ($0 % 4 == 3 || $0 % 4 == 0 ? -1 : 1) * (bPharam + gapBetwenAB*$0).cgFloat()
                )
                pathVideoGames.addLine(to: point)
            }
            
            let lineDashPattern: [NSNumber]  = [1.0,44.0]
            shapeLayerArray[13].lineDashPattern = lineDashPattern
            
            shapeLayerArray[13].fillColor = UIColor.clear.cgColor
            shapeLayerArray[13].strokeColor = strokeColor
            shapeLayerArray[13].lineWidth = 25
            shapeLayerArray[13].lineCap = CAShapeLayerLineCap.round
            shapeLayerArray[13].path = pathVideoGames
            
            // draw for animations
            shapeLayerArray[13].strokeEnd = strokeEnd
            shapeLayerArray[13].opacity = 1.0
        }
        
        // MARK:- Functions draw Honeycomb
        if shapeLayerNum >= 20 && shapeLayerNum <= 29 {
            for index in 20...29 {
                let pathHoneycomb = UIBezierPath()
                let centerHoneycomb = CGPoint(x: (superview?.frame.size.width ?? 0)/2, y: (superview?.frame.size.height ?? 0)/2 - (superview?.frame.size.height ?? 0)*0.045)
                
                let radiusHoneycomb = 125+CGFloat(30*(index-20))
                
                pathHoneycomb.move(to:
                    CGPoint(
                        x: centerHoneycomb.x + radiusHoneycomb * CGFloat(cos(330.0 * Double.pi / 180)),
                        y: centerHoneycomb.y + radiusHoneycomb * CGFloat(sin(330.0 * Double.pi / 180)))
                )
                
                for indexPoint in stride(from: 330.0, to: 691.0, by: 60.0) {
                    
                    let angleRadians = indexPoint * Double.pi / 180
                    
                    print("Honeycomb Point for \(index)")
                    
                    let point =
                        CGPoint(
                            x: centerHoneycomb.x + radiusHoneycomb * CGFloat(cos(angleRadians)),
                            y: centerHoneycomb.y + radiusHoneycomb * CGFloat(sin(angleRadians)))
                    
                    pathHoneycomb.addLine(to: point)
                }
//                pathHoneycomb.stroke()
                
                shapeLayerArray[index].fillColor = UIColor.clear.cgColor
                shapeLayerArray[index].strokeColor = strokeColor
                shapeLayerArray[index].lineWidth = 25
                shapeLayerArray[index].lineCap = CAShapeLayerLineCap.round
                shapeLayerArray[index].path = pathHoneycomb.cgPath
                
                // draw for animations
                shapeLayerArray[index].strokeEnd = strokeEnd
                shapeLayerArray[index].opacity = 1.0
            }
        }
        
        layer.addSublayer(shapeLayerArray[shapeLayerNum])
    }
    
    func animateStroke(
        fromStrokeEnd: CGFloat = 0,
        fromStrokeStart: CGFloat = 0,
        toStrokeEnd: CGFloat = 0,
        toStrokeStart: CGFloat = 0,
        duration: CFTimeInterval,
        delay: Double = 0,
        key: String) {
        
        let basicAnimationStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        let basicAnimationStrokeStart = CABasicAnimation(keyPath: "strokeStart")
        
        // properties basicAnimationStrokeEnd
        basicAnimationStrokeEnd.fromValue = fromStrokeEnd
        basicAnimationStrokeEnd.toValue = toStrokeEnd
        basicAnimationStrokeEnd.duration = duration
        basicAnimationStrokeEnd.beginTime = CACurrentMediaTime() + delay
        basicAnimationStrokeEnd.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // properties basicAnimationStrokeStart
        basicAnimationStrokeStart.fromValue = fromStrokeStart
        basicAnimationStrokeStart.toValue = toStrokeStart
        basicAnimationStrokeStart.duration = duration
        basicAnimationStrokeStart.beginTime = CACurrentMediaTime() + delay
        basicAnimationStrokeStart.timingFunction = CAMediaTimingFunction(name: .linear)
        
        // stay stroke after animate
        basicAnimationStrokeEnd.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationStrokeEnd.isRemovedOnCompletion = false
        basicAnimationStrokeStart.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationStrokeStart.isRemovedOnCompletion = false
        
        shapeLayerArray[shapeLayerNum].add(basicAnimationStrokeEnd, forKey: "urSoBasicEnd" + key)
        shapeLayerArray[shapeLayerNum].add(basicAnimationStrokeStart, forKey: "urSoBasicStart" + key)
    }
    
    func animateStrokeToEnd(circleIndex: Int, strokeEnd: CGFloat = 0, duration: CFTimeInterval, delay: Double) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = strokeEnd
        basicAnimation.duration = duration
        basicAnimation.beginTime = CACurrentMediaTime() + delay
        
        print(basicAnimation.beginTime)
        print(delay)
        print(CACurrentMediaTime())
        print("shapeNum animateStrokeToEnd")
        print(circleIndex)
        
        // stay stroke after animate
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerArray[circleIndex].add(basicAnimation, forKey: "urSoBasicBackwards")
    }
    
    func animateOpacity(circleIndex: Int, delay: Double) {
        
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        
        basicAnimation.toValue = 0.0
        basicAnimation.duration = 0.2
        basicAnimation.beginTime = CACurrentMediaTime() + delay
        
        // stay opacity after animate
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerArray[circleIndex].add(basicAnimation, forKey: "urSoBasicOpacity")
    }
    
    func animateColor(circleIndex: Int, strokeColor: CGColor, delay: Double) {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeColor")
        
        basicAnimation.toValue = strokeColor
        basicAnimation.duration = 0.2
        basicAnimation.beginTime = CACurrentMediaTime() + delay
        
        // stay opacity after animate
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerArray[circleIndex].add(basicAnimation, forKey: "colorBA")
    }
    
    //MARK:- Functions For Cirle
    
    func animateRadiusLess(circleIndex: Int) {
        
        let basicAnimation = CABasicAnimation(keyPath: "path")
        if shapeLayerNum > 0 {
            basicAnimation.fromValue = shapeLayerArray[shapeLayerNum].path
            basicAnimation.toValue = shapeLayerArray[shapeLayerNum-1].path
        }
        basicAnimation.duration = 1
        basicAnimation.beginTime = CACurrentMediaTime()
        
        // stay stroke after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerArray[circleIndex].add(basicAnimation, forKey: "urSoBasicRadius")
    }
    
    func animateRadiusMore(circleIndex: Int) {
        
        let basicAnimation = CABasicAnimation(keyPath: "path")
        
        basicAnimation.fromValue = shapeLayerArray[shapeLayerNum].path
        basicAnimation.toValue = shapeLayerArray[shapeLayerNum+1].path
        
        basicAnimation.duration = 0.5
        
        // stay stroke after animate
        basicAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayerArray[circleIndex].add(basicAnimation, forKey: "urSoBasicRadius")
    }
    
    //MARK:- Functions For Stars
    
    func animateColor(toColor: CGColor) {

        let basicAnimationColor = CABasicAnimation(keyPath: "strokeColor")
        
        basicAnimationColor.toValue = toColor
        basicAnimationColor.duration = 0.5
        
        basicAnimationColor.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationColor.isRemovedOnCompletion = false
        
        shapeLayerArray[10].add(basicAnimationColor, forKey: "urSoBasicStrokeColor")
    }
    
    //MARK:- Pause & Play
    
    func pauseAnimation(indexShape: Int){
        let pausedTime = shapeLayerArray[indexShape].convertTime(CACurrentMediaTime(), from: nil)
        shapeLayerArray[indexShape].speed = 0.0
        shapeLayerArray[indexShape].timeOffset = pausedTime
        print("shapeNum pauseAnimation")
        print(indexShape)
    }
    
    func resumeAnimation(indexShape: Int){
        let pausedTime = shapeLayerArray[indexShape].timeOffset
        shapeLayerArray[indexShape].speed = 1.0
        shapeLayerArray[indexShape].timeOffset = 0.0
        shapeLayerArray[indexShape].beginTime = 0.0
        let timeSincePause = shapeLayerArray[indexShape].convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayerArray[indexShape].beginTime = timeSincePause
        print("shapeNum resumeAnimation")
        print(indexShape)
    }
}
