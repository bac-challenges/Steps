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
//	ID: 0E615D4D-0546-4C1A-B230-51520FBCA651
//
//	Pkg: Steps
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import UIKit

class StepsCell: UITableViewCell {
	
	// UI
	private lazy var noStepsView = NoStepsView()
	private lazy var stepsView = StepsView()
	
	// Init
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
extension StepsCell: Configurable {
	func configure(_ model: StepsViewModel) {
		if model.isDataAvailable {
			noStepsView.isHidden = true
			stepsView.isHidden = false
			stepsView.configure(model)
		} else {
			noStepsView.isHidden = false
			stepsView.isHidden = true
		}
	}
}

// MARK: - UI
extension StepsCell {
	private func setupView() {
		selectionStyle = .none
		backgroundColor = .clear
		addSubview(stepsView)
		addSubview(noStepsView)
		layoutView()
	}
	
	private func layoutView() {
		noStepsView.anchor(top: topAnchor,
						   bottom: bottomAnchor,
						   left: leftAnchor,
						   right: rightAnchor)
		
		stepsView.anchor(top: topAnchor,
						 bottom: bottomAnchor,
						 left: leftAnchor,
						 right: rightAnchor,
						 height: 228)
	}
}
