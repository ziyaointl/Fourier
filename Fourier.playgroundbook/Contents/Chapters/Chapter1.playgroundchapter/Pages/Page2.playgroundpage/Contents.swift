/*:
 Sound waves are vibrations traveling through air like ripples traveling through water. When an object vibrates, it compresses and decompresses the air around it, creating a sound.
 
 On the execution result screen, you can see a simple sound wave.
 
 The horizontal axis shows time, while the vertical axis shows the relative pressure of the air
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let mainView = UIView()
let plotView = PlotView()
mainView.backgroundColor = Constants.Colors.LightGray
plotView.backgroundColor = Constants.Colors.LightGray
plotView.includeNegativeYAxis = true
plotView.contentMode = .redraw
plotView.currentFunction = FunctionGenerator.generateSineForPlotting(withFrequency: 440)
mainView.addAndCenterSubview(subView: plotView, subViewHeight: Constants.Table.RowHeight, horizontalInset: 20)
PlaygroundPage.current.liveView = mainView

//Animate plotView
let animationBlock: () -> Void = {
    plotView.offset += 5 * .pi
}
func animate() {
    UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: animationBlock, completion: { _ in
        animate()
    })
    
}
DispatchQueue.main.async {
    animate()
}
//#-end-hidden-code

