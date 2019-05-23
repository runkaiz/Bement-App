//
//  CatalogWebViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/23/19.
//  Copyright © 2019 Numeric Design. All rights reserved.
//

import UIKit
import WebKit

class CatalogWebViewController: UIViewController, WKUIDelegate {

    @IBOutlet var web: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        web = WKWebView(frame: .zero, configuration: webConfiguration)
        web.uiDelegate = self
        view = web
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
    
    func accessWeb(link: String) {
        let myURL = URL(string: link)
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
}
