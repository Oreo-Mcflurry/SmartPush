//
//  Transition+Extension.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

enum TransitionStyle {
	case present
	case presentNavigation
	case presentFullNavigation
	case push
}

extension UIViewController {

	func transition<T: UIViewController>(withStyle style: TransitionStyle, viewController: T.Type) {
		let vc = T()

		switch style {
		case .present:
			present(vc, animated: true)
		case .presentNavigation:
			present(UINavigationController(rootViewController: vc), animated: true)
		case .presentFullNavigation:
			let nav = UINavigationController(rootViewController: vc)
			nav.modalPresentationStyle = .fullScreen
			present(nav, animated: true)
		case .push:
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}
