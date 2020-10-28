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
    private static let frameLengthMask =  0xFFFFFF
    
    public static func dataWithoutMarking(byteBuf: ByteBuffer, hasMetadata: Bool) -> ByteBuffer {
        return ByteBuffer(string: "")
    }
  
    public static func metadataWithoutMarking(byteBuf: ByteBuffer) -> ByteBuffer {
        return ByteBuffer(string: "")
    }
    
    public static func encode(_ allocator: ByteBufferAllocator,
                         header: ByteBuffer,
                         metadata: ByteBuffer?,
                         hasMetadata: Bool,
                         data: ByteBuffer?) -> ByteBuffer {
        var header = header
        let addData: Bool
        if let data = data {
            if (data.writerIndex - data.readerIndex) > 0 {
                addData = true
            } else {
//                data.release() // No equivalent function in Swift
                addData = false
            }
        } else {
            addData = false
        }
        
        let addMetadata: Bool
        
        if hasMetadata, let metadata = metadata {
            if (metadata.writerIndex - metadata.readerIndex) > 0 {
                addMetadata = true
            } else {
                //                metadata.release() // No equivalent function in Swift
                addMetadata = false
            }
        } else {
            addMetadata = false
        }
        
        if hasMetadata {
            let length = metadata!.readableBytes
            encodeLength(&header, length: length)
        }
        
        if addMetadata && addData {
            var newByteBuffer = ByteBufferAllocator().buffer(capacity: 3)
            var data = data!
            var metadata = metadata!
            
            newByteBuffer.writeBuffer(&header)
            newByteBuffer.moveWriterIndex(to: header.capacity)
            newByteBuffer.writeBuffer(&data)
            newByteBuffer.moveWriterIndex(to: data.capacity)
            newByteBuffer.writeBuffer(&metadata)
            newByteBuffer.moveWriterIndex(to: metadata.capacity)
            
            return newByteBuffer
        } else if addMetadata {
            var newByteBuffer = ByteBufferAllocator().buffer(capacity: 3)
            var metadata = metadata!
            
            newByteBuffer.writeBuffer(&header)
            newByteBuffer.moveWriterIndex(to: header.capacity)
            newByteBuffer.writeBuffer(&metadata)
            newByteBuffer.moveWriterIndex(to: metadata.capacity)
            
            return newByteBuffer
        } else if addData {
            var newByteBuffer = ByteBufferAllocator().buffer(capacity: 3)
            var data = data!
            
            newByteBuffer.writeBuffer(&header)
            newByteBuffer.moveWriterIndex(to: header.capacity)
            newByteBuffer.writeBuffer(&data)
            newByteBuffer.moveWriterIndex(to: data.capacity)
            
            return newByteBuffer
        } else {
            return header
        }
    }
}

private extension FrameBodyCodec {
    static func encodeLength(_ byteBuf: inout ByteBuffer, length: Int) {
        if (length & frameLengthMask) != 0 {
            assertionFailure("Length is larger than 24 bits")
        } else {
            byteBuf.writeInteger(length >> 16)
            byteBuf.writeInteger(length >> 8)
            byteBuf.writeInteger(length)
        }
    }
}

