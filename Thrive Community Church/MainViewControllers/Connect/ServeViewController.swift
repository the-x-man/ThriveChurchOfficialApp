//
//  ServeViewController.swift
//  Thrive Community Church
//
//  Created by Wyatt Baggett on 6/21/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import Foundation
import UIKit

class ServeViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var serveWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serveWebView.delegate = self
        loadServeView()
        self.setLoadingSpinner(spinner: loading)
    }
    
    private func loadServeView() {
        let url = URL(string: "http://thrive-fl.org/get-involved/")
        let request = URLRequest(url: url!)
        
        serveWebView.loadRequest(request)
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
