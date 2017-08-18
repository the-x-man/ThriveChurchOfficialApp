//
//  AboutViewController.swift
//  Thrive Community Church
//
//  Created by Wyatt Baggett on 6/23/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contactingAdmin(_ sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
    
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients(["wyatt@thrive-fl.org"])
            composeVC.setMessageBody("Enter your message to the Developer here:", isHTML: true)
            present(composeVC, animated: true, completion: nil)
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    //Standard Mail compose controller code
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                                                   error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
            
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
            
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
            
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
            
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}