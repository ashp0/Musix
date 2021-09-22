//
//  MXWindowController.swift
//  MXWindowController
//
//  Created by Ashwin Paudel on 2021-09-21.
//

import Cocoa

class MXWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
		print("hello world")
		self.contentViewController = MXViewController()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
	
	convenience init() {
		self.init(windowNibName: "MXWindowController")
	}
}
