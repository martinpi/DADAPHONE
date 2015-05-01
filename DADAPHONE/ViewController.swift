/*
ViewController.swift
DADAPHONE

Created by Martin Pichlmair on 04.29.15.
Copyright (c) 2015 Broken Rules. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

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

