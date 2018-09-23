//
//  ControlText.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

struct ControlText {
	let text: String
	let font: UIFont
	let color: UIColor
	let alignment: NSTextAlignment
	
	init(text: String, font: UIFont, color: UIColor = .black, alignment: NSTextAlignment = .left) {
		self.text = text
		self.font = font
		self.color = color
		self.alignment = alignment
	}
}

extension ControlText: Equatable {
	static func ==(lhs: ControlText, rhs: ControlText) -> Bool {
		var equality = lhs.text == rhs.text
		equality = equality && lhs.font == rhs.font
		equality = equality && lhs.color == rhs.color
		return equality
	}
}

protocol ControlableText {
	func setControlText(_ controlText: ControlText)
}

extension UILabel: ControlableText {
	func setControlText(_ controlText: ControlText) {
		text = controlText.text
		font = controlText.font
		textColor = controlText.color
	}
}

extension UIButton: ControlableText {
	func setControlText(_ controlText: ControlText) {
		setControlText(controlText, for: .normal)
	}
	
	func setControlText(_ controlText: ControlText,  for state: UIControl.State) {
		setTitle(controlText.text, for: state)
		setTitleColor(controlText.color, for: state)
		titleLabel?.font = controlText.font
	}
}

extension NSAttributedString {
	
	convenience init(_ configs: [ControlText]) {
		
		let allMessages = configs.reduce("") { result, config in
			return result + config.text
		}
		
		let myMutableString = NSMutableAttributedString(string: allMessages)
		
		var totalLength = 0
		for config in configs {
			let range = NSRange(location: totalLength, length: config.text.count)
			myMutableString.addAttributes([NSAttributedString.Key.font: config.font], range: range)
			myMutableString.addAttributes([NSAttributedString.Key.foregroundColor: config.color], range: range)
			
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.lineSpacing = 6
			paragraphStyle.lineHeightMultiple = 1.0
			paragraphStyle.alignment = config.alignment
			
			myMutableString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, myMutableString.length))
			
			totalLength += config.text.count
		}
		
		self.init(attributedString: myMutableString)
	}
}
