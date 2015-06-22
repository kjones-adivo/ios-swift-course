//
//  TextViewController.swift
//  Psychologist
//
//  Created by Katie Jones on 5/25/15.
//  Copyright (c) 2015 Katie Jones. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!{
        didSet {
            textView.text = text
        }
    }
    
    var text: String = "" {
        didSet{
            textView?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            //check if we are in the middle of presenting something
            if textView != nil && presentingViewController != nil {
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            }
            else {
                return super.preferredContentSize
            }
        }
        set { super.preferredContentSize = newValue}
    }

}
