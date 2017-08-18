//
//  Read2JohnViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class Read2JohnViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var johnView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        johnView.delegate = self
        loadJohnView()
    }
    
    private func loadJohnView(){
        let url = URL(string: "https://www.bible.com/bible/59/2jn.1")
        let request = URLRequest(url: url!)
        
        johnView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidStartLoad(_ Webview: UIWebView) {
        loading.startAnimating()
        print("Loading....")
        
    }
    
    func webViewDidFinishLoad(_ Webview: UIWebView) {
        loading.stopAnimating()
        print("Stopped Loading!")
    }
}