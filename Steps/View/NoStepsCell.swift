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
//	Swift: 4.2
//
//	MacOS: 10.15
//

import UIKit

class NoStepsCell: UITableViewCell {

	// UI
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = .white
		label.font = .systemFont(ofSize: 18, weight: .heavy)
		return label
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
extension NoStepsCell: Configurable {
	func configure(_ model: StepsViewModel) {
		titleLabel.text = "Steps Data Unavaliable"
	}
}

// MARK: - UI
extension NoStepsCell {
	private func resetView() {
	}
	
	private func setupView() {
		selectionStyle = .none
		backgroundColor = .black
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: layoutMarginsGuide.topAnchor, paddingTop: 60,
						  bottom: layoutMarginsGuide.bottomAnchor, paddingBottom: 120,
						  left: layoutMarginsGuide.leftAnchor,
						  right: layoutMarginsGuide.rightAnchor)
	}
}
