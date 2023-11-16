//
//  KTImageView.swift
//  KidsTimer
//
//  Created by denis on 19/07/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

class KTImageView: UIImageView {
    
    var originX: CGFloat = 0
    var originY: CGFloat = 0

    let placeY: CGFloat
    let placeX: CGFloat
    let width: CGFloat
    let height: CGFloat
    let placeAngle: Double
    
    init(placeY: CGFloat = 0, placeX: CGFloat = 0, width: CGFloat = 1, height: CGFloat = 1, placeAngle: Double = 0) {
        
        self.placeY = placeY
        self.placeX = placeX
        self.width = width
        self.height = height
        self.placeAngle = placeAngle
        
        super.init(frame: CGRect(origin: .zero, size: .zero))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func placeKT(to: Place) {
        
        let placeTo: Place = to
        
        guard let superviewHeight = superview?.frame.size.height else {return}
        guard let superviewWidth = superview?.frame.size.width else {return}
        
        switch placeTo {
            
        case .topRight:
            originX = superviewWidth - placeX - width
            originY = placeY
            
        case .topCenter:
            originX = superviewWidth/2 - placeX - width/2
            originY = placeY
            
        case .bottomLeft:
            originX = placeX
            originY = superviewHeight - placeY - height
            
        case .bottomRight:
            originX = superviewWidth - placeX - width
            originY = superviewHeight - placeY - height
            
        case .bottomCenter:
            originX = superviewWidth/2 - placeX - width/2
            originY = superviewHeight - placeY - height
            
        case .center:
            originX = superviewWidth/2 - placeX - width/2
            originY = superviewHeight/2 - placeY - height/2
            
        default:
            originX = placeX
            originY = placeY
        }
        
        frame.size = CGSize(width: width, height: height)
        
        layer.position = CGPoint(x: originX, y: originY)
        
    }
    
    func scaleImageTo(x: CGFloat, y: CGFloat) {
        scaleTo(x: width*x, y: height*y)
    }
    
    func moveImageTo(x: CGFloat = 0, y: CGFloat = 0) {
        moveTo(x: originX+x, y: originY+y)
    }
    
    func rotateImageTo(angle: Double) {
        rotateTo(angle: placeAngle+angle)
    }
    
}
