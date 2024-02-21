//
//  AppDelegate.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let configuration = Realm.Configuration(schemaVersion: 1) { migration, oldSchemaVersion in
			// 단순한 테이블 컬럼 추가되는 경우에는 별도 작성 X
			if oldSchemaVersion < 1 {
				migration.enumerateObjects(ofType: PushModel.className()) { oldObject, newObject in
					guard let new = newObject else { return }
					guard let oldObject else { return }
					new["deadlineDate"] = oldObject["deadline"]
				}
			}
		}
		Realm.Configuration.defaultConfiguration = configuration
		
		return true
	}

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}


}

