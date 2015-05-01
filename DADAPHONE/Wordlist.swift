/*
Wordlist.swift
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

import Foundation

class Wordlist {
	var badwordArray: [String]? = nil
	var nounArray: [String]? = nil
	var verbArray: [String]? = nil
	var adverbArray: [String]? = nil
	var adjectiveArray: [String]? = nil
	
	init() {
		badwordArray = loadFile("badwords")
		nounArray = loadFile("91K nouns")
		verbArray = loadFile("31K verbs")
		adverbArray = loadFile("6K adverbs")
		adjectiveArray = loadFile("28K adjectives")
	}
	
	func loadFile(name: String) -> [String] {
		let path = NSBundle.mainBundle().pathForResource(name, ofType: "txt")
		let content = String(contentsOfFile:path!, encoding: NSUTF8StringEncoding, error: nil)
		return content!.componentsSeparatedByString("\r\n")
	}
	
	func randomWord(array: [String]) -> String {
		return array[Int(rand()) % array.count]
	}
	
	func randomSentence() -> String {
		var sentence: String = "The "
		sentence += randomWord(nounArray!)
		sentence += " "
		
		var adverb: String = "bla"
		do {
			adverb = randomWord(adverbArray!)
		} while (adverb[adverb.endIndex.predecessor()] != "y")

		var verb: String = "bla"
		do {
			verb = randomWord(verbArray!)
		} while (verb[verb.endIndex.predecessor()] != "s")

		var adjectiveprob: Float = Float(rand())/Float(INT32_MAX)
		if (adjectiveprob < 0.5) {
			sentence += randomWord(adjectiveArray!)
		}
		
		sentence += verb
		
		var adverbprob: Float = Float(rand())/Float(INT32_MAX)
		if (adverbprob < 0.5) {
			sentence += adverb
		}
		return sentence
	}
	
}