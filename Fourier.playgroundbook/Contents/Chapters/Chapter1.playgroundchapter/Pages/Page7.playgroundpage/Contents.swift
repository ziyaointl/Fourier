/*:
 Fourier Transform is a mathematical tool that takes in time vs. displacement data and converts it to the different component frequencies that make up the data.
 
 In other words, Fourier Transform allows us to see what combinations of pure tones make up a complex tone.
 
 Here's the equation of Fourier Transform. For what it does, it is surprisingly short and elegant.
 
 You can now marvel at its magnificence. Feel free to flip to the next page once you've done so.
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let mainView = UIView()
mainView.backgroundColor = Constants.Colors.LightGray
let imageView = UIImageView(image: Constants.Resources.EquationImage)
imageView.contentMode = .scaleAspectFit
mainView.fillSelfWith(subView: imageView, inset: 50)
PlaygroundPage.current.liveView = mainView
//#-end-hidden-code
