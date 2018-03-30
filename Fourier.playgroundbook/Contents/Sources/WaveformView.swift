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
