//
//  AssembleLayout.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

public typealias AssembleMarginsTableItemLayout = CombinedLayout<AssembleMarginsLayout.Horizontal30, MarginsLayout.Vertical>

public enum AssembleMarginsLayout {
	
	static let extraMargins: CGFloat = 30
	
	public struct Horizontal30: TableItemLayout {
		public static func layoutView(_ view: UIView, inContentView contentView: UIView) {
			let extraMargins = AssembleMarginsLayout.extraMargins
			
			view.constrainEdgesHorizontally(to: contentView,
											leftInsets: extraMargins,
											rightInsets: extraMargins,
											usingSafeArea: true)
		}
	}
}
