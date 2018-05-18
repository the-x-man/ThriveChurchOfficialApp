//
//  ViewControllerExtension.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 5/17/18.
//  Copyright © 2018 Thrive Community Church. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func setLoadingSpinner(spinner: UIActivityIndicatorView) {
		
		spinner.layer.cornerRadius = 4
		spinner.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255,
										  alpha: 0.75)
		spinner.color = .white
	}
	
	func displayAlertForAction() {
		let alert = UIAlertController(title: "Error",
									  message: "Unable to perform selected action",
									  preferredStyle: .alert)
		
		let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
		
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
	
}
