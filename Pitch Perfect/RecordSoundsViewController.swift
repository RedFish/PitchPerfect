//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Richard Guerci on 06/05/2015.
//  Copyright (c) 2015 Richard Guerci. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

	@IBOutlet weak var recordingInProgress: UILabel!
	@IBOutlet weak var stopButton: UIButton!
	@IBOutlet weak var recordButton: UIButton!
	
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
	}

	@IBAction func stopAction(sender: UIButton) {
		println("stopAction")
	}
}

