//
//  ScheduledViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class ScheduledViewController: HomeViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		navigationItem.title = "예약된 푸시알림"
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}
