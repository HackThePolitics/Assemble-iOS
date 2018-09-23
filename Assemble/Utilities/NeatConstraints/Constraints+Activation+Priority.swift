//
//  Constraints+Activation+Priority.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import UIKit

public extension Sequence where Element == NSLayoutConstraint {
	
	public func activate() {
		if let constraints = self as? [NSLayoutConstraint] {
			NSLayoutConstraint.activate(constraints)
		}
	}
	
	public func deActivate() {
		if let constraints = self as? [NSLayoutConstraint] {
			NSLayoutConstraint.deactivate(constraints)
		}
	}
}

public extension NSLayoutConstraint {
	
	public func with(_ p: UILayoutPriority) -> Self {
		priority = p
		return self
	}
	
	public func set(active: Bool) -> Self {
		isActive = active
		return self
	}
}

public extension UIView {
	
	public func setHugging(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
		setContentHuggingPriority(priority, for: axis)
	}
	
	public func setCompressionResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
		setContentCompressionResistancePriority(priority, for: axis)
	}
}
