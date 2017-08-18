//
//  ThriveFGCUViewController.swift
//  Thrive Church Official App
//
//  Created by Thrive on 9/9/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ThriveFGCUViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openDirections(_ sender: AnyObject) {
        
        let url = URL(string: "http://maps.apple.com/?daddr=Thrive+Community+Church&dirflg=d")
        
        if UIApplication.shared.canOpenURL(url!){
            UIApplication.shared.openURL(url!)
        }
        else{
            UIApplication.shared.openURL(url!)
        }
    }
    
    @IBAction func feedback(_ sender: AnyObject) {
//        let modelInfo = UIDevice.current.model
//        let systeminfo = UIDevice.current.systemName
//        let systemVersion = UIDevice.current.systemVersion
        
        if MFMailComposeViewController.canSendMail() {
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients(["wyatt@thrive-fl.org"])
            composeVC.setSubject("App Feedback")
            composeVC.setMessageBody("(Replace this text with your message) What can we do to make this app better? We'd love to hear from you!",
                isHTML: true)
            //composeVC.set
            
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