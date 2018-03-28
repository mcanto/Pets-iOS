//
//  Logger.swift
//  Pets
//
//  Created by Mario Canto on 2/13/18.
//  Copyright © 2018 Mario Canto. All rights reserved.
//

import Foundation

// Enum for showing the type of Log Types
public enum LogEvent: CustomDebugStringConvertible {
	case error
	case info
	case debug
	case verbose
	case warning
	case severe
	
	public var debugDescription: String {
		switch self {
		case .error:
			return "🔴"
		case .info:
			return "⚫️"
		case .debug:
			return "🔵"
		case .verbose:
			return "⚪️"
		case .warning:
			return "🔶"
		case .severe:
			return "❌"
		}
	}
}

public final class Logger {
	
	static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
	static var dateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = dateFormat
		formatter.locale = Locale.current
		formatter.timeZone = TimeZone.current
		return formatter
	}
	
	public class func log(message: String? = nil,
				   event: LogEvent,
				   fileName: String = #file,
				   line: Int = #line,
				   column: Int = #column,
				   funcName: String = #function) {
		
		#if DEBUG
			if let logMessage = message {
				print("\(Date().toString()) \(event.debugDescription)[\(sourceFileName(filePath: fileName))]: (l:\(line) c:\(column)) \(funcName) -> \(logMessage)")
			} else {
				print("\(Date().toString()) \(event.debugDescription)[\(sourceFileName(filePath: fileName))]: (l:\(line) c:\(column)) \(funcName)")
			}
		#endif
	}
	private class func sourceFileName(filePath: String) -> String {
		let components = filePath.components(separatedBy: "/")
		return components.isEmpty ? "" : components.last!
	}
}

internal extension Date {
	func toString() -> String {
		return Logger.dateFormatter.string(from: self as Date)
	}
}
