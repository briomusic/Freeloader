//
//  File.swift
//  
//
//  Created by Brio Taliaferro on 16.06.22.
//

import Foundation

public enum SearchType {
	case term
	case user
}

public enum RemoteSoundServiceError: Error {
	case invalidURL
	case noData
	case parsingError

	// Throw in all other cases
	case unexpected(code: Int)
}


public protocol RemoteSoundService: AnyObject {
	func fetch(searchType: SearchType, query: String, maxDuration: Double, callback: @escaping (RemoteSoundList?, Error?) -> Void)
}
