//
//  FrameBodyCodec.swift
//  RSocketSwift
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/master/rsocket-core/src/main/java/io/rsocket/frame/FrameBodyCodec.java
*/
public class FrameBodyCodec {
  public static func dataWithoutMarking(byteBuf: ByteBuffer, hasMetadata: Bool) -> ByteBuffer {
    return ByteBuffer(string: "")
  }
  public static func metadataWithoutMarking(byteBuf: ByteBuffer) -> ByteBuffer {
    return ByteBuffer(string: "")
  }
}
