//
//  IndexViewController.swift
//  CenteredCollectionView_Example
//
//  Created by Benjamin Emdon on 2018-04-10.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

enum ExamplePage: String {
	case programmatic = "Programmatic Example"
	case storyboard = "Storyboard Example"

	static var allCases: [ExamplePage] {
		return [
			.programmatic,
			.storyboard
		]
	}

	static func page(from index: Int) -> ExamplePage {
		return allCases[index]
	}
}

class IndexViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ExamplePage.allCases.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
		cell.textLabel?.text = ExamplePage.allCases[indexPath.row].rawValue
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch ExamplePage.page(from: indexPath.row) {
		case .programmatic:
			let programmaticViewController = ProgrammaticViewController()
			show(programmaticViewController, sender: self)
		case .storyboard: break
		}
	}
}
