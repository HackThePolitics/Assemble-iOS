//
//  SpacerCell.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

typealias SpacerCell = HostCell<SpacerView, SpacerState, EdgeBasedTableItemLayout>

class SpacerView: UIView {
	
	fileprivate var heightConstraint = NSLayoutConstraint()
	
	init() {
		super.init(frame: CGRect.zero)
		
		backgroundColor = .clear
		heightConstraint = constrainHeight(0, priority: .defaultHigh)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

struct SpacerState: StateType {
	
	typealias View = SpacerView
	
	var height: CGFloat
	
	init(height: CGFloat) {
		self.height = height
	}
	
	static func updateView(_ view: SpacerView, state: SpacerState?) {
		guard let state = state else { return }
		view.heightConstraint.constant = state.height
	}
}

extension SpacerState: Equatable {
	static func ==(lhs: SpacerState, rhs: SpacerState) -> Bool {
		return lhs.height == rhs.height
	}
}
