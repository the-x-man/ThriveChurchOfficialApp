//
//  OpenBiblePassageViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 6/21/18.
//  Copyright © 2018 Thrive Community Church. All rights reserved.
//

import UIKit

class OpenBiblePassageViewController: UIViewController {
	
	let webView: UIWebView = UIWebView()
	let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
	var link: String = ""
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		webView.translatesAutoresizingMaskIntoConstraints = false
		
		setupViews()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func setupViews() {
		
		view.addSubview(webView)
		self.setLoadingSpinner(spinner: spinner)
		view.addSubview(spinner)
		
		// webView then spinner view
		
		if #available(iOS 11.0, *) {
		NSLayoutConstraint.activate([
			webView.topAnchor.constraint(equalTo: view.topAnchor),
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
		} else {
			NSLayoutConstraint.activate([
				webView.topAnchor.constraint(equalTo: view.topAnchor),
				webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
		}
		
		// spinner
		NSLayoutConstraint.activate([
			spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			spinner.heightAnchor.constraint(equalToConstant: 40),
			spinner.widthAnchor.constraint(equalToConstant: 40)
		])
		
		if link != "" {
			webView.loadWebPage(url: link)
		}
		else {
			print("An error ocurred loading this webpage")
		}
	}
}
