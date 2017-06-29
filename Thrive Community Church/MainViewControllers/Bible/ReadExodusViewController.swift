//
//  ReadExodusViewController.swift
//  Thrive Community Church
//
//  Created by Wyatt Baggett on 7/14/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadExodusViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var exodusView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exodusView.delegate = self
        loadExodusView()
    }
    
    private func loadExodusView(){
        let url = URL(string: "https://www.bible.com/bible/59/exo.1")
        let request = URLRequest(url: url!)
        
        exodusView.loadRequest(request)
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
