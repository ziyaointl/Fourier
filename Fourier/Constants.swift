//
//  Constant.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import UIKit

public struct Constants {
    public struct ViewHeight {
        public static let WaveFormAndFFTView: CGFloat = 280.0
    }
    
    public struct Table {
        public static let RowHeight: CGFloat = 126.0
    }
    
    public struct Colors {
        public static let LightGray = #colorLiteral(red: 0.9599999785, green: 0.9599999785, blue: 0.9599999785, alpha: 1)
        public static let DarkGray = #colorLiteral(red: 0.3600000143, green: 0.3600000143, blue: 0.3600000143, alpha: 1)
    }
    
    public struct Resources {
        public static let PianoNoteURL = Bundle.main.url(forResource: "Piano A4", withExtension: ".m4a")!
        public static let EquationImage = #imageLiteral(resourceName: "equation.png")
    }
    
    public struct StringLiterals {
        public static let PianoA4 = "Grand Piano 440Hz (A4)"
    }
}
