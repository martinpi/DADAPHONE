//
//  MotionHandler.swift
//  F0T0
//
//  Created by Martin Pichlmair on 04.14.15.
//  Copyright (c) 2015 Sunset Lake Software. All rights reserved.
//

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
