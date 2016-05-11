//
//  SettingTVC.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/10/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate {
    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 1{
            let mailComposeViewController = configureMail()
            
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                // if you have no email setup on the phone
                mailAlert()
            }
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["asketola@yahoo.com"])
        mailComposeVC.setSubject("Music Video Feedback")
        mailComposeVC.setMessageBody("Hi Annemarie,\n\nI would like to share the following feedback...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No email set up on the Device", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            // do something if we want
        }
        
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Cancelled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail failed")
        default:
            print("Unknown issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
