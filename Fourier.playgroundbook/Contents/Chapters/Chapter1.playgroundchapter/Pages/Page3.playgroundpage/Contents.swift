/*:
 Notice how this wave repeats itself. The number of repetitions per second is called the wave's frequency.
 
 Frequencies are measured in Hz. A 10 Hz wave undergoes the same pattern of oscillation 10 times per second.
 
 The sound wave you just saw has a frequency 440Hz, meaning that it oscillates back and forth 440 times per second.
 
 Click on the play button to hear how it sounds!
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let mainView = UIView()
let waveFormViewController = WaveformViewController()
waveFormViewController.mediaType = .frequency(440)
waveFormViewController.titleText = String(440) + " Hz"
waveFormViewController.currentFunction = FunctionGenerator.generateSineForPlotting(withFrequency: 440)
mainView.addAndCenterSubview(subView: waveFormViewController.view, subViewHeight: Constants.Table.RowHeight, horizontalInset: 20)
mainView.backgroundColor = Constants.Colors.LightGray
PlaygroundPage.current.liveView = mainView
//#-end-hidden-code
