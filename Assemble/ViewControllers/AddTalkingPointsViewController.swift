//
//  AddTalkingPointsViewController.swift
//  Assemble
//
//  Created by Paige Sun on 2018-09-23.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import SwiftyTables

class AddTalkingPointsDataViewController: UIViewController {
	
	private let functionalTableData = FunctionalTableData()
	private let tableView = UITableView()
	
	private let solutionId: String
	
	init(solutionId: String) {
		self.solutionId = solutionId
		super.init(nibName: nil, bundle: nil)
		
		title = "Store Data"
		
		view.backgroundColor = .white
		
		functionalTableData.tableView = tableView
		view.addSubview(tableView)
		tableView.constrainEdges(to: view)
		
		render()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func tableSections() -> [TableSection] {
		var rows = [CellConfigType]()
		
		rows.append(normalTextCell(key: "bring", title: "bring", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreTalkingPointSampleDataSaver.dontBringGuns(solutionId: strongSelf.solutionId)
		}))

		rows.append(normalTextCell(key: "services", title: "services", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreTalkingPointSampleDataSaver.services(solutionId: strongSelf.solutionId)
		}))

		rows.append(normalTextCell(key: "crime", title: "crime", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreTalkingPointSampleDataSaver.crime(solutionId: strongSelf.solutionId)
		}))

		rows.append(normalTextCell(key: "court", title: "court", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreTalkingPointSampleDataSaver.court(solutionId: strongSelf.solutionId)
		}))

		rows.append(normalTextCell(key: "government", title: "government", selectionAction: { [weak self] in
			guard let strongSelf = self else { return }
			FirestoreTalkingPointSampleDataSaver.government(solutionId: strongSelf.solutionId)
		}))
		
		return [TableSection(key: "table", rows: rows)]
	}
	
	private func render() {
		functionalTableData.renderAndDiff(tableSections())
	}
	
	private func normalTextCell(key: String, title: String, selectionAction: @escaping () -> Void) -> CellConfigType {
		return TitleHeaderCell(key: key,
							   actions: CellActions(selectionAction: { _ in
								selectionAction()
								return .deselected
							}),
							   state: TitleHeaderState(title: title, titleColor: UIColor.black, font: UIFont.systemFont(ofSize: 16)))
	}
}
