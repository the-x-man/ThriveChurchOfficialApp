//
//  DetailViewController.swift
//  notes
//
//  Created by Wyatt Baggett on 8/1/16.
//  Copyright © 2016 Wyatt Baggett. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var detailDescriptionLabel: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewController = self
        detailViewController?.becomeFirstResponder()
        
        // called when adding / editing an item to the TableViewController in MasterVew
        // Called at application init for notes tab - YES
        
        // INIT NOTE #5 - No
        saveAndUpdate()
		configureView()
        
        // segue
        //INIT NOTE #8 - I assume that this is where the code stops.
        // Since no other funcs are called after config
    }
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            saveAndUpdate()
            self.configureView()
        }
    }
    
    // runs even before the segue happens
    func configureView() {
        // Update the user interface for the detail item.
        saveAndUpdate()
        //INIT NOTE #6 - No
        if objects.count == 0 {
            return
        }
        
        if let label = self.detailDescriptionLabel {
            label.text = objects[currentIndex]
            
            if label.text == BLANK_NOTE {
                label.text = ""
            }
        }
        // INIT NOTE #7 - After returning from our inital note we end here, on the
        // "Add Note" screen once again
    }
    
    @IBAction func share(_ sender: AnyObject) {
		let textToShare = detailDescriptionLabel?.text
        
        let objectsToShare = [textToShare]
        let activityVC = UIActivityViewController(activityItems:
											objectsToShare,
                                            applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = (sender) as? UIView
        self.present(activityVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // called when hitting back on the editing screen -- after segue back to Table View
	// INIT NOTE #1 - Starts here
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
		
        if objects.count == 0 {
            return
        }
		
        //updates the text for the preview of the note on the Table View
		
		// Guard the label to prevent nil from being assigned as the index's label
		guard let labelIndex = detailDescriptionLabel?.text else { return }
		
		objects[currentIndex] = labelIndex
		if labelIndex == "" {
			objects[currentIndex] = BLANK_NOTE
		}
		
		saveAndUpdate()
        // returning from the editing view
    }
    
    // permiate changes to the master view
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
            UIActivityType.postToTencentWeibo,
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
