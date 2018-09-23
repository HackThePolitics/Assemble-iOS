//
//  FTD+Constrainable.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables
import UIKit

extension UIView {
	
	func constrainEdgesToFTDView(_ otherView: UIView, topInset: CGFloat = 0, bottomInset: CGFloat = 0) {
		constrainTop(to: otherView, offset: topInset)
		constrainEdgesHorizontally(to: otherView)
		constrainBottom(to: otherView, offset: -bottomInset, priority: UILayoutPriority.init(999))
	}
}
