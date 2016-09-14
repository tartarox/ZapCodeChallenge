//
//  DetailViewController.swift
//  ZapCodeChallenge
//
//  Created by Fabio Yudi Takahara on 13/09/16.
//  Copyright © 2016 Fabio Yudi Takahara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //Constraints
    @IBOutlet weak var contactViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var addressViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var informationViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var priceViewConstraint: NSLayoutConstraint!
    
    
    //Layout
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var locationPriceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var bedCountLabel: UILabel!
    @IBOutlet weak var suitCountLabel: UILabel!
    @IBOutlet weak var carCountLabel: UILabel!
    @IBOutlet weak var areaCountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var photoCount: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var immobileObject = ImmobileObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactViewConstraint.constant = -50
        self.informationViewConstraint.constant = -50
        self.addressViewConstraint.constant = -50
        self.priceViewConstraint.constant = -70

        let immobileDetailObject = ObjectManager.getImmobileDetailObjects(String(self.immobileObject.code))
        
        self.sellPriceLabel.text = self.immobileObject.sellPrice.formatSellPrice
        self.locationPriceLabel.text = self.immobileObject.locationPrice.formatSellPrice
        self.typeLabel.text = self.immobileObject.immobileType
        
        self.bedCountLabel.text = String(immobileDetailObject.sleepRoom)
        self.suitCountLabel.text = String(immobileDetailObject.suits)
        self.carCountLabel.text = String(immobileDetailObject.carSeats)
        self.areaCountLabel.text = String(immobileDetailObject.area)
        
        self.addressLabel.text = self.immobileObject.fullAddress
        self.cityLabel.text = String(format: "%@ - %@", self.immobileObject.city, self.immobileObject.state)
        self.backgroundImage.image = self.immobileObject.backgroundImage
        self.photoCount.text = String(format: "1 de %i", self.immobileObject.photoArray.count)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showAnimation()
        
    }
    
    func showAnimation() {
        
        self.priceViewConstraint.constant = 150
        
        UIView.animateWithDuration(0.3, animations: {
            
            self.view.layoutSubviews()
            
        }) { (true) in
            self.informationViewConstraint.constant = 100
            UIView.animateWithDuration(0.3, animations: {
                
                self.view.layoutSubviews()
                
            }) { (true) in
                self.addressViewConstraint.constant = 50
                UIView.animateWithDuration(0.3, animations: {
                    
                    self.view.layoutSubviews()
                    
                }) { (true) in
                    self.contactViewConstraint.constant = 0
                    UIView.animateWithDuration(0.3, animations: {
                        
                        self.view.layoutSubviews()
                        
                    })
                }
            }
        }
        
    }
    
    //MARK: Actions
    
    @IBAction func popViewController(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
