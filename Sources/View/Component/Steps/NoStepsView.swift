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
//	ID: C41CFB25-446A-4B23-BFEF-29253CB8D802
//
//	Pkg: Steps
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import UIKit

class NoStepsView: UIView {

	// UI
	private lazy var titleLabel = UILabel("24A4F1D5".localized("Steps Data Unavailable"), weight: .heavy)
	private lazy var detailLabel = UILabel("7375E553".localized("Check your permission settings"),
										   size: 16, weight: .medium, alpha: 0.5)
	
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

// MARK: - UI
extension NoStepsView {
	private func setupView() {
		backgroundColor = .black
		preservesSuperviewLayoutMargins = true
		isHidden = true
		addSubview(titleLabel)
		addSubview(detailLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(bottom: detailLabel.topAnchor, paddingBottom: 10,
						  left: layoutMarginsGuide.leftAnchor,
						  right: layoutMarginsGuide.rightAnchor)
		
		detailLabel.anchor(left: layoutMarginsGuide.leftAnchor,
						   right: layoutMarginsGuide.rightAnchor,
						   centerY: layoutMarginsGuide.centerYAnchor)
	}
}
