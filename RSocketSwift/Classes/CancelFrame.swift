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


//class CancelFrame(
//override val streamId: Int,
//) : Frame(FrameType.Cancel) {
//	override val flags: Int get() = 0
//	override fun BytePacketBuilder.writeSelf(): Unit = Unit
//
//	override fun StringBuilder.appendFlags(): Unit = Unit
//	override fun StringBuilder.appendSelf(): Unit = Unit
//}
