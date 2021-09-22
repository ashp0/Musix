//
//  MXViewController.swift
//  MXViewController
//
//  Created by Ashwin Paudel on 2021-09-21.
//

import Cocoa
import MXSound

var isLooping = true

class MXViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
	
	@IBOutlet weak var slider: NSSlider!
	@IBOutlet weak var tableView: NSTableView!
	var songList: [SongList]?
	var song: MXSound = MXSound()
	var position: Int = 0
	var finishedSong: Bool = true
	var timer: Timer?
	
	init() {
		super.init(nibName: "MXViewController", bundle: nil)
		songList = parseJSON()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do view setup here.
		tableView.delegate = self
		tableView.dataSource = self
		tableView.reloadData()
		
		tableView.doubleAction = #selector(tableViewDoubleClick)
		
		volumeSliderOutlet.maxValue = 1
		volumeSliderOutlet.minValue = 0
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "songstablecell"), owner: self) as? MXTableCellView else { return nil }
		
		cell.MXSongName.stringValue = songList![row].name
		cell.layer?.backgroundColor = .black
		return cell
	}
	
	@objc func tableViewDoubleClick() {
		let row = tableView.clickedRow
		if !finishedSong {
			song.sound?.resume()
		} else {
			playSong(i: row)
		}
	}
	
	@IBOutlet weak var playpauseButtonOutlet: NSButton!
	@IBAction func previousSong(_ sender: Any) {
		if position > 0 {
			tableView.unhighlightCell(row: position)
			position -= 1
			song.sound?.stop()
			finishedSong = true
			playpauseButton(playpauseButtonOutlet)
			playpauseButton(playpauseButtonOutlet)
		}
	}
	
	@IBOutlet weak var volumeSliderOutlet: NSSlider!
	
	@IBAction func volumeSlider(_ sender: NSSlider) {
		song.sound?.volume = volumeSliderOutlet.floatValue
	}
	func playSong(i: Int? = nil) {
		if i == nil {
			if (song.sound != nil) {
				song.stop()
			}
			slider.isEnabled = true
			song = MXSound(songList![position].file.getURLPath)
			song.play()
			tableView.highlightCell(row: position)
		} else {
			if (song.sound != nil) {
				song.stop()
			}
			slider.isEnabled = true
			song = MXSound(songList![i!].file.getURLPath)
			song.play()
			tableView.highlightCell(row: i!)
		}
	}
	
	@IBAction func forwardSong(_ sender: Any) {
		if position <= songList!.count {
			tableView.unhighlightCell(row: position)
			position += 1
			song.sound?.stop()
			finishedSong = true
			playpauseButton(playpauseButtonOutlet)
			playpauseButton(playpauseButtonOutlet)
		}
	}
	@IBAction func playpauseButton(_ sender: NSButton) {
		if sender.image == NSImage(named: NSImage.touchBarPauseTemplateName) {
			song.sound?.pause()
			sender.image = NSImage(named: NSImage.touchBarPlayTemplateName)
		} else {
			if !finishedSong {
				if !song.isPlaying {
					playSong()
					forwardSong(sender)
				}
				song.sound?.resume()
				sender.image = NSImage(named: NSImage.touchBarPauseTemplateName)
			} else {
				if position >= songList!.count {
					song.sound?.stop()
				} else {
					if finishedSong {
						playSong()
					}
					sender.image = NSImage(named: NSImage.touchBarPauseTemplateName)
					finishedSong = false
					timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
						slider.doubleValue = song.sound!.currentTime
						slider.maxValue = song.sound!.duration
						if !song.isPlaying {
							song.stop()
							sender.image = NSImage(named: NSImage.touchBarPlayTemplateName)
							timer!.invalidate()
							tableView.unhighlightCell(row: position-1)
							finishedSong = true
						}
					}
				}
			}
		}
	}
	
	
	@IBAction func sliderAction(_ sender: Any) {
		song.setTime(slider.doubleValue)
	}
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return songList!.count
	}
	
	func readFileFromBundle(_ fileName: String, _ extension: String) -> String {
		var contents = ""
		do {
			contents = try String(contentsOfFile: Bundle.main.path(forResource: fileName, ofType: `extension`)!)
		} catch {
			print("Error: [Reading File]: \(error.localizedDescription)")
		}
		return contents
	}
	
	func parseJSON() -> [SongList]? {
		let welcome = try? JSONDecoder().decode([SongList].self, from: readFileFromBundle("songlist", "json").data(using: .utf8)!)
		return welcome
	}
}

/*
 JSON Parser
 */

struct SongList: Codable {
	let name: String
	let file: String
}

/*
 Table View
 */

extension NSTableView {
	public func unhighlightCell(row: Int) {
		let cell = self.view(atColumn: 0, row: row, makeIfNecessary: false) as? NSTableCellView
		cell!.layer!.backgroundColor = .clear
	}
	
	public func highlightCell(row: Int) {
		let cell = self.view(atColumn: 0, row: row, makeIfNecessary: false) as? NSTableCellView
		cell!.layer!.backgroundColor = NSColor.controlAccentColor.cgColor
	}
	
	public func highlightCell(row: Int, color: CGColor) {
		let cell = self.view(atColumn: 0, row: row, makeIfNecessary: false) as? NSTableCellView
		cell!.layer!.backgroundColor = color
	}
}

extension String {
	var getURLPath: URL {
		URL(fileURLWithPath: self)
	}
}
