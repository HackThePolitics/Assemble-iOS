//
//  AssemblyNavigationController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-22.
//  Copyright © 2018 Paige Sun. All rights reserved.
//\

import UIKit

class AssemblyNavigationController: UINavigationController {
	
	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		
		delegate = self
		
		navigationBar.barTintColor = .primaryPurple
		navigationBar.tintColor = .white
		navigationBar.isTranslucent = false
		navigationBar.titleTextAttributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
			NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
		]
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension AssemblyNavigationController: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController,
							  willShow viewController: UIViewController, animated: Bool) {
		let item = UIBarButtonItem(title: " ", style: .plain, target: nil,
								   action: nil)
		viewController.navigationItem.backBarButtonItem = item
	}
}
