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

class StepsView: UIView {
	
	// UI
	private lazy var titleLabel = UILabel("58033C81".localized("Steps"), alignment: .left, size: 32, weight: .heavy)
	private lazy var detailLabel = UILabel(color: UIColor(named: "greenLabel"),alignment: .right, size: 32, weight: .regular)
	private lazy var subtitleLabel = UILabel(alignment: .left, size: 18, weight: .regular, alpha: 0.5)
	private lazy var chart = LineChart()
	
	// Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
}

// MARK: - Configurable
extension StepsView: Configurable {
	func configure(_ model: StepsViewModel) {
		detailLabel.text = model.stepsCountText
		subtitleLabel.text = model.stepsDateRangeText
		chart.dataEntries = model.steps.map {
			PointEntry(value: Int($0.steps),
					   label: $0.date.toString())
		}
	}
}

// MARK: - UI
extension StepsView {
	private func setupView() {
		backgroundColor = .black
		preservesSuperviewLayoutMargins = true
		isHidden = true
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(subtitleLabel)
		addSubview(chart)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: topAnchor, left: layoutMarginsGuide.leftAnchor)
		detailLabel.anchor(top: titleLabel.topAnchor, right: layoutMarginsGuide.rightAnchor)
		subtitleLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: -2,  left: titleLabel.leftAnchor)
		chart.anchor(bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, height: 160)
	}
}
