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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if var filePath = receivedAudio.filePathUrl /* NSBundle.mainBundle().URLForResource("movie_quote", withExtension: "mp3")*/ {
			audioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: nil)
			audioPlayer.enableRate = true
			audioPlayer.delegate = self
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
	
	@IBAction func stopAction(sender: UIButton) {
		audioPlayer.stop()
		audioPlayer.currentTime = 0.0
		stopButton.hidden = true
	}
	
	func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
		stopButton.hidden = true
	}
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
