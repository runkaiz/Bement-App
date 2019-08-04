//
//  CatalogWebViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/23/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import WebKit

class CatalogWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet var web: WKWebView!
    @objc func canRotate() -> Void {}
    var activityIndicator: UIActivityIndicatorView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        web = WKWebView(frame: .zero, configuration: webConfiguration)
        web.navigationDelegate = self
        web.uiDelegate = self
        view = web
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.hidesWhenStopped = true
        let barButton = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch globalVariable.catalogGrade {
        case "Kindergarten":
            self.title = catalog.Gradek3[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Gradek3[globalVariable.row]]!)
        case "Grade 1":
            self.title = catalog.Gradek3[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Gradek3[globalVariable.row]]!)
        case "Grade 2":
            self.title = catalog.Gradek3[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Gradek3[globalVariable.row]]!)
        case "Grade 3":
            self.title = catalog.Gradek3[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Gradek3[globalVariable.row]]!)
        case "Grade 4":
            self.title = catalog.Grade45[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Grade45[globalVariable.row]]!)
        case "Grade 5":
            self.title = catalog.Grade45[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Grade45[globalVariable.row]]!)
        case "Grade 6":
            self.title = catalog.Grade6[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Grade6[globalVariable.row]]!)
        case "Grade 7":
            self.title = catalog.Grade789[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Grade789[globalVariable.row]]!)
        case "Grade 8 & 9":
            self.title = catalog.Grade789[globalVariable.row]
            accessWeb(link: catalog.links[catalog.Grade789[globalVariable.row]]!)
        default:
            print("This should not happen!")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
    
    func accessWeb(link: String) {
        let myURL = URL(string: link)
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            // Start the loading animation
            activityIndicator.startAnimating()
        } else {
            // Stop the loading animation
            activityIndicator.stopAnimating()
        }
    }
    
    //MARK:- WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        showActivityIndicator(show: false)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        if userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
        }
    }
}
