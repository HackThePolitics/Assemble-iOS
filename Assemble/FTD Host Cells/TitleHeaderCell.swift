//
//  TitleHeaderCell.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

typealias TitleHeaderCell = HostCell<TitleHeaderView, TitleHeaderState, AssembleMarginsTableItemLayout>

class TitleHeaderView: UIView {
	
	fileprivate let titleLabel = UILabel()
	
	init() {
		super.init(frame: .zero)
		setupTitleLabel()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTitleLabel() {
		titleLabel.numberOfLines = 0
		addSubview(titleLabel)
		titleLabel.constrainEdges(to: self)
		
		titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
	}
}

struct TitleHeaderState {
	
	let title: String
	let titleColor: UIColor
	let font: UIFont
	
	init(title: String, titleColor: UIColor, font: UIFont) {
		self.title = title
		self.titleColor = titleColor
		self.font = font
	}
}

extension TitleHeaderState: StateType {
	
	typealias View = TitleHeaderView
	
	static func updateView(_ view: TitleHeaderView, state: TitleHeaderState?) {
		guard let state = state else {
			view.titleLabel.text = nil
			return
		}
		
		view.titleLabel.text = state.title
		view.titleLabel.textColor = state.titleColor
		view.titleLabel.font = state.font
	}
}

extension TitleHeaderState: Equatable {
	
	static func ==(lhs: TitleHeaderState, rhs: TitleHeaderState) -> Bool {
		var equality = lhs.title == rhs.title
		equality = equality && lhs.titleColor == rhs.titleColor
		equality = equality && lhs.font == rhs.font
		return equality
	}
}
