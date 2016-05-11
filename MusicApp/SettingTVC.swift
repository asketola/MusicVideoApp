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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alwaysBounceVertical = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "prefferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        apiCount.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged:", object: nil)
    }

}
