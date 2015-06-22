//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by Katie Jones on 5/25/15.
//  Copyright (c) 2015 Katie Jones. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController : HappinessViewController, UIPopoverPresentationControllerDelegate
{    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int] {
        get { return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
        set { defaults.setObject(newValue, forKey: History.DefaultsKey)}
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History" //name of class or view controller writng to Defaults in front
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
