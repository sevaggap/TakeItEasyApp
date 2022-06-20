//
//  WebUIKit.swift
//  TakeItEasyApp
//
//  Created by Zahid Merchant on 2022-06-20.
//

import Foundation
import WebKit



class WebUIKit: UIViewController {
    
    var bookLink : String?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let webKitView = WKWebView(frame: view.bounds)
        let newUrl = URL(string: bookLink!)
        webKitView.load(URLRequest(url: newUrl!))
        view = webKitView
    }

}
