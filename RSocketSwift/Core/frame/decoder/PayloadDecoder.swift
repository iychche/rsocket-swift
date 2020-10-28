//
//  PayloadDecoder.swift
//  CNIOAtomics
//
//  Created by wsyed1  on 10/27/20.
//

import Foundation
import NIO

/**TODO:- This is just for design. The full implementation need to be based on https://github.com/rsocket/rsocket-java/blob/82241f35a6628430a9ce1ea965ecac58e4a4aca8/rsocket-core/src/main/java/io/rsocket/frame/decoder/PayloadDecoder.java
 */

public protocol PayloadDecoderProtocol {
    var defaultPayloadDecoder: PayloadDecoder { get set }
    var zeroCopyPayloadDecoder: PayloadDecoder { get set }
}

public class PayloadDecoder: PayloadDecoderProtocol {
    public var defaultPayloadDecoder: PayloadDecoder = DefaultPayloadDecoder()
    public var zeroCopyPayloadDecoder: PayloadDecoder = ZeroCopyPayloadDecoder()
}
