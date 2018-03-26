//
//  TestViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/26/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var plotView: PlotView!
    override func viewDidLoad() {
        super.viewDidLoad()
        plotView.includeNegativeYAxis = true
        plotView.contentMode = .redraw
        plotView.currentFunction = {x in
            let x = 0.1 * x
            return sin(x) * 50
        }
    }

    @IBAction func animatePlot(_ sender: UIButton) {
        UIView.animate(withDuration: 10, animations: {[weak self] in
            self?.plotView.offset += 2000})
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
