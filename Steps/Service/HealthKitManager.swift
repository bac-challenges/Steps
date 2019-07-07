//	MIT License
//
//	Copyright © 2019 Emile, Blue Ant Corp
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//
//	ID: 46643E7F-889F-4104-BEA6-475DF7F1FCBC
//
//	Pkg: Steps
//
//	Swift: 4.2
//
//	MacOS: 10.15
//

import Foundation
import HealthKit

struct HealthKitManager {
	
	public static let shared = HealthKitManager()
	
	private let healthStore = HKHealthStore()
	
	func checkHealthDataAvailable() {
		if HKHealthStore.isHealthDataAvailable() {
			let allTypes = Set([HKObjectType.workoutType(), HKObjectType.quantityType(forIdentifier: .stepCount)!])
			healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
				if !success {
					print(error.debugDescription)
				}
				
				self.readSampleSteps { steps in
					print("Boom!!! \(steps)")
				}
			}
		}
	}
	
	// Read steps from HKHealthStore
	public func readSteps(start: Date, end: Date, completion: @escaping (Double) -> ()) {
		if let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) {
			let predicate = HKQuery.predicateForSamples(withStart: start,
														end: end,
														options: .strictStartDate)
			
			let query = HKStatisticsQuery(quantityType: stepsQuantityType,
										  quantitySamplePredicate: predicate,
										  options: .cumulativeSum) { _, result, _ in
				guard let result = result, let sum = result.sumQuantity() else {
					completion(0.0)
					return
				}
				completion(sum.doubleValue(for: HKUnit.count()))
			}
			healthStore.execute(query)
		}
	}
	
	// Write steps to HKHealthStore
	public func writeSteps(steps: Double, start: Date, end: Date, completion: @escaping (Error?) -> ()) {
		if let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) {
			let unit = HKUnit.count()
			let quantity = HKQuantity(unit: unit, doubleValue: steps)
			let sample = HKQuantitySample(type: stepsQuantityType,
										  quantity: quantity,
										  start: start,
										  end: end)
			
			healthStore.save(sample) { success, error in
				print("Saving steps to healthStore - success: \(success ? "true":"false")")
				DispatchQueue.main.async {
					completion(error)
				}
			}
		}
	}
}


// MARK: - Sample Data
extension HealthKitManager {
	
	var startDate: Date {
		return Date()
	}
	
	var endDate: Date {
		return Date()
	}
	
	func readSampleSteps(completion: @escaping (Double) -> ()) {
		readSteps(start: startDate, end: endDate, completion: completion)
	}
	
	func generateSampleSteps(completion: @escaping (Error?) -> ()) {
		
	}
}
