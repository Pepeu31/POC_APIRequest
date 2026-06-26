//
//  SVGModel.swift
//  CheckInGuesser
//
//  Created by Pedro Henrique L. Moreiras on 26/01/26.
//

import Foundation
import SwiftUI
import WebKit

/// Creates a Model of the Image From API
@Observable
class SVGModel: NSObject, WKNavigationDelegate {
    public var isLoading: Bool = false
    public var image: UIImage?
    
    private var webView: WKWebView?
    private var targetSize: CGSize = .zero
    
    @MainActor
    public func fetch(from url: URL, size: CGSize = CGSize(width: 150, height: 150)) {
        self.targetSize = size
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.startWebViewRender(data: data)
            }
        }.resume()
    }
    
    /// Make the Images appear from API (Rendering)
    @MainActor
    private func startWebViewRender(data: Data) {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: CGRect(origin: .zero, size: targetSize), configuration: config)
        
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.backgroundColor = .clear
        self.webView = webView
        
        guard let svgString = String(data: data, encoding: .utf8) else { return }
        let htmlString = """
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
                <style>
                    body, html {
                        margin: 0;
                        padding: 0;
                        width: 100%;
                        height: 100%;
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        overflow: hidden;
                        background-color: transparent;
                    }
                    svg {
                        width: 100%;
                        height: 100%;
                    }
                </style>
            </head>
            <body>
                \(svgString)
            </body>
            </html>
            """
        
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    /// Function that Shows the Images
    @MainActor
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let snapshotConfig = WKSnapshotConfiguration()
        snapshotConfig.rect = CGRect(origin: .zero, size: targetSize)
        
        webView.takeSnapshot(with: snapshotConfig) { [weak self] image, error in
            self?.image = image
            self?.isLoading = false
            self?.webView = nil
        }
    }
}
