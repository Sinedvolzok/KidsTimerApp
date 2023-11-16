//
//  GlassesRainEmitterView.swift
//  KidsTimer
//
//  Created by Denis Kozlov on 14.03.2020.
//  Copyright © 2020 denis. All rights reserved.
//

import UIKit

class GlassesRainEmitterView: UIView {
    
    private let particleEmitter = CAEmitterLayer()
    private let cell = CAEmitterCell()
    
    let emitterCells:[CAEmitterCell] = {
        
        let imagesNames = ["Glasses", "Glasses", "Glasses"]
        var cells = [CAEmitterCell]()
        
        for index in 0...2 {
            let cell = CAEmitterCell()
            cell.birthRate = 0.4
            cell.lifetime = 50.0
            cell.lifetimeRange = 0
            cell.velocity = 50
            cell.velocityRange = 2
            cell.emissionLongitude = CGFloat.pi/2
            cell.xAcceleration = 3.0
            cell.yAcceleration = 0.0
            cell.spin = 0
            cell.scale = 0.4
//            cell.scaleRange = 0.4
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
        
        particleEmitter.emitterPosition = CGPoint(x: -150, y: -150)
        particleEmitter.emitterShape = .rectangle
        particleEmitter.emitterSize = CGSize(width: 50, height: UIScreen.main.bounds.size.height)
        
        particleEmitter.emitterCells = emitterCells
        
        layer.addSublayer(particleEmitter)
    }
    
}
