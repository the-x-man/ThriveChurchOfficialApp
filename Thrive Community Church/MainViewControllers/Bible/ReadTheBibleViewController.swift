//
//  Read1JohnViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadTheBibleViewController: UIViewController, UIPickerViewDelegate,
													UIPickerViewDataSource {
	
	
    
	@IBOutlet weak var bookPicker: UIPickerView!
	var bookData: [String] = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bookPicker.delegate = self
		bookPicker.dataSource = self
		
		// API request to get the books in the bible -- Creating a large array
		// like this in code seems a little wasteful and time consuming
		// Will look into POSTMAN
		bookData = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
			"Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings",
			"2 Kings","1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah",
			"Esther","Job","Psalm","Proverbs","Ecclesiastes","Song of Solomon",
			"Isaiah","Jeremiah","Lamentations","Ezekiel","Daniel","Hosea","Joel",
			"Amos","Obadiah","Jonah","Micah","Nahum","Habakkuk","Zephaniah","Haggai",
			"Zechariah","Malachi"]
		

    }
    
//    private func loadJohnView() {
//        let url = URL(string: "https://www.bible.com/bible/59/1jn.1")
//        let request = URLRequest(url: url!)
//
//        johnView.loadRequest(request)
//    }
//
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent
												component: Int) -> Int {
		return bookData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
												forComponent component: Int) -> String? {
		return bookData[row]
	}
	
	// might not be needed if we are using a button to submit but will be useful
	// to test to see how many chapters there are in a book
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
											  inComponent component: Int) {
		let selectedBook = bookData[row]
	}
	
}
