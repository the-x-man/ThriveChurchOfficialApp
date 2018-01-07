//
//  Read1JohnViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit
import Foundation

class ReadTheBibleViewController: UIViewController, UIPickerViewDelegate,
													UIPickerViewDataSource {
	
	@IBOutlet weak var bookPicker: UIPickerView!
	@IBOutlet weak var chapterPicker: UIPickerView!
	var bookData: [String] = [String]()
	var chapterData: [Int] = [Int]()
	var selectedBook: String!
	var numOfChaptersInBook: Int!
	
	let jsonResponse = """
	{
	  "query": "Genesis 1:1",
	  "canonical": "Genesis 1:1",
	  "passages": [
		"\nGenesis 1:1\n\n\nThe Creation of the World\n\n[1] In the beginning, God created the heavens and the earth. (ESV)"
	  ]
	}
	""".data(using: .utf8)!
	
	
	// structure from the ESV API return
	// using https://api.esv.org/v3/passage/text/?q=
	
	struct Scripture: Decodable {
		var index: String
	}
	
	struct Passage: Decodable {
		var query: String?
		var canonical: String
		var passages: [Scripture] // array of strings. Each string is a passage
	}
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		bookPicker.delegate = self
		bookPicker.dataSource = self
		chapterPicker.delegate = self
		chapterPicker.dataSource = self
		
		// API request to get the books in the bible -- Creating a large array
		// like this in code seems a little wasteful and time consuming
		// Will look into POSTMAN & AWS API Gateway and see which might be better
		bookData = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy",
			"Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings",
			"2 Kings","1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah",
			"Esther","Job","Psalm","Proverbs","Ecclesiastes","Song of Solomon",
			"Isaiah","Jeremiah","Lamentations","Ezekiel","Daniel","Hosea","Joel",
			"Amos","Obadiah","Jonah","Micah","Nahum","Habakkuk","Zephaniah","Haggai",
			"Zechariah","Malachi", "Matthew", "Mark", "Luke",
			"John","Acts","Romans","1 Corinthians","2 Corinthians","Galatians",
			"Ephesians","Philippians", "Colossians","1 Thessalonians","2 Thessalonians",
			"1 Timothy","2 Timothy","Titus","Philemon","Hebrews","James","1 Peter",
			"2 Peter","1 John","2 John","3 John","Jude","Revelation"]
		
		// create a map or similar to match the book with the # of chapters?
		// might be useful as part of the API ep aw well
		
		
		// init of the first 50 chapters of genesis
		numOfChaptersInBook = 50
		for i in 1...numOfChaptersInBook {
			chapterData.append(i)
		}
		
		//fetchJSON()
		//atteptToConnectToESV()
//		simplifyJSON()
		
//		do {
//			let decoder = JSONDecoder()
//			let response = try decoder.decode([Passage].self, from: jsonResponse)
//			print(response)
//		} catch let error {
//			print(error)
//		}
	
    }
	
//	func simplifyJSON() {
//
//		let decoder = JSONDecoder()
//		do {
//			let passages = try decoder.decode(Passage.self, from: jsonResponse)
//
//			print("The following products are available:")
//
//			print("\t(\(passages.query) query)")
//			if let canonical = passages.canonical {
//				print("\t\t\(canonical)")
//			}
//
//		}
//		catch {
//			print("Whoops somehting went wrong!")
//		}
//
//
//	}
	
//	func fetchJSON() {
//
//		// credentials encoded in base64
//		let authentication = "Token 82f830e656366c954a0ff09dbadc2b61ae583a3f"
//		let authString = String(format: "%@", authentication)
//		let authData = authString.data(using: String.Encoding.utf8)!
//		let base64AuthString = authData.base64EncodedString()
//
//		// create the request
//		let url = URL(string: "http://www.example.com/")!
//		var request = URLRequest(url: url)
//		request.httpMethod = "POST"
//		request.setValue("Basic \(base64AuthString)", forHTTPHeaderField: "Authorization")
//
//		let jsonURLString = "https://api.esv.org/v3/passage/text/?q=Genesis%201"
//
//	}
	
//	func atteptToConnectToESV() {
//
//		// credentials encoded in base64
//		let authentication = "Token 82f830e656366c954a0ff09dbadc2b61ae583a3f"
//
//		let authString = String(format: "%@:%@", authentication)
//		let authData = authString.data(using: String.Encoding.utf8)!
//		let base64AuthString = authData.base64EncodedString()
//
//		// create the request
//		let url = URL(string: "http://www.example.com/")!
//		var request = URLRequest(url: url)
//		request.httpMethod = "POST"
//		request.setValue("Basic \(base64AuthString)", forHTTPHeaderField: "Authorization")
//
//		//making the request
//		URLSession.shared.dataTask(with: request) { data, response, error in
//			guard let data = data, error == nil else {
//
//				print("\(String(describing: error))")
//				return
//			}
//			//print("Data = \(data)")
//
//			if let httpStatus = response as? HTTPURLResponse {
//				// check status code returned by the http server
//				print("status code = \(httpStatus.statusCode)")
//				print(response ?? "")
//			}
//		}.resume()
//	}
	
	func getNumOfChapters() {
		print("getting chapters")
		chapterData = []
		
		numOfChaptersInBook = 20
		
		for i in 1...numOfChaptersInBook {
			chapterData.append(i)
		}
		// reload the view to make sure that the user can't have higher than the
		// new highest chapter number selected - prevents out of bounds exception
		chapterPicker.reloadAllComponents()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent
												component: Int) -> Int {
		
		if pickerView == bookPicker {
			return bookData.count
		}
		else if pickerView == chapterPicker {
			return chapterData.count
		}
		else {
			return 1
		}
		
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
												forComponent component: Int) -> String? {
		
		if pickerView == bookPicker {
			return bookData[row]
			
		}
		else if pickerView == chapterPicker {
			return String(describing: chapterData[row])
		}
		else {
			return "-"
		}
		
	}
	
	// might not be needed if we are using a button to submit but will be useful
	// to test to see how many chapters there are in a book
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
											  inComponent component: Int) {
		
		if pickerView == bookPicker {
			print("Book: \(bookData[row])")
			selectedBook = bookData[row]
			getNumOfChapters()
		}
		else if pickerView == chapterPicker {
			print("Chapter: \(chapterData[row])")
		}
		else {
			// do nothing
		}
	}
}


