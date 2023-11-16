//
//  PlayTimerViewController.swift
//  KidsTimer
//
//  Created by denis on 26/12/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import CoreData

@available(iOS 10.3, *)

class PlayTimerViewController: UIViewController {
    
    let styles = [
    // MARK:- Raibow
    Style(
        play: Element(
            images: [ #imageLiteral(resourceName: "Sun"), #imageLiteral(resourceName: "SunLight"), #imageLiteral(resourceName: "Sun")],
            constraints: [
                Constant(offsetY: -100, offsetX: 0, width: 200, height: 200),
                Constant(offsetY: -200, offsetX: 0, width: 400, height: 400),
                Constant(offsetY: -100, offsetX: 0, width: 200, height: 200)
            ]),
        escortPlay: Element(
            images: [ #imageLiteral(resourceName: "CloudMiddleLightBlue"), #imageLiteral(resourceName: "CloudMiddleLightBlue"), #imageLiteral(resourceName: "CloudBigWhite"), #imageLiteral(resourceName: "CloudSmallWhite"), #imageLiteral(resourceName: "CloudSmallWhite")],
            constraints: [
                Constant(offsetY: 40, offsetX: 80, width: 95, height: 55),
                Constant(offsetY: 45, offsetX: -45, width: 95, height: 55),
                Constant(offsetY: 10, offsetX: 28, width: 125, height: 70),
                Constant(offsetY: 90, offsetX: 55, width: 65, height: 35),
                Constant(offsetY: 20, offsetX: -80, width: 65, height: 35)
            ]),
        reset: Element(
            images: [ #imageLiteral(resourceName: "CloudSmallGray"), #imageLiteral(resourceName: "CloudBigGray"), #imageLiteral(resourceName: "CloudMiddleGray")],
            constraints: [
                    Constant(offsetY: 90, offsetX: 90, width: 65, height: 35),
                    Constant(offsetY: 75, offsetX: -20, width: 125, height: 70),
                    Constant(offsetY: 125, offsetX: 15, width: 95, height: 55)
            ]),
        backColor: #colorLiteral(red: 0.337254902, green: 0.5921568627, blue: 0.7843137255, alpha: 1),
        indicateColors: [#colorLiteral(red: 1, green: 0.5411764706, blue: 0.5411764706, alpha: 1),#colorLiteral(red: 1, green: 0.831372549, blue: 0.4745098039, alpha: 1), #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4745098039, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.9843137255, blue: 0.4745098039, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.9803921569, blue: 0.4745098039, alpha: 1), #colorLiteral(red: 0.4509803922, green: 0.9921568627, blue: 1, alpha: 1), #colorLiteral(red: 0.462745098, green: 0.8392156863, blue: 1, alpha: 1), #colorLiteral(red: 0.5568627451, green: 0.5803921569, blue: 1, alpha: 1), #colorLiteral(red: 0.8039215686, green: 0.5607843137, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 1, green: 0.6549019608, blue: 0.8823529412, alpha: 1)],
        shapeLayerNum: 0
        ),
        // MARK:- Mignight
        Style(
            play: Element(
                images: [#imageLiteral(resourceName: "Moon"),#imageLiteral(resourceName: "MoonLight"),#imageLiteral(resourceName: "MoonLight")],
                constraints: [
                    Constant(offsetY: -100, offsetX: 0, width: 200, height: 200),
                    Constant(offsetY: -200, offsetX: 0, width: 400, height: 400),
                    Constant(offsetY: -100, offsetX: 0, width: 200, height: 200)
                ]),
            escortPlay: Element(
                images: [#imageLiteral(resourceName: "CloudMiddleGray"),#imageLiteral(resourceName: "CloudMiddleGray"),#imageLiteral(resourceName: "CloudBigWhite"),#imageLiteral(resourceName: "CloudSmallWhite"),#imageLiteral(resourceName: "CloudSmallGray")],
                constraints: [
                    Constant(offsetY: 40, offsetX: 80, width: 95, height: 55),
                    Constant(offsetY: 45, offsetX: -45, width: 95, height: 55),
                    Constant(offsetY: 10, offsetX: 28, width: 125, height: 70),
                    Constant(offsetY: 90, offsetX: 55, width: 65, height: 35),
                    Constant(offsetY: 20, offsetX: -80, width: 65, height: 35)
                ]),
            reset: Element(
                images: [ #imageLiteral(resourceName: "CloudSmallGrayMidnight"), #imageLiteral(resourceName: "CloudBigGrayMidnight"), #imageLiteral(resourceName: "CloudMiddleGrayMidnight")],
                constraints: [
                    Constant(offsetY: 90, offsetX: 90, width: 65, height: 35),
                    Constant(offsetY: 75, offsetX: -20, width: 125, height: 70),
                    Constant(offsetY: 125, offsetX: 15, width: 95, height: 55)
                ]),
            backColor: #colorLiteral(red: 0.03211421549, green: 0.1417657741, blue: 0.2261197374, alpha: 1),
            indicateColors: [#colorLiteral(red: 0.9921568627, green: 1, blue: 0.6941176471, alpha: 1),#colorLiteral(red: 0.6588235294, green: 1, blue: 0.8352941176, alpha: 1), #colorLiteral(red: 0.4431372549, green: 0.9921568627, blue: 0.8941176471, alpha: 1), #colorLiteral(red: 0.3098039216, green: 0.9215686275, blue: 0.9607843137, alpha: 1), #colorLiteral(red: 0.2196078431, green: 0.8, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.1568627451, green: 0.6, blue: 0.8509803922, alpha: 1), #colorLiteral(red: 0.09019607843, green: 0.4823529412, blue: 0.7607843137, alpha: 1), #colorLiteral(red: 0.03137254902, green: 0.3803921569, blue: 0.631372549, alpha: 1), #colorLiteral(red: 0.01568627451, green: 0.3529411765, blue: 0.4941176471, alpha: 1), #colorLiteral(red: 0.05674107383, green: 0.2643560343, blue: 0.3723669846, alpha: 1)],
            shapeLayerNum: 10
        ),
        // MARK:- KingDay
        Style(
            play: Element(
                images: [#imageLiteral(resourceName: "Сrown"),#imageLiteral(resourceName: "LionHead"),UIImage()],
                constraints: [
                    Constant(offsetY: -90, offsetX: 0, width: 100, height: 60),
                    Constant(offsetY: -90, offsetX: 0, width: 220, height: 220),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            escortPlay: Element(
                images: [#imageLiteral(resourceName: " Paws"),UIImage(),UIImage(),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: -110, offsetX: 0, width: 160, height: 190),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            reset: Element(
                images: [#imageLiteral(resourceName: "Row"),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: 20, offsetX: -20, width: 185, height: 150),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            backColor: #colorLiteral(red: 1, green: 0.5725490196, blue: 0.06666666667, alpha: 1),
            indicateColors: [#colorLiteral(red: 1, green: 0.6549019608, blue: 0.07058823529, alpha: 1),#colorLiteral(red: 1, green: 0.6941176471, blue: 0.07058823529, alpha: 1), #colorLiteral(red: 1, green: 0.7411764706, blue: 0.07450980392, alpha: 1), #colorLiteral(red: 1, green: 0.7921568627, blue: 0.07843137255, alpha: 1), #colorLiteral(red: 1, green: 0.8470588235, blue: 0.08235294118, alpha: 1), #colorLiteral(red: 1, green: 0.8901960784, blue: 0.0862745098, alpha: 1), #colorLiteral(red: 1, green: 0.937254902, blue: 0.09019607843, alpha: 1), #colorLiteral(red: 0.6823529412, green: 0.1098039216, blue: 0.1568627451, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 0.1294117647, green: 0.2745098039, blue: 0.5450980392, alpha: 1)],
            shapeLayerNum: 0
        ),
        // MARK:- HoneyBees
        Style(
            play: Element(
                images: [#imageLiteral(resourceName: "HoneyImage"),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: -100, offsetX: 0, width: 200, height: 200),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            escortPlay: Element(
                images: [#imageLiteral(resourceName: "RFlouwerImage"),#imageLiteral(resourceName: "LFlouwerImage"),UIImage(),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: -97, offsetX: 65, width: 245, height: 285),
                    Constant(offsetY: -97, offsetX: -65, width: 245, height: 285),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            reset: Element(
                images: [ #imageLiteral(resourceName: "SorocoputImage"),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: 40, offsetX: -80, width: 190, height: 200),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            backColor: #colorLiteral(red: 0.3764705882, green: 0.3725490196, blue: 0.3568627451, alpha: 1),
            indicateColors: [#colorLiteral(red: 0.8549019608, green: 0.8666666667, blue: 0.2980392157, alpha: 1),#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1), #colorLiteral(red: 0.8549019608, green: 0.8666666667, blue: 0.2980392157, alpha: 1), #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1), #colorLiteral(red: 0.8549019608, green: 0.8666666667, blue: 0.2980392157, alpha: 1), #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1), #colorLiteral(red: 0.8549019608, green: 0.8666666667, blue: 0.2980392157, alpha: 1), #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1), #colorLiteral(red: 0.8549019608, green: 0.8666666667, blue: 0.2980392157, alpha: 1), #colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1)],
            shapeLayerNum: 20
        ),
        // MARK:- SeeAdventure
        Style(
            play: Element(
                images: [#imageLiteral(resourceName: "GemImage"),#imageLiteral(resourceName: "TopGemImage"),UIImage()],
                constraints: [
                    Constant(offsetY: -33, offsetX: 0, width: 195, height: 128),
                    Constant(offsetY: 30, offsetX: 0, width: 200, height: 65),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            escortPlay: Element(
                images: [#imageLiteral(resourceName: "WaveImageBG"),#imageLiteral(resourceName: "WaveImage"),#imageLiteral(resourceName: "WaveImage"),#imageLiteral(resourceName: "WaveImage"),UIImage()],
                constraints: [
                    Constant(offsetY: -420, offsetX: 0, width: 1895, height: 665),
                    Constant(offsetY: -470, offsetX: 30, width: 1895, height: 665),
                    Constant(offsetY: -520, offsetX: 0, width: 1895, height: 665),
                    Constant(offsetY: -570, offsetX: 30, width: 1895, height: 665),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            reset: Element(
                images: [ #imageLiteral(resourceName: "FlagImage"), UIImage(), UIImage()],
                constraints: [
                    Constant(offsetY: -100, offsetX: -15, width: 173, height: 293),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            backColor: #colorLiteral(red: 0.5803921569, green: 0.8549019608, blue: 0.8705882353, alpha: 1),
            indicateColors: [#colorLiteral(red: 0.8901960784, green: 0.6235294118, blue: 0.537254902, alpha: 1),#colorLiteral(red: 0.862745098, green: 0.8784313725, blue: 0.9019607843, alpha: 1), #colorLiteral(red: 0.5215686275, green: 0.6431372549, blue: 0.8235294118, alpha: 1), #colorLiteral(red: 0.4784313725, green: 0.4980392157, blue: 0.5254901961, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.6235294118, blue: 0.537254902, alpha: 1), #colorLiteral(red: 0.862745098, green: 0.8784313725, blue: 0.9019607843, alpha: 1), #colorLiteral(red: 0.5215686275, green: 0.6431372549, blue: 0.8235294118, alpha: 1), #colorLiteral(red: 0.4784313725, green: 0.4980392157, blue: 0.5254901961, alpha: 1), #colorLiteral(red: 0.8901960784, green: 0.6235294118, blue: 0.537254902, alpha: 1), #colorLiteral(red: 0.862745098, green: 0.8784313725, blue: 0.9019607843, alpha: 1)],
            shapeLayerNum: 12
        ),
        // MARK:- VideoGames
        Style(
            play: Element(
                images: [#imageLiteral(resourceName: "PacManLeft"),#imageLiteral(resourceName: "PacManRight"),UIImage()],
                constraints: [
                    Constant(offsetY: -70, offsetX: 0, width: 200, height: 200),
                    Constant(offsetY: -70, offsetX: 0, width: 200, height: 200),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            escortPlay: Element(
                images: [UIImage(),UIImage(),UIImage(),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            reset: Element(
                images: [ #imageLiteral(resourceName: "GameOverImage"), #imageLiteral(resourceName: "GostImage"), #imageLiteral(resourceName: "GostEyesImage")],
                constraints: [
                    Constant(offsetY: 60, offsetX: 20, width: 90, height: 90),
                    Constant(offsetY: 26, offsetX: 8, width: 110, height: 140),
                    Constant(offsetY: 80, offsetX: 52, width: 53, height: 22)
                ]),
            backColor: #colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.1607843137, alpha: 1),
            indicateColors: [#colorLiteral(red: 0.9098039269, green: 0.1362078607, blue: 0.8119786362, alpha: 1),#colorLiteral(red: 0.2935204979, green: 0.8901960784, blue: 0.396622602, alpha: 1), #colorLiteral(red: 0.9397802982, green: 0.4700658775, blue: 0.5065364079, alpha: 1), #colorLiteral(red: 0.1753426853, green: 0.756498239, blue: 0.9324040292, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.1362078607, blue: 0.8119786362, alpha: 1), #colorLiteral(red: 0.2935204979, green: 0.8901960784, blue: 0.396622602, alpha: 1), #colorLiteral(red: 0.9397802982, green: 0.4700658775, blue: 0.5065364079, alpha: 1), #colorLiteral(red: 0.1753426853, green: 0.756498239, blue: 0.9324040292, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.1362078607, blue: 0.8119786362, alpha: 1), #colorLiteral(red: 0.2935204979, green: 0.8901960784, blue: 0.396622602, alpha: 1)],
            shapeLayerNum: 13
        ),
        // MARK:- Boom
        Style(
            play: Element(
                images: [#imageLiteral(resourceName: "Boom"),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: -100, offsetX: 0, width: 200, height: 200),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            escortPlay: Element(
                images: [#imageLiteral(resourceName: "LeftHand"),#imageLiteral(resourceName: "RightHand"),UIImage(),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: 20, offsetX: -155, width: 250, height: 110),
                    Constant(offsetY: 20, offsetX: 155, width: 250, height: 110),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            reset: Element(
                images: [ #imageLiteral(resourceName: "ResetRope"),UIImage(),UIImage()],
                constraints: [
                    Constant(offsetY: -30, offsetX: 65, width: 30, height: 160),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0),
                    Constant(offsetY: 0, offsetX: 0, width: 0, height: 0)
                ]),
            backColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            indicateColors: [#colorLiteral(red: 1, green: 0.3275179373, blue: 0.33684375, alpha: 1),#colorLiteral(red: 1, green: 0.7655076398, blue: 0.2646325471, alpha: 1), #colorLiteral(red: 0.9923180111, green: 1, blue: 0.2547885826, alpha: 1), #colorLiteral(red: 0.7407891833, green: 0.9843137255, blue: 0.2380280891, alpha: 1), #colorLiteral(red: 0.2313816792, green: 0.9803921569, blue: 0.2679697947, alpha: 1), #colorLiteral(red: 0.2811247043, green: 0.9963063587, blue: 1, alpha: 1), #colorLiteral(red: 0.2398588481, green: 0.7060101764, blue: 1, alpha: 1), #colorLiteral(red: 0.3734164415, green: 0.3689505761, blue: 1, alpha: 1), #colorLiteral(red: 0.7069452317, green: 0.2839083235, blue: 0.9960784314, alpha: 1), #colorLiteral(red: 1, green: 0.2254618254, blue: 0.7621456266, alpha: 1)],
            shapeLayerNum: 11
        ),
    ]
    
    // MARK:- Variables
    
    var playerBackgrounds: AVAudioPlayer?
    var playerEffects: AVAudioPlayer?
    var playerMusic: AVAudioPlayer?
    
    // launch variables
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    
    // MARK:- View Did Load Vars
    
    // view did load variables
    let labelTimeNumber: UILabel = {
        let label = UILabel()
        label.frame.size = CGSize(width: 250, height: 250)
        label.center = CGPoint(x: UIScreen.main.bounds.size.width/2 - 27, y: UIScreen.main.bounds.size.height/2 - UIScreen.main.bounds.size.height*0.045)
        label.font = UIFont(name: "Porky's", size: 188)
        label.textColor = UIColor(cgColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        label.textAlignment = .center
        label.text = " 1 "
        label.alpha = 0.0
        return label
    } ()
    
    var circleArray = [TimerIndicatorView]()
    
    // MARK:- Timer Global Vars
    var views = Views()
    var control = Control()
    
    var buttons = Buttons()
    let tutorial = Tutorial()
    
    var delayStartAnimation:Double = 0
    
    var radiusIndex = 0
    var circleIndex = 0
    var colorIndex = 0
    var numberOfMinutes = 1
    var maxNumberOfMinutes = 10
    var minute:Double = 60
    
    // MARK:- Exception Vars
    
    let finalBoom: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "FinalBoom"))
        imageView.alpha = 0
        return imageView
    } ()
    
    let finalGamesArray: [UIImageView] = {
        var imageViewArray = [UIImageView]()
        (0...9).forEach{_ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "Sun"))
            imageView.alpha = 0
            imageViewArray.append(imageView)
        }
        return imageViewArray
    } ()
    
    let finalGamesYouWinArray: [UIImageView] = {
        var imageViewArray = [UIImageView]()
        let images = [#imageLiteral(resourceName: "YOU"),#imageLiteral(resourceName: "WIN"),#imageLiteral(resourceName: "!!!")]
        images.forEach{
            let imageView = UIImageView(image: $0)
            imageView.alpha = 0
            imageViewArray.append(imageView)
        }
        return imageViewArray
    } ()
    
    // MARK:- Emitters
    
    let candyEmitter = CandyRainEmitterView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
    let cloudEmitter = CloudsEmitterView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
    let starEmitter = StarsEmitterView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
    let beesEmitter = BeesEmitterView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
    let shipsEmitter = ShipsEmitterView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
    let glassesEmitter = GlassesRainEmitterView(frame: CGRect(origin: .zero, size: UIScreen.main.bounds.size))
    
    // MARK:- Style Timer Vars
    var buttonSwithStyleArray: [UIButton] = {
        
        let colorArray = [#colorLiteral(red: 0.1960784314, green: 0.5098039216, blue: 0.6862745098, alpha: 1),#colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.262745098, alpha: 1),#colorLiteral(red: 1, green: 0.5725490196, blue: 0.06666666667, alpha: 1),#colorLiteral(red: 0.3764705882, green: 0.3725490196, blue: 0.3568627451, alpha: 1),#colorLiteral(red: 0.5803921569, green: 0.8549019608, blue: 0.8705882353, alpha: 1),#colorLiteral(red: 0.168627451, green: 0.1607843137, blue: 0.1607843137, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let imageArray:[UIImage] = [#imageLiteral(resourceName: "iconImageRainbow"),#imageLiteral(resourceName: "iconImageMidnight"),#imageLiteral(resourceName: "IconKingDay"),#imageLiteral(resourceName: "IconHoneyBee"),#imageLiteral(resourceName: "ShipAdventureIcon"),#imageLiteral(resourceName: "IconVideoGames"),#imageLiteral(resourceName: "IconImageBoom")]
        var buttonArray = [UIButton]()
        
        for _ in 0...colorArray.count-1 {
            let button = UIButton()
            buttonArray.append(button)
        }
        
        for (index,button) in buttonArray.enumerated() {
            button.backgroundColor = colorArray[index]
            button.setImage(imageArray[index], for: .normal)
            button.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
            button.layer.borderWidth = 8
            button.layer.cornerRadius = 18
            button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset = CGSize(width: 0, height: 4)
            button.layer.shadowRadius = 8
            button.addTarget(self, action: #selector(handleButtonSwitchStyle),for: .touchUpInside)
        }
        
        return buttonArray
    }()
    
    var buttonsScrollView = UIScrollView()
    
    let placeFrameForButtonsScrollView:UIView = {
        
        let view = UIView()
        
        view.backgroundColor = .clear
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.borderWidth = 10
        view.layer.cornerRadius = 18
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    var shapeLayerNum = 0
    
    var swichStyleTimer:StyleTimer = .rainbow
    
    var playTimerBGSound = "PlayTimerBGSoundRainbow"
    
    var endMinuteMusicSound = "EndMinuteMusicSound"
    
    var endTimeMusicSound = "EndTimeMusicSound"
    
    // MARK:- Data Vars
    
    var modelController = ModelController()
    
    weak var delegate: SubscriptionViewController!
    weak var delegateParent: ParentViewController!
    
    override func viewDidLoad() {
        
        print("viewDidLoad")
        
        // bind TVC with AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.playTimerViewController = self
        
        delayStartAnimation = 0.2
        
        // pause Timer in background with app delegate
        NotificationCenter.default.addObserver(self, selector: #selector(PlayTimerViewController.pauseTimer), name: NSNotification.Name(rawValue: "PauseTimer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PlayTimerViewController.playTimer), name: NSNotification.Name(rawValue: "PlayTimer"), object: nil)
        
        UIApplication.shared.isIdleTimerDisabled = true // Screen dont get sleep
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(cgColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        startAppScreenViews()
    }
    
    deinit {
        
        // Удаляем наблюдателя
    NotificationCenter.default.removeObserver(self)

    }
    
    // start App Screen setup
    
    func startAppScreenViews() {
        
        //playSound(fileName: "RainLight", player: 0, delay: 7)
        playerBackgrounds?.numberOfLoops = -1
        
        print("Color i = \(colorIndex)")
        
        // let's draw number or minutes
        view.addSubview(labelTimeNumber)
        
        let mainViewController = TimerViewController()
        mainViewController.delegate = self
        
        }
        
        
        // let's draw icons UI
        
        //MARK:- Targets
    }
    
    
    // func addMenuVC() {
     //   let menuVC = MenuViewController()
    //    guard let controller = navigationController else {return}
   //     controller.pushViewController(menuVC, animated: true)
  //  }
    
    // music player
    
/*func playSound(fileName: String, player: Int, delay: TimeInterval) {
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {return}
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            if player == 0 {
                playerBackgrounds = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = playerBackgrounds else { return }
                player.volume = swichStyleTimer == .honeyBees ? 1.0 : 0.5
                
                player.prepareToPlay()
                player.play(atTime: player.deviceCurrentTime + delay)
            } else if player == 1 {
                playerEffects = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = playerEffects else { return }
                player.volume = 1.0
                player.prepareToPlay()
                player.play(atTime: player.deviceCurrentTime + delay)
            } else if player == 2 {
                playerMusic = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                guard let player = playerMusic else { return }
                player.volume = 1.0
                player.prepareToPlay()
                player.play(atTime: player.deviceCurrentTime + delay)
            }
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
        } catch let error {
            print(error.localizedDescription)
        }*/


