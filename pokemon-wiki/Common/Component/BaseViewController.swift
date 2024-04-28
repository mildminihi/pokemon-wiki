//
//  BaseViewController.swift
//  pokemon-wiki
//
//  Created by Supanat Wanroj on 27/4/2567 BE.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true) {
            self.view.hideLoading()
        }
    }
}

extension UIView {
    public func showLoading() {
        let loadingView = PokeballLoading(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))

        loadingView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        loadingView.pokeballAnimation.play()
    }

    public func hideLoading() {
        let loadingViews = self.subviews.filter { ($0 as? PokeballLoading) != nil }
        loadingViews.forEach { $0.removeFromSuperview() }
    }
}
