//
//  ReadThessaloniansViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadThessaloniansViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var thView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thView.delegate = self
        thView.loadWebPage(url: "https://www.bible.com/bible/59/1th.1")
        self.setLoadingSpinner(spinner: loading)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.startAnimating()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        
    }
    
}
