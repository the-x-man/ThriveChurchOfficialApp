//
//  ReadHebrewsViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadHebrewsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var hebrewsView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hebrewsView.delegate = self
        loadHebrewsView()
    }
    
    private func loadHebrewsView(){
        let url = URL(string: "https://www.bible.com/bible/59/heb.1")
        let request = URLRequest(url: url!)
        
        hebrewsView.loadRequest(request)
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
