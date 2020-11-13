//
//  DefaultPayload.swift
//  RSocketSwift
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/82241f35a6628430a9ce1ea965ecac58e4a4aca8/rsocket-core/src/main/java/io/rsocket/frame/decoder/DefaultPayloadDecoder.java
*/

public class DefaultPayload: Payload {
    public func hasMetaData() -> Bool {
        return metadata != nil
    }
    
    public func sliceMetaData() -> ByteBuffer {
        return metadata == nil ? ByteBufferAllocator().buffer(capacity: 0) : ByteBufferAllocator().buffer(capacity: metadata!.readableBytes)
    }
    
    public func sliceData() -> ByteBuffer {
        return ByteBufferAllocator().buffer(capacity: dataBuffer.readableBytes)
    }
    
    public func data() -> ByteBuffer {
        return sliceData()
    }
    
    public func metaData() -> ByteBuffer {
        return sliceMetaData()
    }
    
    private let dataBuffer: ByteBuffer
    private let metadata: ByteBuffer?
    
    private init(data: ByteBuffer, metadata: ByteBuffer?) {
        self.dataBuffer = data
        self.metadata = metadata
    }

    public static func create(data: ByteBuffer) -> Payload {
        return create(data: data, metadata: nil)
    }
    
    public static func create(data: ByteBuffer, metadata: ByteBuffer?) -> Payload {
        return DefaultPayload(data: data, metadata: metadata)
    }
}
