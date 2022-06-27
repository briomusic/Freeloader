import XCTest
@testable import RemoteSound

final class RemoteSoundTests: XCTestCase {
	func testStuff() throws {
		let bass = RemoteSound.Stub.bass
		let drum = RemoteSound.Stub.drum
		
		let list = RemoteSoundList(sounds: [bass, drum])
		
		XCTAssertEqual(list.sounds.count, 2)
	}
}
