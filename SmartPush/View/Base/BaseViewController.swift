//
//  BaseViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureHierarchy()
		configureLayout()
		configureView()
	}

	func configureHierarchy() { }
	func configureLayout() { }
	func configureView() { }

	func showToast(withString message: String) {
		view.makeToast(message)
	}

	func showAlert(title: String, message: String, buttonTitle: String, style: UIAlertController.Style, buttonAction completionHandler: @escaping ()->Void) {
		let alert =	UIAlertController(title: title, message: message, preferredStyle: style)
		let cancelButton = UIAlertAction(title: "취소", style: .cancel)
		let button1 = UIAlertAction(title: buttonTitle, style: .default) { _ in
			completionHandler()
		}

		alert.addAction(cancelButton)
		alert.addAction(button1)

		present(alert, animated: true)
	}

}
