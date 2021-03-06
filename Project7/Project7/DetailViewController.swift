//
//  DetailViewController.swift
//  Project7
//
//  Created by John Doll on 5/19/22.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <strong>
        \(detailItem.body)
        </strong>
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}
