//
//  ContextLogger.swift
//  AppletreeWaittimer
//
//  Created by Paige Sun on 2018-08-16.
//  Copyright © 2018 Paige Sun. All rights reserved.
//

import Foundation

struct ContextLogger {
	
	private static let emojis: [String] = ["🐶", "🐱", "🐹", "🦊", "🦁", "🐼", "🦆", "🐸", "🐵", "🐥", "🐨", "🐧", "🐯", "🐴",
										   "🐠", "🦀", "🐳", "🐢", "🦕", "🦑", "🐡", "🐊", "🐙", "🐬",
										   "🐲", "🦄",
										   "🎃", "🌸", "🍄", "🌴", "🌵",
										   "🎅", "⛄️", "🤹‍♀️", "⛷",
										   "👘", "👑", "👔", "🌂", "🎭"]
	private static var emojiForFilename: [String: String] = [:]
	
	static func logError(_ error: Error?,
						 function: String = #function, file: String = #file, line: Int = #line) {
		let errorMessage = error?.localizedDescription ?? "Error is nil"
		logFrontendError("🚨🚨🚨\n\n" + errorMessage, function: function, file: file, line: line)
	}
	
	static func logServerError(_ message: String,
							   function: String = #function, file: String = #file, line: Int = #line) {
		logLongMessage(fullLogMessage(prefix: "🔴", fileName: shortendFileName(from: file), function: function, message: message, line: line))
	}
	
	static func logFrontendError(_ message: String,
								 function: String = #function, file: String = #file, line: Int = #line) {
		logLongMessage(fullLogMessage(prefix: "🤦‍♀️", fileName: shortendFileName(from: file), function: function, message: message, line: line))
	}
	
	static func logSuccess(_ message: String,
						   function: String = #function, file: String = #file, line: Int = #line) {
		logLongMessage(fullLogMessage(prefix: "✅", fileName: shortendFileName(from: file), function: function, message: message, line: line))
	}
	
	// Print the fileName, function, and message. Prefix with an emoji, hashed from the fileName for easier debugging.
	static func printContext(_ any: Any,
							 function: String = #function, file: String = #file, line: Int = #line) {
		let prefix: String
		let shortFileName = shortendFileName(from: file)
		if let shortFileName = shortFileName {
			prefix = emoji(for: shortFileName)
		} else {
			prefix = "💜"
		}
		logLongMessage(fullLogMessage(prefix: prefix, fileName: shortFileName, function: function, message: "\(any)", line: line))
	}
	
	private static func logLongMessage(_ longMessage: String) {
		// NSLog():
		// Pro: is synchronized, unlike print()
		// Con: has a limit of 1024 characters
		let messageArray = longMessage.components(separatedBy: "\n")
		for message in messageArray {
			NSLog(message)
		}
	}
	
	private static func emoji(for fileName: String) -> String {
		if let emoji = emojiForFilename[fileName] {
			return emoji
		} else {
			let index = Int(fileName.hashValue.magnitude) % emojis.count
			return emojis[index]
		}
	}
	
	private static func fullLogMessage(prefix: String, fileName: String?, function: String, message: String, line: Int) -> String {
		var result = ""
		result += "\n\n\(prefix) *~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*"
		if let fileName = fileName {
			result += "\n\tFileName: \(fileName)"
		}
		result += "\n\tFunction: \(function)"
		result += "\n\tLine: \(line)"
		result += "\n\n\(message)"
		result += "\n*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*\n\n"
		
		return result
	}
	
	private static func shortendFileName(from file: String) -> String? {
		if let range = file.range(of: "([A-z])*.swift", options: String.CompareOptions.regularExpression) {
			return "\(file[range.lowerBound..<range.upperBound])"
		}
		return nil
	}
}
