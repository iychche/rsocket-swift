//
//  CancelFrame.swift
//  RSocketSwift
//
//  Created by Nathany, Sumit on 21/10/20.
//

import Foundation

public class CancelFrame: Frame {
	let frame: FrameType
	var streamId: Int

	init(frame: FrameType, streamId: Int) {
		self.frame = frame
		self.streamId = streamId
	}
}
