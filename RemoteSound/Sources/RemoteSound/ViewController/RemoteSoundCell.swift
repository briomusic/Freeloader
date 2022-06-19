//
//  RemoteSoundCell.swift
//  
//
//  Created by Brio Taliaferro on 19.06.22.
//

import UIKit

typealias ActionCallback = (RemoteSound) -> Void

class RemoteSoundCell: UITableViewCell {
	
	var sound: RemoteSound?
	var previewCallback: ActionCallback?
	
	static let buttonConfig : UIImage.SymbolConfiguration = {
		UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
	}()

	let waveformView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage.waveform.withTintColor(UIColor.csOrange, renderingMode: .alwaysOriginal)
		return imageView
	}()
	let nameLabel = UILabel()
	
	let previewButton: UIButton = {
		let image = UIImage(systemName: "play.fill", withConfiguration: RemoteSoundCell.buttonConfig)!
		let button = UIButton(type: .custom)
		button.setImage(image.withTintColor(UIColor.csRed, renderingMode: .alwaysOriginal), for: .normal)
		return button
	}()
	let downloadButton: UIButton = {
		let image = UIImage(systemName: "icloud.and.arrow.down.fill", withConfiguration: RemoteSoundCell.buttonConfig)!
		let button = UIButton(type: .custom)
		button.setImage(image.withTintColor(UIColor.csRed, renderingMode: .alwaysOriginal), for: .normal)
		return button
	}()

	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.addSubview(nameLabel)
		contentView.addSubview(waveformView)
		contentView.addSubview(previewButton)
		contentView.addSubview(downloadButton)

		
		waveformView.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		previewButton.translatesAutoresizingMaskIntoConstraints = false
		downloadButton.translatesAutoresizingMaskIntoConstraints = false
		
		nameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
		waveformView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

		NSLayoutConstraint.activate([
			contentView.heightAnchor.constraint(equalToConstant: 80),

			// vertical
			contentView.topAnchor.constraint(equalTo: waveformView.topAnchor, constant: -6),
			waveformView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -6),
			contentView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
			contentView.topAnchor.constraint(equalTo: previewButton.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: previewButton.bottomAnchor),
			contentView.topAnchor.constraint(equalTo: downloadButton.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: downloadButton.bottomAnchor),
			
			// horizontal
			contentView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
			previewButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
			downloadButton.leadingAnchor.constraint(equalTo: previewButton.trailingAnchor, constant: 10),
			contentView.trailingAnchor.constraint(equalTo: downloadButton.trailingAnchor, constant: 6),
			
			
			nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
			waveformView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7)
		])
		
		previewButton.addTarget(self, action: #selector(previewTapped), for: .touchUpInside)

	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(sound: RemoteSound) {
		self.sound = sound
		
		self.nameLabel.text = sound.name
		self.waveformView.setImage(url: sound.waveformURL.absoluteString,
								   placeholderImage: UIImage.waveform.withTintColor(UIColor.csOrange, renderingMode: .alwaysOriginal))
	}
	
	@objc func previewTapped() {
		if let sound = sound {
			previewCallback?(sound)
		}
	}
}
