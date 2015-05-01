/*
MotionHandler.swift
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
import CoreMotion

class MotionHandler : NSObject {
	
	lazy var motionManager = CMMotionManager()
	
	var x : Double = 0.0
	var y : Double = 0.0
	var z : Double = 0.0
	var angle : Double = 0.0
	var stability: Double = 0.0
	
	var t: NSTimeInterval = NSDate().timeIntervalSince1970
	var f: Double = 0.05
	
	func addAccelerometerData(data: CMAccelerometerData!, dt: NSTimeInterval) {
		
		var oldXYZ = abs(x) + abs(y) + abs(z)
		
		x = f * data.acceleration.x + x * (1.0 - f)
		y = f * data.acceleration.y + y * (1.0 - f)
		z = f * data.acceleration.z + z * (1.0 - f)
		
		angle = atan2(y,x)
		
		var newXYZ = abs(x) + abs(y) + abs(z)
		stability = (f * abs(oldXYZ-newXYZ) + stability * (1.0 - f))
	}
	
	override init() {
		super.init()
		if motionManager.accelerometerAvailable{
			let queue = NSOperationQueue()
			motionManager.startAccelerometerUpdatesToQueue(queue, withHandler:
				{(data: CMAccelerometerData!, error: NSError!) in
				
					var tt: NSTimeInterval = NSDate().timeIntervalSince1970
					var dt: NSTimeInterval = tt - self.t
					self.t = tt
					
					self.addAccelerometerData(data, dt: dt)
				}
			)
		}
	}
}
