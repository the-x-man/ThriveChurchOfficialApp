//
//  Read2CorinthiansViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/1/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class Read2CorinthiansViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var corView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        corView.delegate = self
        corView.loadWebPage(url: "https://www.bible.com/bible/59/2co.1")
        self.setLoadingSpinner(spinner: loading)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.startAnimating()
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        
    }
    
}
