//
//  TreatmentTests.swift
//  
//
//  Created by Brio Taliaferro on 08.06.22.
//

import XCTest
@testable import Freesound

class TreatmentTests: XCTestCase {
	
	var service = FreesoundService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func _testFetch() throws {
		// Given
		let query = "bass"
		
		let expectation = self.expectation(description: "Scaling")

		// When
		service.fetch(searchType: .term, query: query, maxDuration: 0) { list, error in
			print()
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 5, handler: nil)

		
	}

	func _testDownloadListItem() throws {

		let urlString = "https://www.freesound.org/apiv2/search/text/?query=bass&token=7d936a39ec27ee866942d3bbb4884a1320c79325"
		
		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				
				let decoder = JSONDecoder()
				let decodedResult = try? decoder.decode(FreesoundList.self, from: data)

				dump(decodedResult)
			}
		}
	}
	
	func _testDownloadDetailItem() throws {
		// Given
		let listItem = FreesoundListItem(id: 209943, name: "bass 16b.wav")
		let urlString = "https://www.freesound.org/apiv2/sounds/\(listItem.id)/?token=7d936a39ec27ee866942d3bbb4884a1320c79325"

		// When
		if let url = URL(string: urlString) {
			if let data = try? Data(contentsOf: url) {
				let decoder = JSONDecoder()
				let decodedResult = try? decoder.decode(FreesoundDetailItem.self, from: data)

				dump(decodedResult)
			}
		}
	}
	
	func testParseDetailItem() throws {
		// Given
		let data = detailJSON.data(using: .utf8)!
		
		// When
		let decoder = JSONDecoder()
		let decodedResult = try? decoder.decode(FreesoundDetailItem.self, from: data)
		
		// Then
		XCTAssertNotNil(decodedResult)
	}
	
	func testParseListItem() throws {
		// Given
		let data = listJSON.data(using: .utf8)!
		
		// When
		let decoder = JSONDecoder()
		let decodedResult = try? decoder.decode(FreesoundList.self, from: data)
		
		// Then
		XCTAssertEqual(decodedResult?.results.count, 2)
	}
	
	let listJSON = """
{
	"count": 30005,
	"next": "https://freesound.org/apiv2/search/text/?&query=bass&weights=&page=2",
	"results": [
	  {
		"id": 209943,
		"name": "bass 16b.wav",
		"tags": [
		  "bass",
		  "boop",
		  "HUM",
		  "ambiance",
		  "metal",
		  "deep",
		  "GUITAR",
		  "rumble",
		  "LOW",
		  "rock",
		  "BASS"
		],
		"license": "http://creativecommons.org/publicdomain/zero/1.0/",
		"username": "Veiler"
	  },
	  {
		"id": 529718,
		"name": "4 string bass soloing on the Sigil scale C, C♯, E, F, G♯, A at 130 bpm.wav",
		"tags": [
		  "Yamaha",
		  "mystic",
		  "Fender",
		  "pop",
		  "abolish-monarchy",
		  "hell",
		  "BASS",
		  "atheism",
		  "scale",
		  "frets",
		  "Sigil",
		  "G-sharp",
		  "mysterious",
		  "AMP",
		  "MODO",
		  "goth",
		  "bass",
		  "death-metal",
		  "personoclast",
		  "MODO-BASS",
		  "deep",
		  "bass-guitar",
		  "electric-bass",
		  "sigil-scale",
		  "Ibanez",
		  "metal",
		  "C-sharp",
		  "Trilian",
		  "rock"
		],
		"license": "http://creativecommons.org/publicdomain/zero/1.0/",
		"username": "Veiler"
	  }
	],
	"previous": null
  }
"""

	
	let detailJSON = """
{"id":209943,"url":"https://freesound.org/people/Veiler/sounds/209943/","name":"bass 16b.wav","tags":["BASS","rock","LOW","rumble","GUITAR","deep","metal","ambiance","HUM","boop","bass"],"description":"this is a bass sound","geotag":null,"created":"2013-12-08T14:04:19","license":"http://creativecommons.org/publicdomain/zero/1.0/","type":"wav","channels":2,"filesize":290504,"bitrate":0,"bitdepth":16,"duration":1.62363,"samplerate":44100.0,"username":"Veiler","pack":"https://freesound.org/apiv2/packs/13354/","pack_name":null,"download":"https://freesound.org/apiv2/sounds/209943/download/","bookmark":"https://freesound.org/apiv2/sounds/209943/bookmark/","previews":{"preview-lq-ogg":"https://cdn.freesound.org/previews/209/209943_3797507-lq.ogg","preview-lq-mp3":"https://cdn.freesound.org/previews/209/209943_3797507-lq.mp3","preview-hq-ogg":"https://cdn.freesound.org/previews/209/209943_3797507-hq.ogg","preview-hq-mp3":"https://cdn.freesound.org/previews/209/209943_3797507-hq.mp3"},"images":{"spectral_m":"https://cdn.freesound.org/displays/209/209943_3797507_spec_M.jpg","spectral_l":"https://cdn.freesound.org/displays/209/209943_3797507_spec_L.jpg","spectral_bw_l":"https://cdn.freesound.org/displays/209/209943_3797507_spec_bw_L.jpg","waveform_bw_m":"https://cdn.freesound.org/displays/209/209943_3797507_wave_bw_M.png","waveform_bw_l":"https://cdn.freesound.org/displays/209/209943_3797507_wave_bw_L.png","waveform_l":"https://cdn.freesound.org/displays/209/209943_3797507_wave_L.png","waveform_m":"https://cdn.freesound.org/displays/209/209943_3797507_wave_M.png","spectral_bw_m":"https://cdn.freesound.org/displays/209/209943_3797507_spec_bw_M.jpg"},"num_downloads":13100,"avg_rating":3.5686274509803924,"num_ratings":51,"rate":"https://freesound.org/apiv2/sounds/209943/rate/","comments":"https://freesound.org/apiv2/sounds/209943/comments/","num_comments":9,"comment":"https://freesound.org/apiv2/sounds/209943/comment/","similar_sounds":"https://freesound.org/apiv2/sounds/209943/similar/","analysis":"No descriptors specified. You should indicate which descriptors you want with the  request parameter.","analysis_frames":"https://freesound.org/data/analysis/209/209943-fs-essentia-extractor_legacy_frames.json","analysis_stats":"https://freesound.org/apiv2/sounds/209943/analysis/","ac_analysis":{"ac_tempo_confidence":0.0,"ac_note_confidence":1.0,"ac_depth":74.43506861904042,"ac_note_midi":33,"ac_temporal_centroid":0.3934195637702942,"ac_warmth":57.70202628367829,"ac_loop":false,"ac_hardness":36.786053556019084,"ac_loudness":-6.099411964416504,"ac_reverb":false,"ac_roughness":49.59143967352892,"ac_log_attack_time":-1.1625661849975586,"ac_boominess":54.63837569421172,"ac_note_frequency":55.14019775390625,"ac_tempo":199,"ac_brightness":18.517891492177164,"ac_sharpness":24.81739654674444,"ac_tonality_confidence":0.898349940776825,"ac_dynamic_range":0.0,"ac_note_name":"A1","ac_tonality":"A major","ac_single_event":false},"analyzers_output":{"ac_tempo_confidence":0.0,"ac_roughness":49.59143967352892,"ac_note_confidence":1.0,"ac_log_attack_time":-1.1625661849975586,"ac_depth":74.43506861904042,"ac_note_frequency":55.14019775390625,"ac_boominess":54.63837569421172,"ac_tempo":199,"ac_note_midi":33,"ac_brightness":18.517891492177164,"ac_temporal_centroid":0.3934195637702942,"ac_warmth":57.70202628367829,"ac_tonality_confidence":0.898349940776825,"ac_loop":false,"ac_sharpness":24.81739654674444,"ac_hardness":36.786053556019084,"yamnet_class":["Synthesizer"],"ac_dynamic_range":0.0,"ac_note_name":"A1","ac_tonality":"A major","ac_loudness":-6.099411964416504,"ac_reverb":false,"ac_single_event":false}}
"""

}
