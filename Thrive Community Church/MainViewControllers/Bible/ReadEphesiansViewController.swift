//
//  ReadEphesiansViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadEphesiansViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var ephView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ephView.delegate = self
        loadEphView()
        self.setLoadingSpinner(spinner: loading)
    }
    
    private func loadEphView() {
        let url = URL(string: "https://www.bible.com/bible/59/eph.1")
        let request = URLRequest(url: url!)
        
        ephView.loadRequest(request)
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
