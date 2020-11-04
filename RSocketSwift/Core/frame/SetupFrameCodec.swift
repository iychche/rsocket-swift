//
//  SetupFrameCodec.swift
//  RSocketSwift
//
//  Created by npatil5  on 11/4/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on
https://github.com/rsocket/rsocket-java/blob/d903e9635a159285b6943ea93156c31aa406ba5d/rsocket-core/src/main/java/io/rsocket/frame/SetupFrameCodec.java
*/

public class SetupFrameCodec {
    
    /**
     * A flag used to indicate that the client requires connection resumption, if possible (the frame
     * contains a Resume Identification Token)
     */
    public static var FLAGS_RESUME_ENABLE = 0b00_1000_0000
    /** A flag used to indicate that the client will honor LEASE sent by the server */
    public static var FLAGS_WILL_HONOR_LEASE = 0b00_0100_0000
    public static var CURRENT_VERSION = VersionCodec.encode(major: 1, minor: 0)
    private static var VERSION_FIELD_OFFSET = FrameHeaderCodec.size()
    private static var KEEPALIVE_INTERVAL_FIELD_OFFSET = VERSION_FIELD_OFFSET + 4
    private static var KEEPALIVE_MAX_LIFETIME_FIELD_OFFSET = KEEPALIVE_INTERVAL_FIELD_OFFSET + 4
    private static var VARIABLE_DATA_OFFSET = KEEPALIVE_MAX_LIFETIME_FIELD_OFFSET + 4
    
    
    public static func encode(_ allocator: ByteBufferAllocator,
                              lease: Bool,
                              keepaliveInterval: Int,
                              maxLifetime: Int,
                              metadataMimeType: String,
                              dataMimeType: String,
                              setupPayload: Payload) -> ByteBuffer {
        
        return encode(allocator, lease: lease, keepaliveInterval: keepaliveInterval, maxLifetime: maxLifetime, resumeToken: Unpooled.EMPTY_BUFFER, metadataMimeType: metadataMimeType, dataMimeType: dataMimeType, setupPayload: setupPayload)
        
    }
    
    public static func encode(_ allocator: ByteBufferAllocator,
                              lease: Bool,
                              keepaliveInterval: Int,
                              maxLifetime: Int,
                              resumeToken: inout ByteBuffer,
                              metadataMimeType: String,
                              dataMimeType: String,
                              setupPayload: Payload) -> ByteBuffer {
        
        let data: ByteBuffer = setupPayload.sliceData()
        let hasMetadata: Bool = setupPayload.hasMetaData()
        let metaData: ByteBuffer? = hasMetadata ? setupPayload.sliceMetaData() : nil
        
        var flags = 0
        
        if resumeToken.readableBytes > 0 {
            flags |= FLAGS_RESUME_ENABLE
        }
        
        if lease {
            flags |= FLAGS_WILL_HONOR_LEASE
        }
        
        if hasMetadata {
            flags |= FrameHeaderCodec.FLAGS_M
        }
        
        var header = FrameHeaderCodec.encodeStreamZero(allocator, frameType: FrameType.Setup, flags: flags)
        header.writeInteger(CURRENT_VERSION)
        header.writeInteger(keepaliveInterval)
        header.writeInteger(maxLifetime)

        if (flags & FLAGS_RESUME_ENABLE) != 0 {
            resumeToken.moveReaderIndex(to: 0)
            header.writeInteger(resumeToken.readableBytes)
            header.writeBuffer(&resumeToken)
            resumeToken.moveReaderIndex(to: 0)
        }
        
       //TODO
       /* // Write metadata mime-type
        int length = ByteBufUtil.utf8Bytes(metadataMimeType);
        header.writeByte(length);
        ByteBufUtil.writeUtf8(header, metadataMimeType);

        // Write data mime-type
        length = ByteBufUtil.utf8Bytes(dataMimeType);
        header.writeByte(length);
        ByteBufUtil.writeUtf8(header, dataMimeType);*/

    
        return FrameBodyCodec.encode(allocator, header: header, metadata: metaData, hasMetadata: hasMetadata, data: data)
    }
    
   /* public static ByteBuf encode(
        final ByteBufAllocator allocator,
        final boolean lease,
        final int keepaliveInterval,
        final int maxLifetime,
        final ByteBuf resumeToken,
        final String metadataMimeType,
        final String dataMimeType,
        final Payload setupPayload) {

      final ByteBuf data = setupPayload.sliceData();
      final boolean hasMetadata = setupPayload.hasMetadata();
      final ByteBuf metadata = hasMetadata ? setupPayload.sliceMetadata() : null;

      int flags = 0;

      if (resumeToken.readableBytes() > 0) {
        flags |= FLAGS_RESUME_ENABLE;
      }

      if (lease) {
        flags |= FLAGS_WILL_HONOR_LEASE;
      }

      if (hasMetadata) {
        flags |= FrameHeaderCodec.FLAGS_M;
      }

      final ByteBuf header = FrameHeaderCodec.encodeStreamZero(allocator, FrameType.SETUP, flags);

      header.writeInt(CURRENT_VERSION).writeInt(keepaliveInterval).writeInt(maxLifetime);

      if ((flags & FLAGS_RESUME_ENABLE) != 0) {
        resumeToken.markReaderIndex();
        header.writeShort(resumeToken.readableBytes()).writeBytes(resumeToken);
        resumeToken.resetReaderIndex();
      }

      // Write metadata mime-type
      int length = ByteBufUtil.utf8Bytes(metadataMimeType);
      header.writeByte(length);
      ByteBufUtil.writeUtf8(header, metadataMimeType);

      // Write data mime-type
      length = ByteBufUtil.utf8Bytes(dataMimeType);
      header.writeByte(length);
      ByteBufUtil.writeUtf8(header, dataMimeType);

      return FrameBodyCodec.encode(allocator, header, metadata, hasMetadata, data);
    }*/
    
    /*public static ByteBuf encode(
        final ByteBufAllocator allocator,
        final boolean lease,
        final int keepaliveInterval,
        final int maxLifetime,
        final String metadataMimeType,
        final String dataMimeType,
        final Payload setupPayload) {
      return encode(
          allocator,
          lease,
          keepaliveInterval,
          maxLifetime,
          Unpooled.EMPTY_BUFFER,
          metadataMimeType,
          dataMimeType,
          setupPayload);
    }*/
}

