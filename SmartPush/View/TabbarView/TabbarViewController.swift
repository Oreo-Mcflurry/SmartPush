//
//  TabbarViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class TabbarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let homeVC = UINavigationController(rootViewController: HomeViewController())
		homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: nil)

		let scheduleVC = UINavigationController(rootViewController: ScheduledViewController())
		scheduleVC.tabBarItem = UITabBarItem(title: "예약된 푸시알림", image: UIImage(systemName: "calendar"), selectedImage: nil)

		let charVC = UINavigationController(rootViewController: ChartViewController())
		charVC.tabBarItem = UITabBarItem(title: "차트", image: UIImage(systemName: "chart.bar"), selectedImage: nil)

		self.selectedIndex = 1
		self.viewControllers = [homeVC, scheduleVC, charVC]
	}

}
