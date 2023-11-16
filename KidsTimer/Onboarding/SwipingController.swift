//
//  SwipingController.swift
//  KidsTimer
//
//  Created by denis on 25/12/2019.
//  Copyright © 2019 denis. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import Firebase

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(image: #imageLiteral(resourceName: "OnBoardinImage_1"),
             headerText: "Step 1 Tell",
             bodyText: "Suggest to your kid\ndoing the task\nKid may refuse to do it",
             buttonText: "I got it",
             buttonSkipText: ""),
        Page(image: #imageLiteral(resourceName: "OnBoardinImage_2"),
             headerText: "Step 2 Involve",
             bodyText: "Let your child set up countdown time\nwithout your assistance\nStart the timer",
             buttonText: "Оkay",
             buttonSkipText: ""),
        Page(image: #imageLiteral(resourceName: "OnBoardindImage_3"),
             headerText: "Step 3 Fix",
             bodyText: "If the kid needs more time give another chance\nIf your kid copes with the task successfully – praise",
             buttonText: "Yeah",
             buttonSkipText: ""),
        Page(image: #imageLiteral(resourceName: "OnBoardinImage_4"),
             headerText: "Before You Start",
             bodyText: "Find out about discounts, new timers and the product updates",
             buttonText: "Allow Push",
             buttonSkipText: "Skip"),
        Page(image: #imageLiteral(resourceName: "OnBoardingImages_5"),
             headerText: "Try",
             bodyText: "Trial KidsTimer first 14 days and decide if it’s worth subscription",
             buttonText: "Start Trial",
             buttonSkipText: "")
    ]
    
    let notifications = Notifications()
    
    private lazy var onboardingPageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.9930996193, green: 0.9493382472, blue: 0.9615318591, alpha: 0.3)
        return pageControl
    }()
    
    private lazy var onboardingButton: UIButton = {
        
        let button = UIButton()
        
        //button style
        button.backgroundColor = #colorLiteral(red: 0.9259002221, green: 0.4635620388, blue: 0.1187493692, alpha: 1)
        button.layer.cornerRadius = 13
        button.layer.shadowColor = #colorLiteral(red: 0.2766100888, green: 0.1418527521, blue: 0.05900173913, alpha: 0.3)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 10
        
        //button text style
        let textButton = pages[onboardingPageController.currentPage].buttonText
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        //button text style
        let textButton = pages[onboardingPageController.currentPage].buttonSkipText
        button.setTitle(textButton, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9259002221, green: 0.4635620388, blue: 0.1187493692, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()
    
    var endFinishTrialDate = Date()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupButtomControls()
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.2431372549, blue: 0.2431372549, alpha: 1)
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        
    }
    
    func setupButtomControls() {
        view.addSubview(onboardingPageController)
        view.addSubview(onboardingButton)
        view.addSubview(skipButton)
        onboardingPageController.anchorToBottomCenter(bottom: 26, width: 100, height: 50)
        onboardingButton.anchorToBottomCenter(bottom: 76, width: 160, height: 55)
        skipButton.anchorToBottomCenter(bottom: 76, constantX: 120, width: 80, height: 55)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        onboardingPageController.currentPage = Int(x/view.frame.width)
        let textButton = pages[onboardingPageController.currentPage].buttonText
        onboardingButton.setTitle(textButton, for: .normal)
        let textSkipButton = pages[onboardingPageController.currentPage].buttonSkipText
        skipButton.setTitle(textSkipButton, for: .normal)
    }
    
    @objc private func handleSkip() {
        if onboardingPageController.currentPage == pages.count - 2 {
            print("SKIP")
             let nextIndex = min(onboardingPageController.currentPage + 1, pages.count - 1)
                   let indexPath = IndexPath(item: nextIndex, section: 0)
                   onboardingPageController.currentPage = nextIndex
                   collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            let textButton = pages[onboardingPageController.currentPage].buttonText
            onboardingButton.setTitle(textButton, for: .normal)
            let textSkipButton = pages[onboardingPageController.currentPage].buttonSkipText
            skipButton.setTitle(textSkipButton, for: .normal)
        } else { return }
    }
    
    @objc private func handleNext() {
        
        if onboardingPageController.currentPage == 0 {
            logOnboardingFirstTapEventFB()
        }
        
        if onboardingPageController.currentPage == 1 {
            logOnboardingSecondTapEventFB()
        }
        
        if onboardingPageController.currentPage == 2 {
            logOnboardingеThirdTapEventFB()
        }
        
        if onboardingPageController.currentPage == pages.count - 2 {
            print("Allow Push")
            logOnboardingPushAllowTapEventFB()
            notifications.requestAutorization()
            notifications.notificationCenter.delegate = notifications
        }
        
        if onboardingPageController.currentPage == pages.count - 1 {
            print("Start Trial")
            logOnboardingStartTrialEventFB()
            endFinishTrialDate = Date().addingTimeInterval(15.days())
            saveDate(endTrialDate: endFinishTrialDate)
            print("save data")
            addPlayTimerVC()
        }
        
        print("NEXT")
        let nextIndex = min(onboardingPageController.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        onboardingPageController.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let textButton = pages[onboardingPageController.currentPage].buttonText
        onboardingButton.setTitle(textButton, for: .normal)
        let textSkipButton = pages[onboardingPageController.currentPage].buttonSkipText
        skipButton.setTitle(textSkipButton, for: .normal)
    }
    
    func saveDate(endTrialDate: Date) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TrialTime", in: context)
        
        let dateObject = NSManagedObject(entity: entity!, insertInto: context) as! TrialTime
        
        dateObject.dateEndTrial = endTrialDate
        
        do {
            try context.save()
            print("Save End Trial Data")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func addPlayTimerVC() {
        
        let playTimerViewController = PlayTimerViewController()
        
        addChild(playTimerViewController)
        view.addSubview(playTimerViewController.view)
        playTimerViewController.didMove(toParent: self)
        
        playTimerViewController.view.anchorFillToSuperview()
        playTimerViewController.view.layer.opacity = 0.0
        playTimerViewController.view.animateOpacity(toValue: 1.0, duration: 0.5, delay: 0.0, key: "PlayTimerOpacity")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            playTimerViewController.view.layer.opacity = 1.0
        }
    }
    
    func logOnboardingFirstTapEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Onboarding First Screen Taped"))
    }
    func logOnboardingSecondTapEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Onboarding Second Screen Taped"))
    }
    func logOnboardingеThirdTapEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Onboarding Third Screen Taped"))
    }
    func logOnboardingPushAllowTapEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Onboarding Push Allow Taped"))
    }
    func logOnboardingStartTrialEventFB() {
        AppEvents.logEvent(AppEvents.Name.init(rawValue: "Onboarding Start Trial Taped"))
    }
}
