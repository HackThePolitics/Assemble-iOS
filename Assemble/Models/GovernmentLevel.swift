//
//  GovernmentLevel.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

enum GovernmentLevel {
	case federal, provincial, municipal
	
	init?(from firestoreString: String) {
		switch firestoreString {
		case "Federal":
			self = GovernmentLevel.federal
		case "Provincial":
			self = GovernmentLevel.provincial
		case "Municipal":
			self = GovernmentLevel.municipal
		default:
			return nil
		}
	}
	
	var displayString: String {
		switch self {
		case .federal:
			return "Federal"
		case .provincial:
			return "Provincial"
		case .municipal:
			return "Municipal"
		}
	}
}
