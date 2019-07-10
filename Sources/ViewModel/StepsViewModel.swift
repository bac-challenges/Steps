
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
	var chartPoints: [PointEntry]?
}

// MARK: - Data Management
extension StepsViewModel {
	
	/// Read steps from HealthKit
	func loadSteps(completion: @escaping () -> Void) {
		DispatchQueue.main.async {
			HealthKitManager.shared.readSampleSteps { result in
				DispatchQueue.main.sync {
					self.chartPoints = result
					completion()
				}
			}
		}
	}
}

// MARK: - View Properties
extension StepsViewModel {
	
	var profileName: String {
		return "Neil Armstrong"
	}
	
	var profileImage: String {
		return "profile-photo"
	}
	
	var stepsCountText: String {
		guard let chartPoints = chartPoints else {
			return "0"
		}
		
		return chartPoints.compactMap { $0.value }
						  .reduce(0) { $0 + $1 }
						  .formattedWithSeparator
	}
	
	#warning("Show live data")
	var stepsDateRangeText: String {
		return "Nov 12 - Dec 12 2018"
	}
	
	var achievementsCountText: String {
		return "\(achievedGoals.count)"
	}
	
	var isDataAvailable: Bool {
		guard let chartPoints = chartPoints  else {
			return false
		}
		return chartPoints.count == 0 ? false:true
	}
	
	#warning("Show static from CoreData model")
	var achievedGoals: [Int] {
		return [10,15,20,25,30,35,40]
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
