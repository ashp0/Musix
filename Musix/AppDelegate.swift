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
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if let button = self.statusItem.button {
            button.title = "~"
            button.action = #selector(quitApp(_:))
        }
        
		// Insert code here to initialize your application
		window.showWindow(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}


    @objc func quitApp(_ sender: NSStatusItem) {
        exit(0)
    }
}

