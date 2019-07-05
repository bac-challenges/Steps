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
//	Swift: 4.0 
//
//	MacOS: 10.15
//

import UIKit

class StepsController: UITableViewController {
	
	@IBOutlet weak var profileCell: ProfileCell!
	@IBOutlet weak var stepsCell: StepsCell!
	@IBOutlet weak var chartCell: ChartCell!
	@IBOutlet weak var achievementsCell: AchievementsCell!
	
	lazy private var viewModel = StepsViewModel()

	override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
    }
}

// MARK: - UI
extension  StepsController {
	
	private func setupView() {
		title = viewModel.profileName
		profileCell.configure(viewModel)
		stepsCell.configure(viewModel)
		chartCell.configure(viewModel)
		achievementsCell.configure(viewModel)
	}
}
