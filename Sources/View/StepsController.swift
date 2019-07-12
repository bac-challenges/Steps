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
//	Swift: 5.0 
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
		NotificationCenter.default.addObserver(self,
											   selector: #selector(updateView),
											   name: UIApplication.willEnterForegroundNotification,
											   object: nil)
		// Load steps
		viewModel.loadSteps {
			self.updateView()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		NotificationCenter.default.removeObserver(self)
	}
}

// MARK: - UI
extension  StepsController {
	@objc private func updateView() {
		UIView.transition(with: tableView,
						  duration: 0.3, options: .transitionCrossDissolve,
						  animations: { self.tableView.reloadData() },
						  completion: nil)
	}
	
	private func setupView() {
		// View properties
		title = "Neil Armstrong"
		
		// Change navigationBar shadow color
		navigationController?.navigationBar.shadowImage = UIImage.image(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5))
		
		// TableView
		tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
		tableView.register(StepsCell.self, forCellReuseIdentifier: StepsCell.identifier)
		tableView.register(BadgeCell.self, forCellReuseIdentifier: BadgeCell.identifier)
		tableView.separatorStyle = .none
		tableView.backgroundColor = .black
		tableView.estimatedRowHeight = 280
		tableView.rowHeight = UITableView.automaticDimension
		tableView.contentInsetAdjustmentBehavior = .automatic
		
		// Debug
		//tableView.backgroundView = UIImageView(image: UIImage(named: "Reference"))
	}
}

// MARK: UITableViewDataSource
extension StepsController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.sections.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch viewModel.sections[indexPath.section] {
		case .profile: let cell: ProfileCell = tableView.dequeueReusableCell(for: indexPath)
			return cell
		
		case .steps: let cell: StepsCell = tableView.dequeueReusableCell(for: indexPath)
			cell.configure(viewModel)
			return cell
		
		case .achievements: let cell: BadgeCell = tableView.dequeueReusableCell(for: indexPath)
			cell.configure(viewModel)
			return cell
		}
	}
}
