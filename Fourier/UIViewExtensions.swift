//
//  UIViewExtensions.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    @discardableResult
    public func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil // xib not loaded, or its top view is of the wrong type
        }
        self.fillSelfWith(subView: contentView)
        return contentView
    }
    
    public func fillSelfWith(subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
}
