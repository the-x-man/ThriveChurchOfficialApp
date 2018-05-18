//
//  MoreViewController.swift
//  Thrive Community Church
//
//  Created by Wyatt Baggett on 6/3/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import Foundation
import UIKit

class WebsiteViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var websiteView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websiteView.delegate = self
        loadWebsiteView()
        self.setLoadingSpinner(spinner: loading)
    }
    
    private func  loadWebsiteView() {
        let url = URL(string: "http://thrive-fl.org")
        let request = URLRequest(url: url!)
        
        websiteView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.startAnimating()
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        
    }
    
}
