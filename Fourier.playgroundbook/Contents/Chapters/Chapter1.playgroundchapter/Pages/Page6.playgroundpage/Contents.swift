/*:
 Take this sound produced by a piano as an example
 
 It has the same pitch as the first pure tone you saw, 'A4' or 440Hz.
 
 Notice how the sound wave is more irregular than the pure tone. This appearance indicates that it is a complex tone.
 
 **Pro Tip:** You can pause the audio in the middle of the note to observe the shape of the sound wave
 
 How can we decompose this complex tone into its pure tone components?
 
 For this, we will need the Fourier Transform.
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
