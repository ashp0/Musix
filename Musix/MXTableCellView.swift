//
//  MXTableCellView.swift
//  MXTableCellView
//
//  Created by Ashwin Paudel on 2021-09-21.
//

import Cocoa

class MXTableCellView: NSTableCellView {
	
	@IBOutlet weak var MXSongName: NSTextField!
	
	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		self.layer?.cornerRadius = 15
		// Drawing code here.
	}
	
}
