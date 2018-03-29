//
//  WaveformView.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class WaveformView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var plotView: PlotView!
    @IBOutlet weak var title: UILabel!
    public var delegate: WaveformViewDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        fromNib()
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        delegate?.playButtonPressed(sender: sender)
    }
}

public protocol WaveformViewDelegate {
    func playButtonPressed(sender: UIButton)
}

extension UIView {
    @discardableResult
    public func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or its top view is of the wrong type
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll(to: self)
        return contentView
    }
    
    public func layoutAttachAll(to childView:UIView)
    {
        var constraints = [NSLayoutConstraint]()
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: childView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: childView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        childView.addConstraints(constraints)
    }
}
