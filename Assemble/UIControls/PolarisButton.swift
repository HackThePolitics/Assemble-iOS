//
//  PolarisButton.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

enum PolarisButtonType {
	case primary, secondary
}

class PolarisButton: UIButton {
	
	private let label = UILabel()
	
	var secondaryColor: UIColor = .primaryPurple {
		didSet {
			updateColors()
		}
	}
	
	var type: PolarisButtonType = .primary {
		didSet {
			updateColors()
		}
	}
	
	init() {
		super.init(frame: .zero)

		addSubview(label)
		label.constrainEdges(to: self, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
		
		layer.cornerRadius = 8
		clipsToBounds = true

		constrainHeight(34)
		titleLabel?.font = UIFont.systemFont(ofSize: 16)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setTitle(_ title: String?, for state: UIControl.State) {
		label.text = title
	}
	
	private func updateColors() {
		switch type {
		case .primary:
			backgroundColor = .primaryPurple
			label.textColor = .white
			
			layer.borderWidth = 0
			
		case .secondary:
			backgroundColor = .white
			
			label.textColor = secondaryColor
			
			layer.borderColor = secondaryColor.cgColor
			layer.borderWidth = 2
		}
	}
}
