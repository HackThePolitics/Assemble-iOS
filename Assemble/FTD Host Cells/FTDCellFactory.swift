//
//  FTDCellFactory.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

struct FTDCellFactory {
	
	static func clearCellStyle() -> CellStyle {
		return CellStyle(backgroundColor: .clear)
	}
	
	static func spacerCell(key: String, height: CGFloat) -> CellConfigType {
		return SpacerCell(key: key,
			style: clearCellStyle(),
			state: SpacerState(height: height))
	}
	
	static func headerCell(key: String, title: String) -> CellConfigType {
		return TitleHeaderCell(
			key: key,
			style: FTDCellFactory.clearCellStyle(),
			state: TitleHeaderState(title: title, titleColor: .black, font: UIFont.boldSystemFont(ofSize: 24)))
	}
}
