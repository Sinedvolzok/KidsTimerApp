//
//  ShipsEmitterView.swift
//  KidsTimer
//
//  Created by denis on 06/09/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

class ShipsEmitterView: UIView {
    
    private let particleEmitter = CAEmitterLayer()
    private let cell = CAEmitterCell()
    
    let emitterCells:[CAEmitterCell] = {
        
        let imagesNames = ["RedShipImage"]
        var cells = [CAEmitterCell]()
        
        for index in 0...0 {
            let cell = CAEmitterCell()
            cell.birthRate = 0.06
            cell.lifetime = 70.0
            cell.lifetimeRange = 0
            cell.velocity = 6
            cell.velocityRange = 4
            cell.emissionLongitude = CGFloat.pi/2
            cell.xAcceleration = 4.5
            cell.yAcceleration = -0.585
            cell.spin = 0.0
            cell.scale = 0.52
            cell.alphaRange = 0
            cell.contents = #imageLiteral(resourceName: imagesNames[index]).cgImage
            cells.append(cell)
        }
        return cells
    } ()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        createParticles()
        //        configureLayers()
    }
    
    required public init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        createParticles()
        //        commonInit()
    }
    
    // MARK: - Setup Layers
    
    private func createParticles() {
        
        particleEmitter.emitterPosition = CGPoint(x: -1000, y: UIScreen.main.bounds.size.height-100)
        particleEmitter.emitterShape = .rectangle
        particleEmitter.emitterSize = CGSize(width: 900, height: 1)
        
        particleEmitter.emitterCells = emitterCells
        
        layer.addSublayer(particleEmitter)
    }
    
}
