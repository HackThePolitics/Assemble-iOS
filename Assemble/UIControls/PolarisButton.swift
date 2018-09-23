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

		layer.cornerRadius = 8
		clipsToBounds = true

		constrainHeight(34)
		titleLabel?.font = UIFont.systemFont(ofSize: 16)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func updateColors() {
		switch type {
		case .primary:
			backgroundColor = .primaryPurple
			setTitleColor(.white, for: .normal)
			
			layer.borderWidth = 0
			
		case .secondary:
			backgroundColor = .white
			setTitleColor(secondaryColor, for: .normal)
			
			layer.borderColor = secondaryColor.cgColor
			layer.borderWidth = 2
		}
	}
}
