//
//  ViewController.swift
//  ZapCodeChallenge
//
//  Created by Fabio Yudi Takahara on 12/09/16.
//  Copyright © 2016 Fabio Yudi Takahara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var mainTableView: UITableView!
    private var lastContentOffset: CGFloat = 0
    private var isElementsHidden = true
    private var immobileArray = []
    
    //Constraints
    @IBOutlet weak var segmentViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var newAnnounceViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAnnounceViewConstraintLeft: NSLayoutConstraint!
    @IBOutlet weak var createAnnounceViewConstraintRight: NSLayoutConstraint!
    
    //Views
    @IBOutlet weak var announceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.announceButton.layer.cornerRadius = 6
        self.immobileArray = ObjectManager.getImmobileObjects()
    }
    
    func showAnimation() {
        
        if self.isElementsHidden == false {
            return
        }
        
        self.segmentViewConstraint.constant = -41
        self.newAnnounceViewConstraint.constant = -50
        self.createAnnounceViewConstraintLeft.constant = 500
        self.createAnnounceViewConstraintRight.constant = 500
        
        UIView.animateWithDuration(0.6) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func hideAnimation() {
        
        if self.isElementsHidden == true {
            return
        }
        
        self.segmentViewConstraint.constant = 0
        self.newAnnounceViewConstraint.constant = 0
        self.createAnnounceViewConstraintLeft.constant = 8
        self.createAnnounceViewConstraintRight.constant = 8
        
        UIView.animateWithDuration(0.6) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: TableView Manager
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.immobileArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let immobileObject = self.immobileArray[indexPath.row] as! ImmobileObject
        
        let cell = self.mainTableView.dequeueReusableCellWithIdentifier("MainCell", forIndexPath: indexPath) as! MainTableViewCell
        cell.addressLabel.text = immobileObject.fullAddress
        cell.sellImmobileLabel.text = immobileObject.sellPrice.formatSellPrice
        cell.locationLabel.text = immobileObject.locationString
        cell.locationImmobileLabel.text = immobileObject.locationPrice.formatlocationPrice
        cell.zapCodeLabel.text = String(format: "[" + String(immobileObject.code) + "] -")
        cell.immobileTypeLabel.text = immobileObject.immobileType
        
        //Image
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL.init(string: immobileObject.mainImage)!)
            dispatch_async(dispatch_get_main_queue(), {
                
                cell.progressIndicator.hidden = true
                
                if data != nil {
                    
                    cell.backgroundImageView.image = UIImage(data: data!)
                    
                } else {
                    
                    cell.backgroundImageView.image = UIImage.init(named: "failImage")
 
                }
                
                immobileObject.backgroundImage = cell.backgroundImageView.image!
            });
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let immobileObject = self.immobileArray[indexPath.row] as! ImmobileObject
        performSegueWithIdentifier("ShowDetailSegue", sender: immobileObject)
    }
    
    //MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "ShowDetailSegue") {
            
            let immobileObject = sender as! ImmobileObject
            
            let detailViewController = (segue.destinationViewController as! DetailViewController)
            detailViewController.immobileObject = immobileObject
            
        }
        
    }
    
    //MARK: ScrollView Manager
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y < 40) {
            return
        }
        
        if (self.lastContentOffset > scrollView.contentOffset.y) {
            
            self.hideAnimation()
            self.isElementsHidden = true
  
        } else if (self.lastContentOffset < scrollView.contentOffset.y) {

            self.showAnimation()
            self.isElementsHidden = false
        }
        
        self.lastContentOffset = scrollView.contentOffset.y
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

