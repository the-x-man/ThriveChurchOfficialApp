//
//  ReadGalatiansViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadGalatiansViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var galView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galView.delegate = self
        loadGalView()
    }
    
    private func loadGalView(){
        let url = URL(string: "https://www.bible.com/bible/59/gal.1")
        let request = URLRequest(url: url!)
        
        galView.loadRequest(request)
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
