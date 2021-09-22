//
//  MXSound.swift
//  MXSound
//
//  Created by Ashwin Paudel on 2021-09-22.
//

import Cocoa

public class MXSound {
	public var sound: NSSound?
	
	
	public init(_ url: URL) {
		sound = NSSound(contentsOf: url, byReference: false)
	}
	
	public init() {
		sound = NSSound()
	}
	
	public init(_ file: String) {
		sound = NSSound(contentsOfFile: file, byReference: false)
	}
	
	public func play() { sound?.play() }
	public func stop() { sound?.stop() }
	public func resume() { sound?.resume() }
	public func pause() { sound?.pause() }
	
	public func setTime(_ interval: TimeInterval) { sound?.currentTime = interval }
	
	public var isPlaying: Bool { sound!.isPlaying }
	public var currentTime: TimeInterval { sound?.currentTime ?? 0 }
	public var duration: TimeInterval { sound?.duration ?? 100 }
}
