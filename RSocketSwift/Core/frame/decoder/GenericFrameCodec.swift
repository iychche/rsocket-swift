//
//  GenericFrameCodec.swift
//  RSocketSwift
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/master/rsocket-core/src/main/java/io/rsocket/frame/GenericFrameCodec.java
*/
public class GenericFrameCodec {
    init() {}

    public static func data(byteBuf: inout ByteBuffer) -> ByteBuffer {
        let hasMetaData = FrameHeaderCodec.hasMetaData(byteBuf)
        let idx = byteBuf.readerIndex
        byteBuf.moveReaderIndex(to: 0)
        byteBuf.moveReaderIndex(forwardBy: FrameHeaderCodec.size())
        let data = FrameBodyCodec.dataWithoutMarking(byteBuf: byteBuf, hasMetadata: hasMetaData)
        byteBuf.moveReaderIndex(forwardBy: idx)
        
        return data
    }
    
    public static func metadata(byteBuf: inout ByteBuffer) -> ByteBuffer? {
        let hasMetaData = FrameHeaderCodec.hasMetaData(byteBuf)
        
        guard hasMetaData else { return nil }
        
        byteBuf.moveReaderIndex(to: 0)
        byteBuf.moveReaderIndex(forwardBy: FrameHeaderCodec.size())
        let metaData = FrameBodyCodec.metadataWithoutMarking(byteBuf: byteBuf)
        byteBuf.moveReaderIndex(to: 0)
        
        return metaData
    }
}
