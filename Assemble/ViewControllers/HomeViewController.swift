//
//  HomeViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

class HomeViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	private var problems = [Problem]()
	
	init() {
		super.init(nibName: nil, bundle: nil)
		
		view.backgroundColor = .white
		
		functionalTableData.tableView = tableView
		view.addSubview(tableView)
		tableView.constrainEdges(to: view)
		
//		FirestoreManager.storeGunProblem()
//		FirestoreManager.storeGunProblem()
//		FirestoreManager.storeGunProblem()
//		FirestoreManager.storeGunProblem()
//		FirestoreManager.storeGunProblem()
		
		FirestoreManager.getProblems() { [weak self] problems in
			self?.problems = problems
			self?.render()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func tableSections() -> [TableSection] {
		var rows = [CellConfigType]()
		
		for problem in problems {
			
			let state = HomeProblemState(titleText: [
				ControlText(text: problem.title,
							font: UIFont.boldSystemFont(ofSize: 18))
				],
										 squareImageUrl: problem.bannerImageUrl)

			let rand = String(arc4random())
			let cell = HomeProblemCell(key: "key \(problem.id ?? rand)", state: state)
			rows.append(cell)
		}
		
		return [TableSection(key: "table", rows: rows)]
	}
	
	private func render() {
		functionalTableData.renderAndDiff(tableSections())
	}
}
