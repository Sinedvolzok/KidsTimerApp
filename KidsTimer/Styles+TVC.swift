//
//  Styles+TVC.swift
//  KidsTimer
//
//  Created by denis on 14/08/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit

struct Style {
    
    let play: Element
    let escortPlay: Element
    let reset: Element
    let backColor: UIColor
    let indicateColors: [CGColor]
    let shapeLayerNum: Int
}

struct Element {
    
    let images: [UIImage]
    let constraints: [Constant]
}

struct Constant {
    
    let offsetY: Int
    let offsetX: Int
    let width: Int
    let height: Int
}

enum StyleTimer {
    
    case rainbow
    case midnight
    case boom
    case honeyBees
    case seeAdventure
    case videoGames
    case kingDay
    
    var styleName: String {
        switch self {
        case .rainbow:
            return "Rainbow"
        case .midnight:
            return "Midnight"
        case .boom:
            return "Boom"
        case .honeyBees:
            return "HoneyBees"
        case .seeAdventure:
            return "seaAdventure"
        case .videoGames:
            return "videoGames"
        case .kingDay:
        return "kingDay"
        }
    }
    
}


