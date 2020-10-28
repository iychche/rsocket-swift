//
//  RequestResponseFrameCodec.swift
//  CNIOAtomics
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO


/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/master/rsocket-core/src/main/java/io/rsocket/frame/RequestResponseFrameCodec.java
*/
public class RequestResponseFrameCodec {
    init() {}

    public static func data(byteBuf: inout ByteBuffer) -> ByteBuffer {
        return GenericFrameCodec.data(byteBuf: &byteBuf)
    }
    
    public static func metadata(byteBuf: inout ByteBuffer) -> ByteBuffer {
        return GenericFrameCodec.metadata(byteBuf: &byteBuf)!
    }
}
