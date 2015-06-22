//
//  ImageViewController.swift
//  Cassini
//
//  Created by Katie Jones on 6/4/15.
//  Copyright (c) 2015 Katie Jones. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    //model
    var imageURL: NSURL? {
        didSet {
            image = nil
            //dont fetch image unless currently on-screen
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private func fetchImage()
    {
        if let url = imageURL {
            spinner?.startAnimating()
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                let imageData = NSData(contentsOfURL: url)
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageURL {
                        if imageData != nil {
                        //turn into a UIImage
                        //capturing self
                            self.image = UIImage(data: imageData!)
                        } else {
                            self.image = nil
                        }
                    }
                }
            }
        }
    }
    
    //example of asynchronous code wrapped in iOS API
    private func fetchImageAsynchronously()
    {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        if let url = NSURL(string: "http://url"){
            let request = NSURLRequest(URL: url)
            let task = session.downloadTaskWithRequest(request) {
                (localURL, response, error) in
                //do things on UI - must use dispatch_async
                dispatch_async(dispatch_get_main_queue()) {
                    //actually do it in here
                }
            }
            task.resume()
        }
    }
    
    //great place to set delegate
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet {
            //set content size here and anytime image changes
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    //implement one of the old obj-c func for scrollview
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //create a user view in code
    private var imageView = UIImageView()
    //not in a superview yet
    
    //when image is set, be able to intervene
    //similar to a func SetImage()
    private var image: UIImage? {
        get {return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // (?): set image internally even if outlets have not been set yet
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    //happens late in the process
    override func viewDidLoad() {
        super.viewDidLoad()
        //build hierarchy here because all outlets are set
        //add image view to scrollview
        scrollView.addSubview(imageView)
        //default image
//        if image == nil {
//            imageURL = DemoURL.Stanford
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    


}
