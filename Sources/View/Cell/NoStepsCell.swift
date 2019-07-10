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

#warning("Convert to view and include in StepsView")
class NoStepsCell: UIView {

	// UI
	private lazy var titleLabel = UILabel("24A4F1D5".localized("Steps Data Unavailable"), weight: .heavy)
	private lazy var detailLabel = UILabel("7375E553".localized("Check your permission settings"),
										   size: 16,
										   weight: .medium,
										   alpha: 0.5)
	
	private lazy var button: UIButton = {
		let button = UIButton()
		button.setTitle("E8870A43".localized("Generate Sample Data"), for: .normal)
		button.addTarget(self, action: #selector(generateSampleData), for: .touchUpInside)
		return button
	}()
	
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

// MARK: - Actions
extension NoStepsCell {
	@objc func generateSampleData() {
	}
}

// MARK: - UI
extension NoStepsCell {
	private func setupView() {
		backgroundColor = #colorLiteral(red: 0.03935233504, green: 0.03935233504, blue: 0.03935233504, alpha: 1)
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(button)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: layoutMarginsGuide.topAnchor, paddingTop: 30,
						  left: layoutMarginsGuide.leftAnchor,
						  right: layoutMarginsGuide.rightAnchor)
		
		detailLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 10,
						   centerX: centerXAnchor)
		
		button.anchor(top: detailLabel.bottomAnchor, paddingTop: 60,
					  bottom: layoutMarginsGuide.bottomAnchor, paddingBottom: 30,
					  left: detailLabel.leftAnchor,
					  right: detailLabel.rightAnchor,
					  centerX: centerXAnchor)
	}
}
