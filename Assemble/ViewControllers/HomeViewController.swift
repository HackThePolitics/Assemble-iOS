//
//  HomeViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables
import FirebaseFirestore

class HomeViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	private var problemCollection: LocalCollection<Problem>!
	
	init() {
		
		super.init(nibName: nil, bundle: nil)
		
		title = "Assemble"
		tableView.backgroundColor = .backgroundGray
		
		problemCollection = LocalCollection<Problem>(
			query: FirestoreManager.firestoreDB().collection("problems"),
			updateHandler: { [weak self] changed in
				ContextLogger.printContext("Changed problem collection!")
				self?.render()
		})
		
		let leftImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
		leftImageView.constrainSize(CGSize(width: 35, height: 35))
		let leftImage = UIBarButtonItem(customView: leftImageView)
		navigationItem.leftBarButtonItem = leftImage
		
		let rightButton = UIBarButtonItem(title: "   ", style: .done, target: self, action: #selector(rightButtonTapped))
		navigationItem.rightBarButtonItem = rightButton
		
		functionalTableData.tableView = tableView
		view.addSubview(tableView)
		tableView.constrainEdges(to: view)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		problemCollection.listen()
	}
	
	deinit {
		problemCollection.stopListening()
	}
	
	@objc private func rightButtonTapped() {
		let vc = AddDataViewController()
		navigationController?.show(vc, sender: nil)
	}
	
	private func tableSections() -> [TableSection] {
		var rows = [CellConfigType]()
		
		let localProblems = problemCollection.items.filter{ $0.level == "Municipal" }
		if localProblems.count > 0 {
			rows.append(headerCell(key: "local", title: "Top Local Issues"))
		}
		for problem in localProblems {
			rows += problemCells(problem)
		}
		
		let nonlocalProblems = problemCollection.items.filter{ $0.level != "Municipal" }
		if nonlocalProblems.count > 0 {
			rows.append(headerCell(key: "nonlocal", title: "Top Toronto Issues"))
		}
		for problem in nonlocalProblems {
			rows += problemCells(problem)
		}
		
		return [TableSection(key: "table", rows: rows)]
	}
	
	private func headerCell(key: String, title: String) -> CellConfigType {
		return TitleHeaderCell(
			key: key,
			style: FTDCellFactory.clearCellStyle(),
			state: TitleHeaderState(title: title, titleColor: .black, font: UIFont.boldSystemFont(ofSize: 24)))
	}
	
	private func problemCells(_ problem: Problem) -> [CellConfigType] {
		var rows = [CellConfigType]()

		let titleControlText = ControlText(text: problem.title,
										   font: UIFont.boldSystemFont(ofSize: 18))
		let state = HomeProblemState(titleText: [titleControlText],
									 squareImageUrl: problem.bannerImageUrl)
		
		let probId = problem.id ?? String(arc4random())
		let cell = HomeProblemCell(
			key: "key\(probId)",
			style: FTDCellFactory.clearCellStyle(),
			state: state)
		rows.append(cell)
		
		rows.append(FTDCellFactory.spacerCell(key: "spacer \(probId)", height: 12))
		
		return rows
	}
	
	@objc private func leftButtonTapped() {
		
	}
	
	private func render() {
		functionalTableData.renderAndDiff(tableSections())
	}
}
