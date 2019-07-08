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
//	ID: 7A1892BB-BE84-48DB-85D1-65685022878E
//
//	Pkg: Steps
//
//	Swift: 4.2 
//
//	MacOS: 10.15
//

import UIKit

class StepsController: UITableViewController {
	
	// Model
	lazy private var viewModel = StepsViewModel()

	// Life Cycle
	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupView()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Read steps from HealthKit
		DispatchQueue.main.async {
			HealthKitManager.shared.readSampleSteps { result in
				DispatchQueue.main.sync {
					self.viewModel.chartPoints = result
					self.tableView.reloadData()
					self.tableView.alpha = 1
				}
			}
		}
	}
}

// MARK: - UI
extension  StepsController {
	private func setupView() {
		// View properties
		title = viewModel.profileName
		
		// Change navigationBar shadow color
		navigationController?.navigationBar.shadowImage = UIImage.image(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5))
		
		// TableView
		tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
		tableView.register(StepsCell.self, forCellReuseIdentifier: StepsCell.identifier)
		tableView.register(ChartCell.self, forCellReuseIdentifier: ChartCell.identifier)
		tableView.register(AchievementsCell.self, forCellReuseIdentifier: AchievementsCell.identifier)
		tableView.separatorStyle = .none
		tableView.backgroundColor = .black
		tableView.contentInsetAdjustmentBehavior = .automatic
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 70
		tableView.alpha = 0
	}
}

// MARK: UITableViewDataSource
extension StepsController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.isDataAvailable ? Sections.allValues.count : Sections.noStepsValues.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return Sections.allValues[indexPath.section].rowHeight
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let section = viewModel.isDataAvailable ? Sections.allValues : Sections.noStepsValues
		switch section[indexPath.section] {
		case .profile: let cell: ProfileCell = tableView.dequeueReusableCell(for: indexPath)
			cell.configure(viewModel)
			return cell
		
		case .steps: let cell: StepsCell = tableView.dequeueReusableCell(for: indexPath)
			cell.configure(viewModel)
			return cell
		
		case .chart: let cell: ChartCell = tableView.dequeueReusableCell(for: indexPath)
			cell.configure(viewModel)
			return cell
		
		case .achievements: let cell: AchievementsCell = tableView.dequeueReusableCell(for: indexPath)
			cell.configure(viewModel)
			return cell
		}
	}
}

// MARK: - TableView Structure
#warning("Move to ViewModel?")
extension StepsController {
	enum Sections: Int {
		#warning("Add no steps case - No data available or generate data button.")
		case profile, steps, chart, achievements

		static var allValues: [Sections] {
			return [.profile, .steps, .chart, .achievements]
		}
		
		static var noStepsValues: [Sections] {
			return [.profile, .achievements]
		}
		
		var identifier: String {
			switch self {
			case .profile: return ProfileCell.identifier
			case .steps: return StepsCell.identifier
			case .chart: return ChartCell.identifier
			case .achievements: return AchievementsCell.identifier
			}
		}
		
		#warning("Convert to dynamic height for cells")
		var rowHeight: CGFloat {
			switch self {
			case .profile: return 220
			case .steps: return 60
			case .chart: return 170
			case .achievements: return 280
			}
		}
	}
}
