/*:
 Above are two graphs showing the input and the output of a Fourier transform done on a pure tone with a frequency of 440Hz
 
 Notice the single spike shown in the output. This indicates that the original signal is made up of a single pure wave with a frequency of 440Hz.
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let mainView = UIView()
let viewController = WaveFormAndFFTViewController()
viewController.mediaType = .frequency(440)
mainView.addAndCenterSubview(subView: viewController.view, subViewHeight: Constants.ViewHeight.WaveFormAndFFTView, horizontalInset: 30)
mainView.backgroundColor = Constants.Colors.LightGray
PlaygroundPage.current.liveView = mainView
//#-end-hidden-code
