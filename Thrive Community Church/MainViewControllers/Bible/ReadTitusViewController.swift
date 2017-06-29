//
//  ReadTitusViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 8/2/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadTitusViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var titusView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titusView.delegate = self
        loadTitusView()
    }
    
    private func loadTitusView(){
        let url = URL(string: "https://www.bible.com/bible/59/tit.1")
        let request = URLRequest(url: url!)
        
        titusView.loadRequest(request)
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
