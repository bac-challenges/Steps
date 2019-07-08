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
			if let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) {
				let allTypes = Set([HKObjectType.workoutType(), stepsQuantityType])
				healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { success, error in
					
					if !success {
						fatalError("Not authorized: \(error.debugDescription)")
					}
					
//					self.generateSampleSteps { error in
//						self.readSampleSteps { steps in
//							print("Steps: \(steps)")
//
//						}
//					}
					self.appleSample()
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
										  options: .cumulativeSum) { _, result, error in
				guard let result = result, let sum = result.sumQuantity() else {
					fatalError("Could not read from store: \(error!)")
				}

				completion(sum.doubleValue(for: HKUnit.count()))
			}
			healthStore.execute(query)
		}
	}
	
	public func readStepsCollection(start: Date, end: Date, completion: @escaping (Double) -> ()) {
		
		var interval = DateComponents()
		interval.day = 1
		
		guard let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
			fatalError("*** Unable to create a step count type ***")
		}
		
		// Create the query
		let query = HKStatisticsCollectionQuery(quantityType: quantityType,
												quantitySamplePredicate: nil,
												options: .cumulativeSum,
												anchorDate: startDate,
												intervalComponents: interval)
		
		// Set the results handler
		query.initialResultsHandler = { query, results, error in
			
			guard let statsCollection = results else {
				fatalError("*** An error occurred while calculating the statistics: \(error.debugDescription) ***")
			}
			
			statsCollection.enumerateStatistics(from: self.startDate, to: self.endDate)  { statistics, stop  in
				
				if let quantity = statistics.sumQuantity() {
					let date = statistics.startDate
					let value = quantity.doubleValue(for: HKUnit.count())
					
					print("\(value)|\(date.description)")
				}
			}
		}
		healthStore.execute(query)
	}
}

// MARK: - Write Methods
extension HealthKitManager {
	
	/// Write number of steps to HKHealthStore
	/// - Parameters:
	///		- count: Number of steps
	///		- startDate: Count start date
	/// 	- endDate: Count end date
	/// 	- completion:
	public func writeSteps(count: Double, startDate start: Date, endDate end: Date, completion: @escaping (Error?) -> ()) {
		let sample = quantitySample(count: count, startDate: startDate, endDate: endDate)
		writeQuantitySample(sample, completion: completion)
	}
	
	/// Write Quantity Sample to HKHealthStore
	private func writeQuantitySample(_ sample: HKQuantitySample, completion: @escaping (Error?) -> ()?) {
		writeQuantitySamples([sample], completion: completion)
	}
	
	/// Write Quantity Samples to HKHealthStore
	private func writeQuantitySamples(_ samples: [HKQuantitySample], completion: @escaping (Error?) -> ()?) {
		healthStore.save(samples) { success, error in
			print("Saving steps to healthStore - success: \(success ? "true":"false")")
			DispatchQueue.main.async {
				completion(error)
			}
		}
	}
	
	/// Create HKQuantitySample
	/// - Parameters:
	///		- count: Number of steps
	///		- startDate: Count start date
	/// 	- endDate: Count end date
	///
	/// - Returns: New HKQuantitySample
	private func quantitySample(count: Double, startDate start: Date, endDate end: Date) -> HKQuantitySample {
		guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
			fatalError()
		}
		let unit = HKUnit.count()
		let quantity = HKQuantity(unit: unit, doubleValue: count)
		let sample = HKQuantitySample(type: stepsQuantityType,
									  quantity: quantity,
									  start: start,
									  end: end)
		return sample
	}
}

// MARK: - Sample Data
extension HealthKitManager {
	
	// Sample data
	private struct SampleData {
		let steps: Double
		let startDate: Date
		let endDate: Date
	}
	
	private var startDate: Date { return "2019-06-01".toDate()! }
	private var endDate: Date { return "2019-06-30".toDate()! }
	
	private var stepsRange: [SampleData] {
		var result = [SampleData]()
		for i in 1...30 {
			let startDate = "2019-06-\(i) 00:00".toDate(withFormat: "yyyy-MM-dd HH:mm")!
			let endDate = "2019-06-\(i) 11:59".toDate(withFormat: "yyyy-MM-dd HH:mm")!
			let steps = Double(Int.random(in: 5000...20000))
			result.append(SampleData(steps: steps,
									 startDate: startDate,
									 endDate: endDate))
		}
		return result
	}

	/// Read sample steps data
	func readSampleSteps(completion: @escaping (Double) -> ()) {
		readSteps(start: startDate, end: endDate, completion: completion)
	}
	
	/// Generate sample data for test purposes
	func generateSampleSteps(completion: @escaping (Error?) -> ()) {
		let sampleData = stepsRange.map { sampleData in
			quantitySample(count: sampleData.steps,
						   startDate: sampleData.startDate,
						   endDate: sampleData.endDate)
		}
		writeQuantitySamples(sampleData, completion: completion)
	}
}
