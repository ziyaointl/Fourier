/*:
 Take this sound produced by a piano as an example
 
 It has the same pitch as the first pure tone you saw, 'A' or 440Hz.
 
 Notice how the sound wave is more jagged compared to the pure tone. This appearance indicates that it is a complex tone.
 
 How can we decompose this complex tone into its pure tone components?
 
 For this, we will need Fourier transform.
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let mainView = UIView()
let pianoNoteViewController = PianoNoteViewController()
mainView.addAndCenterSubview(subView: pianoNoteViewController.view, subViewHeight: Constants.Table.RowHeight, horizontalInset: 30)
mainView.backgroundColor = Constants.Colors.LightGray
PlaygroundPage.current.liveView = mainView
//#-end-hidden-code
