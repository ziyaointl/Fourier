/*:
 Here are a few sound waves with different frequencies. Click on the play button to hear what they each sounds like.
 
 Notice how the pitch of those waves are different. In general, the higher the frequency, the higher the pitch.
 
 Now it's your turn! Create or modify sound waves using createWave(withFrequency:)
 
(It is helpful to note that the hearing range for humans is approximately from 20Hz to 20,000Hz)
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

let waveformTableViewController = WaveformTableViewController()
func createWave(withFrequency frequency: Int) {
    waveformTableViewController.addWaveForm(withFrequency: frequency)
}
PlaygroundPage.current.liveView = waveformTableViewController
//#-end-hidden-code
//#-editable-code
createWave(withFrequency: 440)
createWave(withFrequency: 880)
createWave(withFrequency: 1320)
//#-end-editable-code
