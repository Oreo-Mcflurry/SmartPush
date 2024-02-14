//
//  HomeViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class HomeViewController: BaseViewController {

	let homeView = HomeView()

	override func loadView() {
		self.view = homeView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		navigationItem.title = "모든 푸시알림"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

#Preview {
	UINavigationController(rootViewController: HomeViewController())
}
