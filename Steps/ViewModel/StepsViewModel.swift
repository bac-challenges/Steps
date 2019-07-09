
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
//	Swift: 4.2 
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
	
	var stepsLabelText: String {
		return "58033C81".localized(withComment: "Steps")
	}
	
	var stepsCountText: String {
		return "12.350"
	}
	
	var stepsDateRangeText: String {
		return "Nov 12 - Dec 12 2018"
	}
	
	var noAchievementsTitleText: String {
		return "89DCAC96".localized(withComment: "No achievements yet")
	}
	
	var noAchievementsSubtitleText: String {
		return "11427B1F".localized(withComment: "Keep walking!")
	}
	
	var achievementsTitleText: String {
		return "A1239E36".localized(withComment: "Achievements")
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

	var achievedGoals: [AchievementViewModel] {
		let result = [10,15,20,25,30,35,40].map {
			AchievementViewModel(Achievement(steps: $0))
		}
		return result
	}
}

// MARK: - TableView Structure
extension StepsViewModel {
	enum Sections: Int {
		case profile, steps, noSteps, chart, achievements
		
		static var allValues: [Sections] {
			return [.profile, .steps, .chart, .achievements]
		}
		
		static var noStepsValues: [Sections] {
			return [.profile, .noSteps, .achievements]
		}
		
		var identifier: String {
			switch self {
			case .profile: return ProfileCell.identifier
			case .steps: return StepsCell.identifier
			case .noSteps: return UITableViewCell.identifier
			case .chart: return ChartCell.identifier
			case .achievements: return AchievementsCell.identifier
			}
		}
	}
	
	var sections: [Sections] {
		return isDataAvailable ? Sections.allValues : Sections.noStepsValues
	}
}
