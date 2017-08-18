//
//  ReadRuthViewController.swift
//  Thrive Church Official App
//
//  Created by Wyatt Baggett on 7/31/16.
//  Copyright © 2016 Thrive Community Church. All rights reserved.
//

import UIKit

class ReadRuthViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet var ruthView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ruthView.delegate = self
        loadJudgesView()
    }
    
    private func loadJudgesView(){
        let url = URL(string: "https://www.bible.com/bible/59/rut.1")
        let request = URLRequest(url: url!)
        
        ruthView.loadRequest(request)
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