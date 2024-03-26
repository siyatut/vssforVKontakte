//
//  ExtensionUIViews.swift
//  vssforVKontakte
//
//  Created by Anastasia Tyutinova on 26/3/2567 BE.
//

import UIKit

extension UIView {
    
    func addViews(_ views: [UIView]) {
        for view in views {
            addViews(view)
        }
    }
    
    func addViews(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
