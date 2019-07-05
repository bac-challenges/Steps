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
//	Swift: 4.0
//
//	MacOS: 10.15
//

import UIKit

class StepsCell: UITableViewCell, ReusableCell {
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.font = .systemFont(ofSize: 32, weight: .heavy)
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.textColor = UIColor(named: "greenLabel")
		label.font = .systemFont(ofSize: 32, weight: .regular)
		return label
	}()
	
	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .white
		label.alpha = 0.5
		label.font = .systemFont(ofSize: 18, weight: .regular)
		return label
	}()
	
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
extension StepsCell: Configurable {
	func configure(_ model: String) {
	}
}

// MARK: - UI
extension StepsCell {
	
	private func resetView() {
		titleLabel.text = nil
		detailLabel.text = nil
		subtitleLabel.text = nil
	}
	
	private func setupView() {
		selectionStyle = .none
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(subtitleLabel)
		setupLayout()
		
		// Debug
		titleLabel.text = "Steps"
		detailLabel.text = "12.350"
		subtitleLabel.text = "Nov 12 - Dec 12 2018"
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: topAnchor,
						  left: leftAnchor,
						  paddingLeft: 16)
		
		detailLabel.anchor(top: titleLabel.topAnchor,
						   right: rightAnchor,
						   paddingRight: 16)
		
		subtitleLabel.anchor(top: titleLabel.bottomAnchor,
							 left: titleLabel.leftAnchor)
	}
}
