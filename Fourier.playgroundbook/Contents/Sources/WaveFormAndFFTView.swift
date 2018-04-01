//
//  WaveFormAndFFTView.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/31/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

public class WaveFormAndFFTView: UIView {
    
    @IBOutlet public var view: UIView!
    @IBOutlet weak public var waveFormView: UIView!
    @IBOutlet weak public var plotView: PlotView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        fromNib()
    }
}
