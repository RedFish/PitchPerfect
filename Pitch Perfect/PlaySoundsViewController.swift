//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Richard Guerci on 07/05/2015.
//  Copyright (c) 2015 Richard Guerci. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
	
	@IBOutlet weak var stopButton: UIButton!
	
	var audioPlayer:AVAudioPlayer!
	var receivedAudio:RecordedAudio!
	var audioEngine:AVAudioEngine!
	var audioFile:AVAudioFile!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if var filePath = receivedAudio.filePathUrl /* NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3")*/ {
			audioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: nil)
			audioPlayer.enableRate = true
			audioPlayer.delegate = self
			audioEngine = AVAudioEngine()
			audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
		}
		else{
			println("Error filePath")
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		//hide elements
		stopButton.hidden = true
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func playSlowAction(sender: UIButton) {
		audioPlayer.stop()
		audioPlayer.rate = 0.5
		audioPlayer.play()
		stopButton.hidden = false
	}
	
	@IBAction func playFastAction(sender: UIButton) {
		audioPlayer.stop()
		audioPlayer.rate = 2.0
		audioPlayer.play()
		stopButton.hidden = false
	}
	
	@IBAction func playChipmunkAction(sender: UIButton) {
		playAudioWithVariablePitch(1000)
	}
	
	@IBAction func playDarthVadorAction(sender: UIButton) {
		playAudioWithVariablePitch(-1000)
	}
	
	@IBAction func stopAction(sender: UIButton) {
		audioPlayer.stop()
		audioPlayer.currentTime = 0.0
		stopButton.hidden = true
	}
	
	func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
		stopButton.hidden = true
	}
	
	func playAudioWithVariablePitch(pitch: Float){
		audioPlayer.stop()
		audioEngine.stop()
		audioEngine.reset()
		
		var pitchPlayerNode = AVAudioPlayerNode()
		audioEngine.attachNode(pitchPlayerNode)

		var timePitch = AVAudioUnitTimePitch()
		timePitch.pitch = pitch
		audioEngine.attachNode(timePitch)
		
		audioEngine.connect(pitchPlayerNode, to: timePitch, format: nil)
		audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
		
		pitchPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
		audioEngine.startAndReturnError(nil)
		
		pitchPlayerNode.play()
	}
}
