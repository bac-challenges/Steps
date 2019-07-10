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
//	ID: 20279F23-3DDC-4C3D-B89F-F92B5FCB4E03
//
//	Pkg: Steps
//
//	Swift: 5.0
//
//	MacOS: 10.15
//

import UIKit

class BadgeListView: UIView {
	
	// UI
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "A1239E36".localized("Achievements")
		label.textAlignment = .left
		label.textColor = .white
		label.font = .systemFont(ofSize: 24, weight: .bold)
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .right
		label.textColor = UIColor(named: "blueLabel")
		label.font = .systemFont(ofSize: 24, weight: .bold)
		return label
	}()
	
	private lazy var scrollView = UIScrollView()
	
	private lazy var stackView: UIStackView = {
		let view = UIStackView()
		view.distribution = .fill
		view.alignment = .fill
		view.spacing = 30
		return view
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

// MARK: - Configurable
#warning("Remove all children before adding")
extension BadgeListView: Configurable {
	func configure(_ model: StepsViewModel) {
		detailLabel.text = model.achievementsCountText
		model.achievedGoals.forEach { item in
			let itemView = BadgeItemView()
			itemView.configure(item)
			stackView.addArrangedSubview(itemView)
		}
	}
}

// MARK: - UI
extension BadgeListView {
	private func setupView() {
		preservesSuperviewLayoutMargins = true
		addSubview(titleLabel)
		addSubview(detailLabel)
		addSubview(scrollView)
		scrollView.addSubview(stackView)
		setupLayout()
	}
	
	private func setupLayout() {
		titleLabel.anchor(top: topAnchor,
						  left: layoutMarginsGuide.leftAnchor)
		
		detailLabel.anchor(top: topAnchor,
						   right: layoutMarginsGuide.rightAnchor)
		
		scrollView.anchor(top: titleLabel.bottomAnchor, paddingTop: 10,
						  left: leftAnchor,
						  right: rightAnchor,
						  height: 180)
		
		stackView.anchor(top: scrollView.topAnchor,
						 bottom: scrollView.bottomAnchor,
						 left: scrollView.leftAnchor, paddingLeft: 25,
						 right: scrollView.rightAnchor)
	}
}

