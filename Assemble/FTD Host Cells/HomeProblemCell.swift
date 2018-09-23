//
//  DetailCell.swift
//  FunctionalTableDataMyDemo
//
//  Created by Paige Sun on 2017-12-19.
//

import SwiftyTables
import SDWebImage

typealias HomeProblemCell = HostCell<HomeProblemView, HomeProblemState, AssembleMarginsTableItemLayout>

class HomeProblemView: UIView {
	fileprivate let imageView1 = UIImageView()
	fileprivate let titleLabel1 = UILabel()

	init() {
		super.init(frame: .zero)
		
		imageView1.clipsToBounds = true
		imageView1.contentMode = .scaleAspectFill
		imageView1.constrainHeight(90)

		backgroundColor = .white

		layer.masksToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.4
		layer.shadowOffset = CGSize(width: 2, height: 2)
		layer.shadowRadius = 2

		let stack = mainVerticalStack()
		stack.spacing = 10
		addSubview(stack)
		stack.constrainEdgesToFTDView(self, topInset: 0, bottomInset: 8)
	}
	
	private func mainVerticalStack() -> UIStackView {
		let stack = UIStackView()
		stack.axis = .vertical
		
		stack.addArrangedSubview(imageView1)
		
		titleLabel1.numberOfLines = 0
		stack.addArrangedSubview(titleLabel1)
		
		return stack
	}
	
//	private func mainHorizontalStack() -> UIStackView {
//		let stack = UIStackView()
//
//
//
//		stack.axis = .horizontal
//		return stack
//	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

struct HomeProblemState {
	let squareImageUrl: String
    let titleText: [ControlText]
	
    init(titleText: [ControlText], squareImageUrl: String) {
        self.titleText = titleText
		self.squareImageUrl = squareImageUrl
    }
}

extension HomeProblemState: StateType {
    typealias View = HomeProblemView

    static func updateView(_ view: HomeProblemView, state: HomeProblemState?) {
        guard let state = state else {
            return
        }
		
		let url = URL(string: state.squareImageUrl)
		view.imageView1.sd_setImage(with: url)
		view.titleLabel1.attributedText = NSMutableAttributedString(state.titleText)
    }
}

extension HomeProblemState: Equatable {
    static func ==(lhs: HomeProblemState, rhs: HomeProblemState) -> Bool {
        var equality = lhs.titleText == rhs.titleText
        equality = equality && lhs.squareImageUrl == rhs.squareImageUrl
        return equality
    }
}
