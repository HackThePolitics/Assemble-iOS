//
//  ImageCell.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables
import SDWebImage

typealias ImageHeaderCell = HostCell<ImageHeaderView, ImageHeaderState, AssembleMarginsTableItemLayout>

class ImageHeaderView: UIView {
	
	fileprivate let imageView = UIImageView()
	
	init() {
		super.init(frame: .zero)
		setupImage()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupImage() {
		imageView.contentMode = .scaleAspectFit
		addSubview(imageView)
		imageView.constrainEdgesToFTDView(self)
		imageView.constrainHeight(300)
	}
}

struct ImageHeaderState {
	
	let image: UIImage
	
	init(image: UIImage) {
		self.image = image
	}
}

extension ImageHeaderState: StateType {
	
	typealias View = ImageHeaderView
	
	static func updateView(_ view: ImageHeaderView, state: ImageHeaderState?) {
		guard let state = state else {
			return
		}

		view.imageView.image = state.image
//		view.layoutRatioConstraint.constant = state.image.size.height /  state.image.size.width
	}
}

extension ImageHeaderState: Equatable {
	
	static func ==(lhs: ImageHeaderState, rhs: ImageHeaderState) -> Bool {
		let equality = lhs.image == rhs.image
		return equality
	}
}
