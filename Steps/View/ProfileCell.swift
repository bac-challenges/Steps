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
//	ID: 578C3C76-5316-431E-8C63-5D55EE0D5835
//
//	Pkg: Steps
//
//	Swift: 4.0 
//
//	MacOS: 10.15
//

import UIKit

class ProfileCell: UITableViewCell, ReusableCell {
	
	// UI
	var profileImage: UIImageView = {
		let view = UIImageView("profile-photo-placeholder", rounded: true)
		view.tintColor = .darkGray
		return view
	}()
	
	// Init
    override func awakeFromNib() {
        super.awakeFromNib()
		setupView()
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
extension ProfileCell: Configurable {
	func configure(_ model: StepsViewModel) {
		profileImage.image = UIImage(named: model.profileImage)
	}
}

// MARK: - UI
extension  ProfileCell {
	private func resetView() {
		profileImage.image = nil
	}
	
	private func setupView() {
		selectionStyle = .none
		preservesSuperviewLayoutMargins = true
		profileImage.tintColor = .darkGray
		addSubview(profileImage)
		setupLayout()
	}
	
	private func setupLayout() {
		profileImage.anchor(width: 180,
							height:180,
							centerX: centerXAnchor,
							centerY: centerYAnchor)
	}
}