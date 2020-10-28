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
    
    public static func hasMetaData(_ byteBuf: ByteBuffer) -> Bool {
        return true
    }
    
    public static func flags( byteBuf: inout ByteBuffer) -> Int {
        return 0
    }
    
    public static func size() -> Int {
        return 6
    }
}
