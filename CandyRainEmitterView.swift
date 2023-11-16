//
//  CandyRainEmitterView.swift
//  
//
//  Created by denis on 22/06/2019.
//

import UIKit

class CandyRainEmitterView: UIView {

    private let particleEmitter = CAEmitterLayer()
    private let cell = CAEmitterCell()
    
    let emitterCells:[CAEmitterCell] = {
        
        let imagesNames = ["CandyRed", "CandyGreen", "CandyBlue"]
        var cells = [CAEmitterCell]()
        
        for index in 0...2 {
            let cell = CAEmitterCell()
            cell.birthRate = Float(UIScreen.main.bounds.size.width/75)
            //            cell.birthRate = 0
            cell.lifetime = 8.0
            cell.lifetimeRange = 0
            cell.velocity = 350
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi / 4
            cell.spin = 2
            cell.spinRange = 1
            cell.scale = 0.5
            cell.scaleRange = 0.1
            cell.scaleSpeed = 0
            cell.alphaRange = 0.2
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
        
        particleEmitter.emitterPosition = CGPoint(x: UIScreen.main.bounds.size.width/2, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: UIScreen.main.bounds.size.width, height: 2)
        
        particleEmitter.emitterCells = emitterCells
        
        layer.addSublayer(particleEmitter)
    }

}
