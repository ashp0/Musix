//
//  AppDelegate.swift
//  Musix
//
//  Created by Ashwin Paudel on 2021-09-21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	let window = MXWindowController()


	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		window.showWindow(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}


}

