//
//  FrameHeaderCodec.swift
//  RSocketSwift
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/master/rsocket-core/src/main/java/io/rsocket/frame/FrameHeaderCodec.java
*/

public class FrameHeaderCodec {
//    let headerSize = Integer.BYTES + Short.BYTES
    
    /** (I)gnore flag: a value of 0 indicates the protocol can't ignore this frame */
    public static  var FLAGS_I: Int = 0b10_0000_0000
    /** (M)etadata flag: a value of 1 indicates the frame contains metadata */
    public static  var FLAGS_M: Int = 0b01_0000_0000
    /**
     * (F)ollows: More fragments follow this fragment (in case of fragmented REQUEST_x or PAYLOAD
     * frames)
     */
    public static var FLAGS_F: Int = 0b00_1000_0000
    /** (C)omplete: bit to indicate stream completion ({@link Subscriber#onComplete()}) */
    public static var FLAGS_C: Int = 0b00_0100_0000
    /** (N)ext: bit to indicate payload or metadata present ({@link Subscriber#onNext(Object)}) */
    public static var FLAGS_N: Int = 0b00_0010_0000
    public static var DISABLE_FRAME_TYPE_CHECK = "io.rsocket.frames.disableFrameTypeCheck";
    private static var FRAME_FLAGS_MASK = 0b0000_0011_1111_1111
    private static var FRAME_TYPE_BITS = 6
    private static var FRAME_TYPE_SHIFT = 16 - FRAME_TYPE_BITS
    
    public static func hasMetaData(_ byteBuf: ByteBuffer) -> Bool {
        return true
    }
    
    public static func flags( byteBuf: inout ByteBuffer) -> Int {
        return 0
    }
    
    public static func size() -> Int {
        return 6
    }
    
    public static func encode(_ allocator: ByteBufferAllocator,
                              streamId: Int,
                              frameTypeEncodeType: Int,
                              frameType: FrameType,
                              flags: Int) -> ByteBuffer {
        if !frameType.canHaveMetaData(FrameType.Flags(rawValue: flags)!) && (flags & FLAGS_M) == FLAGS_M {
            fatalError("bad value for metadata flag")
        }
        
        let typeAndFlagsShort: Int16 = Int16(frameTypeEncodeType << FRAME_TYPE_SHIFT) | Int16(flags)
        let typeAndFlagsInt: Int = Int(typeAndFlagsShort)
        
        let fullCapacity = streamId + typeAndFlagsInt
        var buffer = allocator.buffer(capacity: fullCapacity)
        buffer.writeInteger(streamId)
        buffer.moveWriterIndex(to: streamId)
        buffer.writeInteger(typeAndFlagsInt)
        buffer.moveWriterIndex(to: typeAndFlagsInt)
        
        return buffer
    }
}
