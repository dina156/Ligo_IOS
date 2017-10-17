//
//  SettingViewController.swift
//  Ligo
//
//  Created by Mengsroin Heng on 23/8/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var studyLikeProButton: UIButton!
    
    @IBOutlet weak var rateThisAppButton: UIButton!

    @IBOutlet weak var giveFeedbackButton: UIButton!
    
    @IBOutlet weak var aboutNHelpButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        studyLikeProButton.layer.cornerRadius = 5
        studyLikeProButton.clipsToBounds = true
        
        rateThisAppButton.layer.cornerRadius = 5
        rateThisAppButton.clipsToBounds = true
        
        giveFeedbackButton.layer.cornerRadius = 5
        giveFeedbackButton.clipsToBounds = true
        
        aboutNHelpButton.layer.cornerRadius = 5
        aboutNHelpButton.clipsToBounds = true
    }
    
    @IBAction func onSignInOrSignUpClick(_ sender: Any) {
        performSegue(withIdentifier: "SegueSignInOrSignUp", sender: nil)
    
    }
}
