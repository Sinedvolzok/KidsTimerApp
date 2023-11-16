//
//  LaunchExtentoinTVC.swift
//  KidsTimer
//
//  Created by denis on 15/07/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

struct Launch {
    
    let circleFaceHair:CircleView = {
        let circle = CircleView(fillColor: #colorLiteral(red: 1, green: 0.4823529412, blue: 0.4823529412, alpha: 1), radius: 1)
        circle.circle.opacity = 0
        return circle
    }()
    
    let circleBackgrond:CircleView = {
        let circle = CircleView(fillColor: #colorLiteral(red: 0.9498334391, green: 0.8777312972, blue: 0.9062978281, alpha: 1), radius: 1)
        return circle
    }()
    
    let circleFace:CircleView = {
        let circle = CircleView(fillColor: #colorLiteral(red: 0.9568627451, green: 0.7843137255, blue: 0.6392156863, alpha: 1), radius: 1)
        return circle
    }()
    
    let strokeWhite:CircleView = {
        let circle = CircleView(strokeColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), radius: 70, lineWidth: 40, strokeEnd: 0.0)
        return circle
    }()
    
    let circleEyeLeft:CircleView = {
        let circle = CircleView(fillColor: #colorLiteral(red: 0.1512928299, green: 0.1512928299, blue: 0.1512928299, alpha: 1), radius: 1)
        circle.circle.opacity = 0
        circle.rotateTo(angle: 12.0)
        return circle
    }()
    
    let circleEyeRight:CircleView = {
        let circle = CircleView(fillColor: #colorLiteral(red: 0.1512928299, green: 0.1512928299, blue: 0.1512928299, alpha: 1), radius: 1)
        circle.circle.opacity = 0
        return circle
    }()
    
    let strokeSmile:CircleView = {
        let circle = CircleView(strokeColor: #colorLiteral(red: 0.1512928299, green: 0.1512928299, blue: 0.1512928299, alpha: 1), radius: 12, lineWidth: 5, strokeEnd: 0.0)
        circle.rotateTo(angle: 45.0)
        return circle
    }()
    
    let strokeEyeLeftClose:CircleView = {
        let circle = CircleView(strokeColor: #colorLiteral(red: 0.1512928299, green: 0.1512928299, blue: 0.1512928299, alpha: 1), radius: 6, lineWidth: 4, strokeEnd: 0.5)
        circle.circle.opacity = 0
        circle.rotateTo(angle: 15.0)
        return circle
    }()
    
    let stickArc:SticksView = {
        let sticks = SticksView(strokeColor: #colorLiteral(red: 0.1512928299, green: 0.1512928299, blue: 0.1512928299, alpha: 1), radius: 40, lineLegth: 20, lineWidth: 3, strokeEnd: 1, angle: 35, count: 3)
        sticks.opacity = 0
        sticks.rotateTo(angle: -20.0)
        return sticks
    }()
    
    let stickCircleFinal:SticksView = {
        let sticks = SticksView(strokeColor: #colorLiteral(red: 0.1512928299, green: 0.1512928299, blue: 0.1512928299, alpha: 1), radius: 20, lineLegth: 80, lineWidth: 4, strokeEnd: 1, angle: 300, count: 5)
        sticks.opacity = 0
        return sticks
    }()
}

extension TimerViewController {
    
    private func setupLaunchConstraints() {
        
        [launch.circleFaceHair,
         launch.circleFace,
         launch.strokeWhite,
         launch.circleBackgrond,
         launch.stickCircleFinal].forEach { $0.anchorToNativeCenter() }
        
        launch.circleEyeLeft.anchorToNativeCenter(constantY: -4, constantX: 20)
        
        launch.circleEyeRight.anchorToNativeCenter(constantY: -12, constantX: -25)
        
        launch.strokeSmile.anchorToNativeCenter(constantY: 22, constantX: -11)
        
        launch.strokeEyeLeftClose.anchorToNativeCenter(constantY: 5, constantX: 24)
        
        launch.stickArc.anchorToNativeCenter(constantY: 5, constantX: 24)
    }
    
    func addLaunchScreenViews() {
        
        [launch.circleBackgrond,
         launch.strokeWhite,
         launch.circleFace,
         launch.circleFaceHair,
         launch.circleEyeLeft,
         launch.circleEyeRight,
         launch.strokeSmile,
         launch.strokeEyeLeftClose,
         launch.stickArc,
         launch.stickCircleFinal].forEach { view.addSubview($0) }
        
        animateStartLaunch()
        animateFace()
        animateSmile()
        animateCloseEye()
        animateOpenEye()
        animateFaceOff()
        animateEndLaunch()
        
        setupLaunchConstraints()
    }
    
    func animateStartLaunch() {
        // nothing to circles
        launch.circleBackgrond.animateRadius(scale: 1600, duration: 0.5, dalay: 1.0, key: "Start")
        launch.circleFace.animateRadius(scale: 45, duration: 0.2, dalay: 1.2, key: "Start")
        launch.circleFaceHair.animateOpacity(opacity: 1, duration: 0.1, dalay: 1.1, key: "StartFace")
        launch.circleFaceHair.animateRadius(scale: 30, duration: 0.2, dalay: 1.3, key: "StartHair")
        launch.strokeWhite.animateStroke(strokeEnd: 1.0, duration: 0.5, dalay: 1.5, key: "Start")
    }
    
    func animateFace() {
        // circles to face
        launch.circleFaceHair.animateMove(scale: 22, tx: 10, ty: -65, duration: 0.5, dalay: 2.0, key: "Start")
        launch.circleEyeRight.animateOpacity(opacity: 1, duration: 0.1, dalay: 2.3, key: "StartEyeR")
        launch.circleEyeRight.animateRadius(scale: 6, duration: 0.4, dalay: 2.5, key: "Start")
        launch.circleEyeLeft.animateOpacity(opacity: 1, duration: 0.1, dalay: 2.5, key: "StartEyeL")
        launch.circleEyeLeft.animateRadius(scale: 6, duration: 0.4, dalay: 2.7, key: "Start")
    }
    
    func animateSmile() {
        // mouth moving
        launch.strokeSmile.animateStroke(strokeEnd: 0.01, duration: 0.2, dalay: 3.0, key: "LittleMouth")
        launch.strokeSmile.animateRadius(scale: 2.0, duration: 0.5, dalay: 3.2, key: "SayO")
        launch.strokeSmile.animateRadius(scale: 1, duration: 0.2, dalay: 3.7, key: "SayM")
        launch.strokeSmile.animateStroke(strokeEnd: 0.3, duration: 0.5, dalay: 4.0, key: "SmileMouth")
    }
    
    func animateCloseEye() {
        // eye clouse
        launch.circleEyeLeft.animateStratch(scaleY: 9.5, duration: 0.5, dalay: 4.5, key: "CloseEyeStart")
        launch.circleEyeRight.animateStratch(scaleY: 9.5, duration: 0.5, dalay: 4.5, key: "CloseEyeStart")
        launch.circleEyeLeft.animateMove(scale: 8.2, tx: 4, ty: 5, duration: 0.4, dalay: 4.8, key: "Clouse")
        launch.circleEyeRight.animateMove(scale: 8.2, tx: 2, ty: 5, duration: 0.4, dalay: 4.8, key: "Clouse")
        launch.strokeSmile.animateMove(scale: 1, tx: 2, ty: 2, duration: 0.4, dalay: 4.8, key: "Clouse")
        launch.circleFaceHair.animateMove(scale: 25, tx: 18, ty: 7, duration: 0.8, dalay: 4.8, key: "Clouse")
        launch.circleEyeLeft.animateStratch(scaleY: 8.2, duration: 0.2, dalay: 5.0, key: "CloseEyeEnd")
        launch.circleEyeRight.animateStratch(scaleY: 8.2, duration: 0.2, dalay: 5.0, key: "CloseEyeEnd")
        launch.circleEyeLeft.animateOpacity(opacity: 0, duration: 0.1, dalay: 5.1, key: "CloseEye")
        launch.strokeEyeLeftClose.animateOpacity(opacity: 1, duration: 0.1, dalay: 5.1, key: "Clouse")
        launch.stickArc.animateOpacity(opacity: 1, duration: 0.1, dalay: 5.1, key: "Clouse")
    }
    
    func animateOpenEye() {
        // eye open
        launch.circleEyeLeft.animateOpacity(opacity: 1, duration: 0.05, dalay: 6.0, key: "OpenEye")
        launch.strokeEyeLeftClose.animateOpacity(opacity: 0, duration: 0.05, dalay: 6.0, key: "Open")
        launch.stickArc.animateOpacity(opacity: 0, duration: 0.1, dalay: 6.0, key: "Open")
        launch.circleEyeLeft.animateMove(scale: 8.2, tx: -4, ty: -5, duration: 0.4, dalay: 6.0, key: "Open")
        launch.circleEyeRight.animateMove(scale: 8.2, tx: -2, ty: -5, duration: 0.4, dalay: 6.0, key: "Open")
        launch.strokeSmile.animateMove(scale: 1, tx: -2, ty: -2, duration: 0.4, dalay: 6.0, key: "Open")
        launch.circleFaceHair.animateMove(scale: 22, tx: -18, ty: -7, duration: 0.8, dalay: 6.0, key: "Open")
    }
    func animateFaceOff() {
        // face to circles
        launch.circleFaceHair.animateMove(scale: 25, tx: -10, ty: 65, duration: 0.5, dalay: 7.0, key: "End")
        launch.circleEyeLeft.animateMove(scale: 1, tx: 8, ty: 20, duration: 0.4, dalay: 7.0, key: "End")
        launch.circleEyeRight.animateMove(scale: 1, tx: 4, ty: 25, duration: 0.4, dalay: 7.0, key: "End")
        launch.strokeSmile.animateMove(scale: 0.1, tx: 16, ty: 10, duration: 0.4, dalay: 7.0, key: "End")
        launch.circleEyeRight.animateOpacity(opacity: 0, duration: 0.1, dalay: 7.5, key: "EndOp")
        launch.circleEyeLeft.animateOpacity(opacity: 0, duration: 0.1, dalay: 7.5, key: "EndOp")
        launch.strokeSmile.animateOpacity(opacity: 0, duration: 0.1, dalay: 7.5, key: "EndOp")
    }
    
    func animateEndLaunch() {
        // cicrles to nothing
        launch.circleFaceHair.animateRadius(scale: 1, duration: 0.2, dalay: 7.8, key: "End")
        launch.circleFace.animateRadius(scale: 1, duration: 0.3, dalay: 7.8, key: "End")
        launch.strokeWhite.animateRadius(scale: 1, duration: 0.4, dalay: 7.8, key: "End")
        launch.circleBackgrond.animateRadius(scale: 1, duration: 0.5, dalay: 7.8, key: "End")
        launch.stickCircleFinal.animateOpacity(opacity: 1, duration: 0.1, dalay: 7.8, key: "EndOp")
        launch.stickCircleFinal.animateSrokeEnd(strokeEnd: 0.0, duration: 0.2, dalay: 7.9, key: "EndStroke")
        launch.stickCircleFinal.animateOpacity(opacity: 0, duration: 0.1, dalay: 8.0, key: "EndOpToZero")
        launch.circleFaceHair.animateOpacity(opacity: 0, duration: 0.1, dalay: 8.0, key: "EndOp")
        launch.circleFace.animateOpacity(opacity: 0, duration: 0.1, dalay: 8.1, key: "EndOp")
        launch.strokeWhite.animateOpacity(opacity: 0, duration: 0.1, dalay: 8.2, key: "EndOp")
        launch.circleBackgrond.animateOpacity(opacity: 0, duration: 0.1, dalay: 8.3, key: "EndOp")
    }
    
    func removeLaunchScreenViews() {
        
        [launch.circleBackgrond,
         launch.strokeWhite,
         launch.circleFace,
         launch.circleFaceHair,
         launch.circleEyeLeft,
         launch.circleEyeRight,
         launch.strokeSmile,
         launch.strokeEyeLeftClose,
         launch.stickArc,
         launch.stickCircleFinal].forEach { $0.removeFromSuperview() }
    }
    
}
