//
//  AuthViewController.swift
//  digai
//
//  Created by Jacqueline Alves Barbosa on 03/04/22.
//

import UIKit
import WebKit
/*
class SpotifySignInViewController: UIViewController {
    
    private let webview: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.scrollView.showsVerticalScrollIndicator = false
        webview.scrollView.showsHorizontalScrollIndicator = false
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    public var completionHandler: (Bool) -> Void = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(webview)
        
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            webview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        webview.navigationDelegate = self
        
        guard let url = SpotifyManager.shared.signInURL else { return }
        webview.load(URLRequest(url: url))
    }
}

extension SpotifySignInViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url,
              let components = URLComponents(string: url.absoluteString),
              let code = components.queryItems?.first(where: { $0.name == "code" })?.value else { return }
                
        SpotifyManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.dismiss(animated: true) {
                    self?.completionHandler(success)
                }
            }
        }
    }
}
*/
