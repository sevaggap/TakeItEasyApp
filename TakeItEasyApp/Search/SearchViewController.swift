//
//  SearchViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-14.
//

import UIKit
import WebKit

class SearchViewController: UIViewController {

    // when the view is loaded, the webpage Google will be displayed on the View using Webkit
    override func viewDidLoad() {
        super.viewDidLoad()
        let webKitView = WKWebView()
        let url = URL(string: "https://www.google.com/")!
        webKitView.load(URLRequest(url: url))
        view = webKitView
    }
    
}

