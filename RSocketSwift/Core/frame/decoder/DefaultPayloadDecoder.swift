//
//  DefaultPayloadDecoder.swift
//  CNIOAtomics
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/master/rsocket-core/src/main/java/io/rsocket/frame/decoder/DefaultPayloadDecoder.java
*/
public class DefaultPayloadDecoder: PayloadDecoder {
    public func apply(byteBuf: ByteBuffer) -> Payload {
        var m: ByteBuffer?
        var d: ByteBuffer?
        
        // TODO:- Hardcoded the frametype. Need to read it from `FrameCodeSpec`
        let type: FrameType = FrameType.RequestResponse
        
        switch type {
        case .RequestResponse:
            d = RequestResponseFrameCodec.data(byteBuf: &d!)
            m = RequestResponseFrameCodec.metadata(byteBuf: &m!)
        default: break
        }
        
        var data = ByteBufferAllocator().buffer(capacity: d!.capacity)
        data.writeInteger(d!.readableBytes)
//      data.flip(); equivalent on Swift not found
        
        if m != nil {
            var metadata = ByteBufferAllocator().buffer(capacity: d!.capacity)
            metadata.writeInteger(m!.readableBytes)
//          metadata.flip(); equivalent on Swift not found
            return DefaultPayload.create(data: data, metadata: metadata)
            
        }

        return DefaultPayload.create(data: data)
    }
}
