//
//  ErrorFrameCodec.swift
//  RSocketSwift
//
//  Created by npatil5  on 10/29/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
 https://github.com/rsocket/rsocket-java/blob/82241f35a6628430a9ce1ea965ecac58e4a4aca8/rsocket-core/src/main/java/io/rsocket/frame/ErrorFrameCodec.java
*/

public class ErrorFrameCodec {
    
    // defined zero stream id error codes
    public static let INVALID_SETUP = 0x00000001
    public static let UNSUPPORTED_SETUP = 0x00000002
    public static let REJECTED_SETUP = 0x00000003
    public static let REJECTED_RESUME = 0x00000004
    public static let CONNECTION_ERROR = 0x00000101
    public static let CONNECTION_CLOSE = 0x00000102
    // defined non-zero stream id error codes
    public static let APPLICATION_ERROR = 0x00000201
    public static let REJECTED = 0x00000202
    public static let CANCELED = 0x00000203
    public static let INVALID = 0x00000204
    // defined user-allowed error codes range
    public static let MIN_USER_ALLOWED_ERROR_CODE = 0x00000301
    public static let MAX_USER_ALLOWED_ERROR_CODE = 0xFFFFFFFE
    
    public static func encode(_ allocator: ByteBufferAllocator, streamId: Int, data: ByteBuffer) -> ByteBuffer {
        var data = data
        var header = FrameHeaderCodec.encode(allocator, streamId: streamId, frameTypeEncodeType: FrameType.Flags.EMPTY, frameType: FrameType.Error, flags: 0)
        
        let errorCode = 0 //TODO
            
        header.writeInteger(errorCode)
        
        var compositeByteBuffer = ByteBufferAllocator().buffer(capacity: 2)
        compositeByteBuffer.writeBuffer(&header)
        compositeByteBuffer.moveWriterIndex(to: header.capacity)
        compositeByteBuffer.writeBuffer(&data)
        compositeByteBuffer.moveWriterIndex(to: data.capacity)
        
        return compositeByteBuffer
        
        /*ByteBuf header = FrameHeaderCodec.encode(allocator, streamId, FrameType.ERROR, 0);

        int errorCode =
            t instanceof RSocketErrorException
                ? ((RSocketErrorException) t).errorCode()
                : APPLICATION_ERROR;

        header.writeInt(errorCode);

        return allocator.compositeBuffer(2).addComponents(true, header, data);*/
    }
    
    public static func encode(_ allocator: ByteBufferAllocator, streamId: Int) {
        
        //TODO
        
    }
    
    /*public static ByteBuf encode(ByteBufAllocator allocator, int streamId, Throwable t) {
      String message = t.getMessage() == null ? "" : t.getMessage();
      ByteBuf data = ByteBufUtil.writeUtf8(allocator, message);
      return encode(allocator, streamId, t, data);
    }*/
    
    public static func errorCode( byteBuf: inout ByteBuffer) -> Int {
        
        byteBuf.moveReaderIndex(to: 0)
        byteBuf.moveReaderIndex(to: FrameHeaderCodec.size())
        let i = byteBuf.readerIndex
        byteBuf.moveReaderIndex(to: 0)
        return i
    }
    
    /*public static int errorCode(ByteBuf byteBuf) {
      byteBuf.markReaderIndex();
      byteBuf.skipBytes(FrameHeaderCodec.size());
      int i = byteBuf.readInt();
      byteBuf.resetReaderIndex();
      return i;
    }*/
    
    public static func data( byteBuf: inout ByteBuffer) -> ByteBuffer {
        
        byteBuf.moveReaderIndex(to: 0)
        byteBuf.moveReaderIndex(to: FrameHeaderCodec.size() + 4)
        let slice = byteBuf.slice()
        byteBuf.moveReaderIndex(to: 0)
        return slice
    }
    
    /*public static ByteBuf data(ByteBuf byteBuf) {
      byteBuf.markReaderIndex();
      byteBuf.skipBytes(FrameHeaderCodec.size() + Integer.BYTES);
      ByteBuf slice = byteBuf.slice();
      byteBuf.resetReaderIndex();
      return slice;
    }*/
    
    public static func dataUtf8(byteBuf: inout ByteBuffer) -> String {
        return "\(data(byteBuf: &byteBuf))"
    }
    
    /*public static String dataUtf8(ByteBuf byteBuf) {
      return data(byteBuf).toString(StandardCharsets.UTF_8);
    }*/
}
