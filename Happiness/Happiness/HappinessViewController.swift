//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Katie Jones on 5/14/15.
//  Copyright (c) 2015 Katie Jones. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            let recognizer = UIPinchGestureRecognizer(target: faceView, action: "scale:")
            faceView.addGestureRecognizer(recognizer)
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
    }
    
    @IBAction func changeHappniess(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    var happiness: Int = 75 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        //interpret the model for the view
        return Double(happiness-50)/50
    }
    
    func pinch(gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .Changed: fallthrough
        case .Ended:
            let scale = gesture.scale
            //gesture.set(CGPointZero, inView: faceView)
        default: break
        }
    }
    
}
