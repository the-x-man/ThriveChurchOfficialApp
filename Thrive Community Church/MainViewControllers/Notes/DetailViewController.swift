//
//  DetailViewController.swift
//  notes
//
//  Created by Wyatt Baggett on 8/1/16.
//  Copyright © 2016 Wyatt Baggett. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UITextView!
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            saveAndUpdate()
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        saveAndUpdate()
        
        if objects.count == 0 {
            return
        }
        
        if let label = self.detailDescriptionLabel {
            label.text = objects[currentIndex]
            
            if label.text == BLANK_NOTE {
                label.text = ""
            }
        }
    }
    
    @IBAction func share(_ sender: AnyObject) {
        let textToShare = detailDescriptionLabel.text!
        
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems: objectsToShare , applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = (sender) as? UIView
        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
/*      TODO: Call Parent View controller in orv=der to load the view and also get
        the new Notes Loaded. Once they have loaded, segue back to this view.
*/
        detailViewController = self
        detailViewController?.becomeFirstResponder()
        saveAndUpdate()
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if objects.count == 0 {
            return
        }
        
        objects[currentIndex] = detailDescriptionLabel.text
        if detailDescriptionLabel.text == "" {
            objects[currentIndex] = BLANK_NOTE
        }
        saveAndUpdate()
    }
    
    func saveAndUpdate() {
        masterView?.save()
        masterView?.tableView.reloadData()
    }
}

class ActivityForNotesViewController: UIActivityViewController {
    
    //Remove actions that we do not want the user to be able to share via
    // these are intentionally marked because the media is Text
    internal func _shouldExcludeActivityType(_ activity: UIActivity) -> Bool {
        let activityTypesToExclude = [
            "com.apple.reminders.RemindersEditorExtension",
            UIActivityType.openInIBooks,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.postToWeibo,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            "com.google.Drive.ShareExtension",
            "com.apple.mobileslideshow.StreamShareService"
        ] as [Any]
        
        if let actType = activity.activityType {
            if activityTypesToExclude.contains(where: { (Any) -> Bool in
                return true
            }) {
                return true
            }
            else if super.excludedActivityTypes != nil {
                return super.excludedActivityTypes!.contains(actType)
            }
        }
        return false
    }
}