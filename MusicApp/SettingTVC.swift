//
//  SettingTVC.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/10/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedbackDisplay: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    @IBOutlet weak var touchID: UISwitch!

    @IBOutlet weak var bestImageDisplay: UILabel!

    @IBOutlet weak var apiCount: UILabel!
    
    @IBOutlet weak var sliderCount: UISlider!
    
    @IBOutlet weak var numberOfVideosLabel: UILabel!
    
    @IBOutlet weak var dragSliderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        tableView.alwaysBounceVertical = false
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSettings")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "prefferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            apiCount.text = "\(theValue)"
            sliderCount.value = Float(theValue)
        } else {
            sliderCount.value = 10.0
            apiCount.text = ("\(Int(sliderCount.value))")
        }
        
    }
    
    @IBAction func valueChanged(sender: AnyObject) {
        let defualts = NSUserDefaults.standardUserDefaults()
        defualts.setObject(Int(sliderCount.value) , forKey: "APICNT")
        apiCount.text = ("\(Int(sliderCount.value))")
        
    }
    
    @IBAction func touchIdSec(sender: AnyObject) {
        
        let defualts = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defualts.setBool(touchID.on, forKey: "SecSettings")
        } else {
            defualts.setBool(false, forKey: "SecSettings")
        }
        
    }
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        apiCount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfVideosLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragSliderLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged:", object: nil)
    }
    
    private struct storyboard {
        static let aboutSegueIdentifier = "goToAboutScreen"
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.aboutSegueIdentifier {
                _ = segue.destinationViewController as! AboutVC
            }
        }
}
