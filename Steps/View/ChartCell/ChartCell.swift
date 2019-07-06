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
//	Swift: 4.2
//
//	MacOS: 10.15
//

import UIKit

class ChartCell: UITableViewCell, ReusableCell {
	
	// UI
	private lazy var chart = LineChart()
	
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
		chart.dataEntries =  generateRandomEntries()
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
		var result = [PointEntry]()
		[1,5,10,15,25,30].forEach { date in
			let value = Int.random(in: 5...20)
			result.append(PointEntry(value: value, label: "\(date)|\(value)"))
			print(value)
		}
		return result
	}
}
