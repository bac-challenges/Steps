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
//	Swift: 5.0
//
//	MacOS: 10.15
//

import UIKit

#warning("Convert to UIView and use in StepsCell as parent")
class ChartCell: UITableViewCell {
	
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
}

// MARK: - Configurable
extension ChartCell: Configurable {
	func configure(_ model: StepsViewModel) {
		chart.dataEntries = model.chartPoints
	}
}

// MARK: - UI
extension ChartCell {
	private func setupView() {
		selectionStyle = .none
		backgroundColor = .black
		preservesSuperviewLayoutMargins = true
		addSubview(chart)
		setupLayout()
	}
	
	private func setupLayout() {
		chart.anchor(top: layoutMarginsGuide.topAnchor,
					 bottom: layoutMarginsGuide.bottomAnchor,
					 left: leftAnchor,
					 right: rightAnchor,
					 height: 170)
	}
}
