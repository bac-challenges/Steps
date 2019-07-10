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
//	Swift: 5.0
//
//	MacOS: 10.15
//

import Foundation
import HealthKit

struct HealthKitManager {
	
	// Singleton
	public static let shared = HealthKitManager()
	
	private let healthStore = HKHealthStore()

	/// Authorize access to HealthKit
	func isHealthDataAvailable(completion: @escaping (Bool, Error?) -> Void) {
		if HKHealthStore.isHealthDataAvailable() {
			let allTypes = Set([HKObjectType.workoutType(), stepsQuantityType])
			healthStore.requestAuthorization(toShare: allTypes,
											 read: allTypes,
											 completion: completion)
		}
	}
}

// MARK: - Read Data Methods
extension HealthKitManager {

	/// Reads number of steps to HKHealthStore
	/// - Parameters:
	///		- startDate: Count start date
	/// 	- endDate: Count end date
	///		- completion: A block that this method calls as soon as the read operation is complete.
	public func readSteps(startDate start: Date, endDate end: Date, completion: @escaping (Double) -> Void) {
		
		let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
		
		let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate,  options: .cumulativeSum) { _, result, error in
			guard let result = result, let sum = result.sumQuantity() else {
				fatalError("*** Could not read from store: \(error.debugDescription) ***")
			}
			completion(sum.doubleValue(for: HKUnit.count()))
		}
		healthStore.execute(query)
	}
	
	/// Reads number of steps to HKHealthStore
	/// - Parameters:
	///		- startDate: Count start date
	/// 	- endDate: Count end date
	///		- completion: A block that this method calls as soon as the read operation is complete.
	public func readStepsCollection(startDate start: Date, endDate end: Date, completion: @escaping ([PointEntry]) -> Void) {
		
		var interval = DateComponents()
		interval.day = 1
		
		let query = HKStatisticsCollectionQuery(quantityType: stepsQuantityType,
												quantitySamplePredicate: nil,
												options: .cumulativeSum,
												anchorDate: startDate,
												intervalComponents: interval)
		
		query.initialResultsHandler = { query, results, error in
			
			guard let statsCollection = results else {
				fatalError("*** An error occurred while calculating the statistics: \(error.debugDescription) ***")
			}
			
			var pointEntryCollection = [PointEntry]()
			
			statsCollection.enumerateStatistics(from: self.startDate, to: self.endDate)  { statistics, stop  in
				
				if let quantity = statistics.sumQuantity() {
					let date = statistics.startDate
					let value = quantity.doubleValue(for: HKUnit.count())
					
					pointEntryCollection.append(PointEntry(value: Int(value), label: date.description))

				}
			}
			
			completion(pointEntryCollection)
		}
		healthStore.execute(query)
	}
}

// MARK: - Write Data Methods
extension HealthKitManager {
	
	/// Saves number of steps to HKHealthStore
	/// - Parameters:
	///		- count: Number of steps
	///		- startDate: Count start date
	/// 	- endDate: Count end date
	///		- completion: A block that this method calls as soon as the save operation is complete.
	public func saveSteps(count: Double, startDate start: Date, endDate end: Date, completion: @escaping (Error?) -> Void) {
		let sample = quantitySample(count: count, startDate: startDate, endDate: endDate)
		saveQuantitySample(sample, completion: completion)
	}
	
	/// Saves HKQuantitySample to HKHealthStore
	/// - Parameters:
	///		- sample: HKQuantitySample object.
	///		- completion: A block that this method calls as soon as the save operation is complete.
	private func saveQuantitySample(_ sample: HKQuantitySample, completion: @escaping (Error?) -> Void) {
		saveQuantitySampleCollection([sample], completion: completion)
	}
	
	/// Saves HKQuantitySample collection to HKHealthStore
	/// - Parameters:
	///		- samples: Array of HKQuantitySample objects.
	///		- completion: A block that this method calls as soon as the save operation is complete.
	private func saveQuantitySampleCollection(_ collection: [HKQuantitySample], completion: @escaping (Error?) -> Void) {
		healthStore.save(collection) { success, error in
			print("Saving steps to healthStore - success: \(success ? "true":"false")")
			DispatchQueue.main.async {
				completion(error)
			}
		}
	}
	
	/// Creates HKQuantitySample
	/// - Parameters:
	///		- count: Number of steps
	///		- startDate: Count start date
	/// 	- endDate: Count end date
	/// - Returns: New HKQuantitySample
	private func quantitySample(count: Double, startDate start: Date, endDate end: Date) -> HKQuantitySample {
		
		let unit = HKUnit.count()
		let quantity = HKQuantity(unit: unit, doubleValue: count)
		let sample = HKQuantitySample(type: stepsQuantityType,
									  quantity: quantity,
									  start: start,
									  end: end)
		return sample
	}
}

// MARK: - Helpers
extension HealthKitManager {
	/// Steps HKQuantityType
	var stepsQuantityType: HKQuantityType {
		guard let quantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
			fatalError("*** Unable to create a step count type ***")
		}
		return quantityType
	}
}

// MARK: - Sample Data Generator
#warning("Convert to dynamic data")
extension HealthKitManager {
	
	// Sample data
	private struct SampleData {
		let steps: Double
		let startDate: Date
		let endDate: Date
	}
	
	#warning("Change to first of the month")
	private var startDate: Date { return "2019-06-01".toDate()! }
	private var endDate: Date { return "2019-06-30".toDate()! }
	
	#warning("Use calendar to generate days of the month")
	private var stepsRange: [SampleData] {
		var result = [SampleData]()
		for i in 1...30 {
			let startDate = "2019-06-\(i) 00:00".toDate(withFormat: "yyyy-MM-dd HH:mm")!
			let endDate = "2019-06-\(i) 11:59".toDate(withFormat: "yyyy-MM-dd HH:mm")!
			
			#warning("Reduce amount of steps per day")
			let steps = Double(Int.random(in: 5000...20000))
			result.append(SampleData(steps: steps,
									 startDate: startDate,
									 endDate: endDate))
		}
		return result
	}

	#warning("Create StepsModel")
	/// Read sample steps data
	func readSampleSteps(completion: @escaping ([PointEntry]) -> Void) {
		readStepsCollection(startDate: startDate, endDate: endDate, completion: completion)
	}
	
	/// Generate sample data for test purposes
	func generateSampleSteps(completion: @escaping (Error?) -> Void) {
		let sampleData = stepsRange.map { sampleData in
			quantitySample(count: sampleData.steps,
						   startDate: sampleData.startDate,
						   endDate: sampleData.endDate)
		}
		saveQuantitySampleCollection(sampleData, completion: completion)
	}
}