//
//  RepoWebViewController.swift
//  Github-Search-App
//
//  Created by sanket kumar on 01/08/19.
//  Copyright © 2019 sanket kumar. All rights reserved.
//

import UIKit
import WebKit
import ProgressHUD

class RepoWebViewController: UIViewController, WKNavigationDelegate {
    
    let webView : WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    var repoUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpViews()
        loadWebPage()
        
    }

    fileprivate func setUpViews() {
        view.addSubview(webView)
        webView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        webView.navigationDelegate = self
    }
    
    fileprivate func loadWebPage() {
        guard let urlString = repoUrl else {
            ProgressHUD.showError("Can't load the empty url...")
            return
        }
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ProgressHUD.show("Please Wait...")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ProgressHUD.showError(error.localizedDescription)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProgressHUD.dismiss()
    }
    
}
