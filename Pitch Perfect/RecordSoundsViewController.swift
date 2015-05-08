//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Richard Guerci on 06/05/2015.
//  Copyright (c) 2015 Richard Guerci. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	
	//Declared Globally
	@IBOutlet weak var recordingInProgress: UILabel!
	@IBOutlet weak var stopButton: UIButton!
	@IBOutlet weak var recordButton: UIButton!
	
	var audioRecorder:AVAudioRecorder!
	var recordedAudio:RecordedAudio!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		//hide elements
		recordingInProgress.hidden = true
		stopButton.hidden = true
		recordButton.enabled = true
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func recordAction(sender: UIButton) {
		//unhide label
		recordingInProgress.hidden = false
		stopButton.hidden = false
		recordButton.enabled = false
		println("recordAction")
		
		//Get path of the app + set audio name
		let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
		let currentDateTime = NSDate()
		let formatter = NSDateFormatter()
		formatter.dateFormat = "ddMMyyyy-HHmmss"
		let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
		let pathArray = [dirPath, recordingName]
		let filePath = NSURL.fileURLWithPathComponents(pathArray)
		println(filePath)
		
		var session = AVAudioSession.sharedInstance()
		session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
		
		//Start recording
		audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
		audioRecorder.delegate = self // change delegate to implement audioRecorderDidFinishRecording
		audioRecorder.meteringEnabled = true
		audioRecorder.record()
	}

	@IBAction func stopAction(sender: UIButton) {
		println("stopAction")
		//Stop recording user's voice
		audioRecorder.stop()
		var audioSession = AVAudioSession.sharedInstance()
		audioSession.setActive(false, error: nil)
	}
	
	func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
		if flag {
			//save recorded audio
			recordedAudio = RecordedAudio()
			recordedAudio.filePathUrl = recorder.url
			recordedAudio.title = recorder.url.lastPathComponent
			//perform segue
			self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
		}
		else{
			println("Error recording")
			recordingInProgress.hidden = true
			stopButton.hidden = true
			recordButton.enabled = true
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "stopRecording"{
			let playSoundVC:PlaySoundsViewController =  segue.destinationViewController as! PlaySoundsViewController
			let data = sender as! RecordedAudio
			playSoundVC.receivedAudio = data
		}
	}
}

