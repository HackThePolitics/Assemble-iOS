//
//  TalkingPointViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

class SolutionViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	private let solution: Solution
	
	private var talkingPointsCollection: LocalCollection<TalkingPoint>!
	
	init(solution: Solution) {
		self.solution = solution
		
		super.init(nibName: nil, bundle: nil)
		
		title = "Solution"
		view.backgroundColor = .backgroundGray
		tableView.backgroundColor = .clear
		
		let rightButton = UIBarButtonItem(title: "   ", style: .done, target: self, action: #selector(rightButtonTapped))
		navigationItem.rightBarButtonItem = rightButton
		
		functionalTableData.tableView = tableView
		view.addSubview(tableView)
		tableView.constrainEdges(to: view)
		
		talkingPointsCollection = LocalCollection<TalkingPoint>(
			query: FirestoreManager.firestoreDB()
				.collection("talking-points")
				.whereField("solutionId", isEqualTo: solution.id ?? ""),
			updateHandler: { [weak self] changed in
				ContextLogger.printContext("Changed talking point collection!")
				self?.render()
		})
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		talkingPointsCollection.listen()
	}
	
	deinit {
		talkingPointsCollection.stopListening()
	}
	
	private func tableSections() -> [TableSection] {
		var rows = [CellConfigType]()
		
		let titleCell = FTDCellFactory.headerCell(key: "titleCell", title: solution.title)
		rows.append(titleCell)
		
		if talkingPointsCollection.items.count > 0 {
			let topTalkingPointsHeaderCell = FTDCellFactory.headerCell(key: "talking points header", title: "TALKING POINTS")
			rows.append(topTalkingPointsHeaderCell)
		}
		
		let pros = talkingPointsCollection.items.filter { $0.isPro }
		if pros.count > 0 {
			let topTalkingPointsHeaderCell = TitleHeaderCell(
				key: "pros header",
				style: FTDCellFactory.clearCellStyle(),
				state: TitleHeaderState(title: "PROS", titleColor: .prosGreen, font: .systemFont(ofSize: 20)))
			rows.append(topTalkingPointsHeaderCell)
		}
		
		for point in pros {
			let cell = TitleHeaderCell(key: "\(point.id)", state: TitleHeaderState(title: point.text, titleColor: .black, font: .systemFont(ofSize: 14)))
			rows.append(cell)
			rows.append(FTDCellFactory.spacerCell(key: "spacer \(point.id)", height: 10))
		}
		
		let cons = talkingPointsCollection.items.filter { !$0.isPro }
		if cons.count > 0 {
			let topTalkingPointsHeaderCell = TitleHeaderCell(
				key: "cons header",
				style: FTDCellFactory.clearCellStyle(),
				state: TitleHeaderState(title: "CONS", titleColor: .consRed, font: .systemFont(ofSize: 20)))
			rows.append(topTalkingPointsHeaderCell)
		}
		for point in cons {
			let cell = TitleHeaderCell(key: "\(point.id)", state: TitleHeaderState(title: point.text, titleColor: .black, font: .systemFont(ofSize: 14)))
			rows.append(cell)
			rows.append(FTDCellFactory.spacerCell(key: "spacer \(point.id)", height: 10))
		}
		
		return [TableSection(key: "table", rows: rows)]
	}
	
	private func render() {
		functionalTableData.renderAndDiff(tableSections())
	}
	
	@objc private func rightButtonTapped() {		
		let vc = AddTalkingPointsDataViewController(solutionId: solution.id ?? "")
		navigationController?.show(vc, sender: nil)
	}
}
