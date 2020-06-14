//
//  ServeViewController.swift
//  Thrive Community Church
//
//  Created by Wyatt Baggett on 6/21/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import WebKit
import UIKit

class ServeViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let serveWebView: WKWebView = {
		let view = WKWebView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serveWebView.uiDelegate = self
		serveWebView.navigationDelegate = self
		
		view.insertSubview(serveWebView, at: 0)
		NSLayoutConstraint.activate([
			serveWebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			serveWebView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			serveWebView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			serveWebView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
		])
		
		let url = URL(string: "http://thrive-fl.org/get-involved/")!
		let request = URLRequest(url: url)
		serveWebView.load(request)
		
        self.setLoadingSpinner(spinner: loading)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		loading.stopAnimating()
	}
	
	func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
		loading.startAnimating()
	}
    
}
