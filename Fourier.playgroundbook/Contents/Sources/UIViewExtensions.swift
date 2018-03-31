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
        fillSelfWith(subView: subView, inset: 0)
    }
    
    public func fillSelfWith(subView: UIView, inset: CGFloat) {
        fillSefWith(subView: subView, insetLeft: inset, insetRight: inset, insetTop: inset, insetBottom: inset)
    }
    
    public func fillSefWith(subView: UIView, insetLeft: CGFloat, insetRight: CGFloat, insetTop: CGFloat, insetBottom: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.topAnchor, constant: insetTop),
            subView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insetBottom),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insetLeft),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insetRight)
            ])
    }
    
    public func addAndCenterSubview(subView: UIView, subViewHeight height: CGFloat, horizontalInset inset: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subView.heightAnchor.constraint(equalToConstant: height),
            subView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            subView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset)
            ])
    }
}
