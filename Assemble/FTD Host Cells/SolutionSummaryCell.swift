//
//  SolutionSummaryCell.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

typealias SolutionSummaryCell = HostCell<SolutionSummaryView, SolutionSummaryState, AssembleMarginsTableItemLayout>

class SolutionSummaryView: UIView {

	fileprivate let titleLabel = UILabel()
	fileprivate let subtitleLabel = UILabel()
	
	fileprivate let govLevelButton = PolarisButton()
	
	init() {
		super.init(frame: CGRect.zero)
		
		backgroundColor = .white
		
		layer.masksToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.4
		layer.shadowOffset = CGSize(width: 2, height: 2)
		layer.shadowRadius = 2
		
		let stack = mainStack()

		addSubview(stack)
		stack.constrainEdgesToFTDView(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func mainStack() -> UIView {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 4
		
		titleLabel.numberOfLines = 0
		stack.addArrangedSubview(titleLabel)
		
		govLevelButton.type = .secondary
		let buttonContainer = UIView()
		buttonContainer.addSubview(govLevelButton)
		govLevelButton.constrainEdgesVertically(to: buttonContainer)
		govLevelButton.constrainLeft(to: buttonContainer)
		stack.addArrangedSubview(buttonContainer)
		
		subtitleLabel.numberOfLines = 0
		stack.addArrangedSubview(subtitleLabel)
		
		return stack
	}
}

struct SolutionSummaryState: StateType {
	
	typealias View = SolutionSummaryView
	
	let title: String
	let subtitleControlText: [ControlText]
	let govLevelColor: UIColor
	let govLevelText: String
	
	init(title: String,
		 subtitleControlText: [ControlText],
		 govLevelColor: UIColor,
		 govLevelText: String) {
		self.title = title
		self.subtitleControlText = subtitleControlText
		self.govLevelColor = govLevelColor
		self.govLevelText = govLevelText
	}
	
	static func updateView(_ view: SolutionSummaryView, state: SolutionSummaryState?) {
		guard let state = state else { return }
		
		view.titleLabel.text = state.title
		view.subtitleLabel.attributedText = NSAttributedString(state.subtitleControlText)
		view.govLevelButton.secondaryColor = state.govLevelColor
		view.govLevelButton.setTitle(state.govLevelText, for: .normal)
	}
}

extension SolutionSummaryState: Equatable {
	static func ==(lhs: SolutionSummaryState, rhs: SolutionSummaryState) -> Bool {
		var equality = lhs.title == rhs.title
		equality = equality && lhs.subtitleControlText == rhs.subtitleControlText
		equality = equality && lhs.govLevelColor == rhs.govLevelColor
		equality = equality && lhs.govLevelText == rhs.govLevelText
		return equality
	}
}
