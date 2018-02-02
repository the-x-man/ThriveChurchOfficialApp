//
//  ReadObediahViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/1/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadObediahViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var obadiahView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        obadiahView.delegate = self
        loadObediahView()
    }
    
    private func loadObediahView() {
        let url = URL(string: "https://www.bible.com/bible/59/oba.1")
        let request = URLRequest(url: url!)
        
        obadiahView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.startAnimating()
        print("Loading....")
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        print("Stopped Loading!")
    }
    
}