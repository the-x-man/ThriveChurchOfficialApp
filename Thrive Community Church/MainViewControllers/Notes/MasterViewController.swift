//
//  MasterViewController.swift
//  notes
//
//  Created by Wyatt Baggett on 8/1/16.
//  Copyright © 2016 Wyatt Baggett. All rights reserved.
//

import UIKit
import Firebase

var objects:[String] = [String]()
var currentIndex:Int = 0
var masterView:MasterViewController?
var detailViewController:DetailViewController?
var ref: DatabaseReference!
let kNotes:String = "notes"
let BLANK_NOTE:String = "New Note"
fileprivate var handle: AuthStateDidChangeListenerHandle?

class MasterViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        masterView = self
        // Called when the user Taps "Notes" icon -- buttons are all added before the segue
        
        
        load()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(insertNewObject(_:)))
        let syncButton = UIBarButtonItem(image: #imageLiteral(resourceName: "UploadToCloud"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(syncWithFirebase(_:)))

        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.rightBarButtonItem = syncButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        // MARK: Back Button
        // Gets called when the user is returning from writing a note
        
        handle = Auth.auth().addStateDidChangeListener(self.handleAuthStateChanged(auth:user:))
        
        if objects.count == 0 {
            insertNewObject(self)
        }
        
        save()
        /*
         Adding insert new object here in this method is not working - creates an inifinte loop
         of creating a new table item - but keeps copying the text from other notes to the new one
         
        */
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Use something like this to check if there are
         print("Notes - will appear (Master)")
        //segue to the table view has been made
        //interactrion is possible now with the UITableView interface
        
        // INIT NOTE #4 - Still nothing happening on the Screen --- Showing TableView
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Adds new object & changes name of the string of Master following the segue back
    @objc func insertNewObject(_ sender: AnyObject) {
        save()
        
        //adding new
        // INIT NOTE #2 - Nada
        if objects.count == 0 || objects[0] != BLANK_NOTE {
            
            objects.insert(BLANK_NOTE, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
            save()
        }
        save()
        
        currentIndex = 0
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            //INIT NOTE #3 - Nothing Still --- may happen after this though
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let object = objects[(indexPath as NSIndexPath).row]
                currentIndex = (indexPath as NSIndexPath).row
                
                detailViewController?.detailItem = object as AnyObject?
                detailViewController?.navigationItem.leftBarButtonItem =
                            self.splitViewController?.displayModeButtonItem
                detailViewController?.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection
                                                        section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                             for: indexPath)
        
        let object = objects[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = object
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt
                                                indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // TODO: Find where the deletion is made
    override func tableView(_ tableView: UITableView, commit
                                        editingStyle: UITableViewCellEditingStyle,
                                        forRowAt indexPath: IndexPath) {
        
        // delete the iem from the table --- delete note from the DB
        if editingStyle == .delete {
            objects.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class,
            // insert it into the array, and add a new row to the table view.
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        // selecting an item to be deleted / has been removed - Called multiple times
        // for various editing tasks
        if editing {
            return
        }
        save()
    }
    
    override func tableView(_ tableView: UITableView,
                                didEndEditingRowAt indexPath: IndexPath?) {
        save()
    }
    
    func save() {
        UserDefaults.standard.set(objects, forKey: kNotes)
        UserDefaults.standard.synchronize()
    }
    
    func load() {
        if let loadedData = UserDefaults.standard.array(forKey: kNotes) as? [String] {
            objects = loadedData
        }
    }
    
    // MARK: Firebase
    func handleAuthStateChanged(auth: Auth, user: User?) {
        if Auth.auth().currentUser != nil {
            // User is signed in.
            print("User is logged in")
        }
        else {
            // Login OR Register -- only if their email is not on file
            print("Not Logged in")
            detailViewController?.loginToAccount()
        }
    }
    
    @objc func syncWithFirebase(_ sender: AnyObject) {
        
        // upload all -- checking for duplicates
        uploadNotesToFirebase()
        pullNotesFromFirebase()
        
        save()
        //sender.background = #imageLiteral(resourceName: "UploadedToCloud")
        print("SYNC - Done")
    }
    
    func uploadNotesToFirebase() {
        // while uploading check for duplicates
        print("SYNC - Uploading")
        ref = Database.database().reference().child("notes")
        let key = ref.childByAutoId().key
        
        ref.queryOrdered(byChild: "id").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for snap in snapshot.children {
                let notesSnap = snap as! DataSnapshot
                let notesDict = notesSnap.value as! [String:AnyObject]
                let noteTaken = notesDict["note"] as! String
                
                for object in objects {
                    
                    if object == noteTaken {
                        print("Note Exists")
                    }
                    else {
                        print("Note doesn't exist - adding it to the Database")
                        // upload
                        let note = ["id":key,
                                    "note": object,
                                    "takenBy": Auth.auth().currentUser?.uid
                        ]
    
                        //adding the note inside the generated key
                        ref.child("notes").child(key).setValue(note)
                        
                    }
                }
            }

        })
    }
    
    func pullNotesFromFirebase() {
        print("SYNC - Pulling")
        //refresh the view based on the notes in Firebase
        var row = 0
        //self.tableView
        ref = Database.database().reference()
        objects = []
        tableView.reloadData()
        ref.child("notes").queryOrdered(byChild: "id").observe(.childAdded, with: { (snapshot) in
            let noteTakenBy = snapshot.childSnapshot(forPath: "takenBy").value as! String
            let signedInAs = Auth.auth().currentUser?.uid
            
            if noteTakenBy == signedInAs {
                if let valueDictionary = snapshot.value as? [AnyHashable:String] {
                    let title = valueDictionary["note"]
                    
                    objects.insert(title ?? "New Note", at: 0)
                    self.tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
                    self.tableView.reloadData()
                    row += row
                }
            }
            else {
                // do nothing because they aren't your notes
            }
        })
        row = 0
    }
    
}
