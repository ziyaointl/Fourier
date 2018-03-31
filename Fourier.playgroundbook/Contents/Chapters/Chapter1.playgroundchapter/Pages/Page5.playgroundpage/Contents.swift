/*:
 All sound waves above are made of single sine waves, albeit with different wavelengths. Sound waves made of sine or cosine functions are called pure tones.
 
 Pure tones don't sound natural at all because they don't appear in nature.
 
 What appears in nature are called complex tones, tones that are composed of pure tones of different frequencies and amplitudes.
 */
//#-hidden-code
import PlaygroundSupport

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
