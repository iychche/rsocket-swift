//
//  Frame.swift
//  RSocketSwift
//
//  Created by Nathany, Sumit on 21/10/20.
//  Copyright © 2020 Mint.com. All rights reserved.
//

import Foundation

private let FlagsMask: Int = 1023
private let FrameTypeShift: Int = 10

protocol Frame {
	var streamId: Int { get }
}

//abstract class Frame(open val type: FrameType) {
//	abstract val streamId: Int
//	abstract val flags: Int
//
//	protected abstract fun BytePacketBuilder.writeSelf()
//	protected abstract fun StringBuilder.appendFlags()
//	protected abstract fun StringBuilder.appendSelf()
//
//	fun toPacket(): ByteReadPacket {
//		check(type.canHaveMetadata || !(flags check Flags.Metadata)) { "bad value for metadata flag" }
//		return buildPacket {
//			writeInt(streamId)
//			writeShort((type.encodedType shl FrameTypeShift or flags).toShort())
//			writeSelf()
//		}
//	}
//
//	fun dump(length: Long): String = buildString {
//		append("\n").append(type).append(" frame -> Stream Id: ").append(streamId).append(" Length: ").append(length)
//		append("\nFlags: 0b").append(flags.toBinaryString()).append(" (").apply { appendFlags() }.append(")")
//		appendSelf()
//	}
//
//	protected fun StringBuilder.appendFlag(flag: Char, value: Boolean) {
//		append(flag)
//		if (value) append(1) else append(0)
//	}
//}

//fun ByteReadPacket.toFrame(): Frame = use {
//	val streamId = readInt()
//	val typeAndFlags = readShort().toInt() and 0xFFFF
//	val flags = typeAndFlags and FlagsMask
//	when (val type = FrameType(typeAndFlags shr FrameTypeShift)) {
//		//stream id = 0
//		FrameType.Setup           -> readSetup(flags)
//		FrameType.Resume          -> readResume()
//		FrameType.ResumeOk        -> readResumeOk()
//		FrameType.MetadataPush    -> readMetadataPush()
//		FrameType.Lease           -> readLease(flags)
//		FrameType.KeepAlive       -> readKeepAlive(flags)
//		//stream id != 0
//		FrameType.Cancel          -> CancelFrame(streamId)
//		FrameType.Error           -> readError(streamId)
//		FrameType.RequestN        -> readRequestN(streamId)
//		FrameType.Extension       -> readExtension(streamId, flags)
//		FrameType.Payload,
//		FrameType.RequestFnF,
//		FrameType.RequestResponse -> readRequest(type, streamId, flags, withInitial = false)
//		FrameType.RequestStream,
//		FrameType.RequestChannel  -> readRequest(type, streamId, flags, withInitial = true)
//		FrameType.Reserved        -> error("Reserved")
//	}
//}
//
//fun ByteReadPacket.dumpFrameToString(): String {
//	val length = remaining
//	val frame = copy().toFrame()
//	return frame.dump(length)
//}

