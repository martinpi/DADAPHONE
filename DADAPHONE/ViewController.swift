//
//  ViewController.swift
//  VICTORIA
//
//  Created by Martin Pichlmair on 04.29.15.
//  Copyright (c) 2015 Broken Rules. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
	lazy var motionHandler: MotionHandler = MotionHandler()
	var speechsynt: AVSpeechSynthesizer = AVSpeechSynthesizer() //initialize the synthesizer
	let worldlist: Wordlist = Wordlist()
	var pressed: Bool = false
	
	func speak(speechString : String) {
		var nextSpeech:AVSpeechUtterance = AVSpeechUtterance(string: speechString)
		nextSpeech.rate = AVSpeechUtteranceMinimumSpeechRate; // some Configs :-)
		speechsynt.speakUtterance(nextSpeech) //let me Speak!
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		var beforeSpeechString : String = " "
		var beforeSpeech:AVSpeechUtterance = AVSpeechUtterance(string: beforeSpeechString)
		speechsynt.delegate = self
		speechsynt.speakUtterance(beforeSpeech)
		
		srand(UInt32(NSDate().timeIntervalSinceReferenceDate))

	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func utter() {
		speak(worldlist.randomSentence())
	}
	func swear() {
		speak(worldlist.randomWord(worldlist.badwordArray!))
	}
	
	@IBAction func experience(sender: AnyObject) {
		if !speechsynt.speaking {
			utter()
		}
		pressed = true
	}
	@IBAction func unexperience(sender: AnyObject) {
		pressed = false
	}
	
	func speechSynthesizer( synthesizer: AVSpeechSynthesizer!,
		didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
			
		if (pressed) {
			if (motionHandler.stability > 0.05) {
				swear()
			} else {
				utter()
			}
		}
	}


}

