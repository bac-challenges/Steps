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
//	ID: D7CA8878-03F8-4381-B723-27DFD8B73352
//
//	Pkg: Steps
//
//	Swift: 4.0
//
//	MacOS: 10.15
//

import UIKit

class ChartCell: UITableViewCell, ReusableCell {
	
	// UI
	private lazy var chart: LineChart = {
		let view = LineChart()
		view.dataEntries = generateRandomEntries()
		view.isCurved = false
		return view
	}()
	
	// Init
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		resetView()
	}
}

// MARK: - Configurable
extension ChartCell: Configurable {
	func configure(_ model: StepsViewModel) {
	}
}

// MARK: - UI
extension ChartCell {
	private func resetView() {
	}
	
	private func setupView() {
		selectionStyle = .none
		preservesSuperviewLayoutMargins = true
		addSubview(chart)
		setupLayout()
	}
	
	private func setupLayout() {
		chart.anchor(top: topAnchor,
					 bottom: bottomAnchor,
					 left: leftAnchor,
					 right: rightAnchor)
	}
}

// MARK: - Debug
#warning("REMOVE AFTER INTEGRATION OF CHARTS")
extension ChartCell {
	private func generateRandomEntries() -> [PointEntry] {
		var result: [PointEntry] = []
		for i in 0..<100 {
			let value = Int(arc4random() % 20000)
			
			let formatter = DateFormatter()
			formatter.dateFormat = "d MMM"
			var date = Date()
			date.addTimeInterval(TimeInterval(24*60*60*i))
			
			result.append(PointEntry(value: value, label: formatter.string(from: date)))
		}
		return result
	}
}
