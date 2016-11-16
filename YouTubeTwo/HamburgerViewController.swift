//
//  HamburgerViewController.swift
//  YouTubeTwo
//
//  Created by Kyler Blue on 11/15/16.
//  Copyright © 2016 Kyler Blue. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    var menuOriginalCenter: CGPoint!
    var menuRightOffset: CGFloat!
    var menuRight: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuRightOffset = 250
        menuOriginalCenter = feedView.center
        menuRight = CGPoint(x: feedView.center.x + menuRightOffset,y: feedView.center.y)
        

        // Create a reference to the the appropriate storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        
        addChildViewController(menuViewController)
        self.view.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)
        
        addChildViewController(feedViewController)
        self.view.addSubview(feedViewController.view)
        feedViewController.didMove(toParentViewController: self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanFeed(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("began")
            menuOriginalCenter = feedView.center
            
        }   else if sender.state == .changed {
            print("changed")
            feedView.center = CGPoint(x: menuOriginalCenter.x + translation.x, y: menuOriginalCenter.y)
            
        }   else if sender.state == .ended {
            print("ended")
            if velocity.y > 0 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.feedView.center = self.menuOriginalCenter
                    }, completion: nil)
            }   else  {
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                    self.feedView.center = self.menuRight
                    }, completion: nil)
            }
            
        }

        
    }
    

}
