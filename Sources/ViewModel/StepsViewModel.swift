
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
//	ID: 60067050-097B-446D-9D11-60E454F49C7C
//
//	Pkg: Steps
//
//	Swift: 5.0 
//
//	MacOS: 10.15
//

import UIKit

class StepsViewModel {
	
	//
	private lazy var store = CoreDataManager.shared
	
	var dailySteps: [DailySteps]? {
		didSet {
			updateBadges()
		}
	}
}

// MARK: - Data Management
extension StepsViewModel {
	
	/// Read steps from HealthKit
	func loadSteps(completion: @escaping () -> Void) {
		DispatchQueue.main.async {
			HealthKitManager.shared.readSampleSteps { result in
				DispatchQueue.main.sync {
					self.dailySteps = result
					completion()
				}
			}
		}
	}
}

// MARK: - StepsCell
extension StepsViewModel {
	var stepsCountText: String {
		guard let chartPoints = dailySteps else {
			return "0"
		}
		return chartPoints.compactMap { $0.value }
						  .reduce(0) { $0 + $1 }
						  .format()
	}
	
	var stepsCount: Int {
		guard let chartPoints = dailySteps else {
			return 0
		}
		return chartPoints.compactMap { $0.value }
			.reduce(0) { $0 + $1 }
	}
	
	var stepsDateRangeText: String {
		if let start = dailySteps?.first?.date.toString("MMM dd"),
			let end = dailySteps?.last?.date.toString("MMM dd YYYY") {
			return "\(start) - \(end)"
		}
		return "N/A"
	}
}

// MARK: - Achievements
extension StepsViewModel {
	var achievementsCountText: String {
		return "\(achievedGoals.count)"
	}
	
	var isDataAvailable: Bool {
		guard let chartPoints = dailySteps  else {
			return false
		}
		return chartPoints.count == 0 ? false:true
	}
	
	var achievedGoals: [Badge] {
		return store.fetchItems(predicate: "isUnlocked == YES")
	}
	
	private func updateBadges() {
		let badges: [Badge] = store.fetchItems(predicate: "steps < \(stepsCount/1000)")
		badges.forEach { badge in
			badge.setValue(true, forKey: "isUnlocked")
		}
		store.saveContext()
	}
}

// MARK: - TableView Structure
extension StepsViewModel {
	enum Sections: Int {
		case profile, steps, achievements
		
		static var allValues: [Sections] {
			return [.profile, .steps, .achievements]
		}

		var identifier: String {
			switch self {
			case .profile: return ProfileCell.identifier
			case .steps: return StepsCell.identifier
			case .achievements: return BadgeCell.identifier
			}
		}
	}
	
	var sections: [Sections] {
		return Sections.allValues
	}
}
