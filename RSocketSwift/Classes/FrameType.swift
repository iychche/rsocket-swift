//
//  FrameType.swift
//  RSocketSwift
//
//  Created by Nathany, Sumit on 21/10/20.
//

import Foundation
import NIO

public enum FrameType: Int {
    case Reserved = 0x00

    //CONNECTION
    case Setup = 0x01 // Flags.CanHaveData or Flags.CanHaveMetadata),
    case Lease = 0x02 // Flags.CanHaveMetadata),
    case KeepAlive = 0x03 // Flags.CanHaveData),

    // METADATA
    case MetadataPush = 0x0C //, Flags.CanHaveMetadata),

    //REQUEST
    case RequestFnF = 0x05 //, Flags.CanHaveData or Flags.CanHaveMetadata or Flags.Fragmentable or Flags.Request),
    case RequestResponse = 0x04 //, Flags.CanHaveData or Flags.CanHaveMetadata or Flags.Fragmentable or Flags.Request),
    case RequestStream = 0x06 //, Flags.CanHaveMetadata or Flags.CanHaveData or Flags.HasInitialRequest or Flags.Fragmentable or Flags.Request),
    case RequestChannel = 0x07 //, Flags.CanHaveMetadata or Flags.CanHaveData or Flags.HasInitialRequest or Flags.Fragmentable or Flags.Request),

    // DURING REQUEST
    case RequestN = 0x08 //,
    case Cancel = 0x09 //,

    // RESPONSE
    case Payload = 0x0A //, Flags.CanHaveData or Flags.CanHaveMetadata or Flags.Fragmentable),
    case Error = 0x0B //, Flags.CanHaveData),

    // RESUMPTION
    case Resume = 0x0D //,
    case ResumeOk = 0x0E //),

    case Extension = 0x3F //, Flags.CanHaveData or Flags.CanHaveMetadata);
    
    /**
     * Verifies whether the frame type can have data.
     - Parameter flags: Flags constant.
     - Returns: whether the frame type can have data
     */
    public func canHaveData(_ flags: Flags) -> Bool {
        return Flags.CAN_HAVE_DATA.rawValue == (flags.rawValue & Flags.CAN_HAVE_DATA.rawValue)
    }
    
    /**
     * Verifies whether the frame type can have metadata
     - Parameter flags: Flags constant.
     - Returns: whether the frame type can have metadata
     */
    public func canHaveMetaData(_ flags: Flags) -> Bool {
        return Flags.CAN_HAVE_METADATA.rawValue == (flags.rawValue & Flags.CAN_HAVE_METADATA.rawValue)
    }
    
    /**
     * Verifies whether the frame type starts with an initial {@code requestN}.
     - Parameter flags: Flags constant.
     - Returns: wether the frame type starts with an initial {@code requestN}
     */
    public func hasInitialRequestN(_ flags: Flags) -> Bool {
        return Flags.HAS_INITIAL_REQUEST_N.rawValue == (flags.rawValue & Flags.HAS_INITIAL_REQUEST_N.rawValue)
    }
    
   /**
    Verifies whether the frame type is fragmentable.
    - Parameter flags: Flags constant.
    - Returns: whether the frame type is fragmentable
    */
    public func isFragmentable(_ flags: Flags) -> Bool {
        return Flags.IS_FRAGMENTABLE.rawValue == (flags.rawValue & Flags.IS_FRAGMENTABLE.rawValue)
    }
    
    /**
    Verifies whether the frame type is a request type.
    - Parameter flags: Flags constant.
    - Returns: whether the frame type is a request type
    */
    public func isRequestType(_ flags: Flags) -> Bool {
        return Flags.IS_REQUEST_TYPE.rawValue == (flags.rawValue & Flags.IS_REQUEST_TYPE.rawValue)
    }
    
    public enum Flags: Int {
        case EMPTY = 0b00000
        case CAN_HAVE_DATA = 0b10000
        case CAN_HAVE_METADATA = 0b01000
        case IS_FRAGMENTABLE = 0b00100
        case IS_REQUEST_TYPE = 0b00010
        case HAS_INITIAL_REQUEST_N = 0b00001
    }


//    val hasInitialRequest: Boolean = flags check Flags.HasInitialRequest
//    val isRequestType: Boolean = flags check Flags.Request
//    val isFragmentable: Boolean = flags check Flags.Fragmentable
//    val canHaveMetadata: Boolean = flags check Flags.CanHaveMetadata
//    val canHaveData: Boolean = flags check Flags.CanHaveData

//    private object Flags {
//        const val Empty = 0
//        const val HasInitialRequest = 1
//        const val Request = 2
//        const val Fragmentable = 4
//        const val CanHaveMetadata = 8
//        const val CanHaveData = 16
//    }
//
//    companion object {
//        private val encodedTypes: Array<FrameType?>
//
//        init {
//            val maximumEncodedType = values().map(FrameType::encodedType).maxOrNull() ?: 0
//            encodedTypes = arrayOfNulls(maximumEncodedType + 1)
//            values().forEach { encodedTypes[it.encodedType] = it }
//        }
//
//        operator fun invoke(encodedType: Int): FrameType =
//        encodedTypes[encodedType] ?: throw IllegalArgumentException("Frame type $encodedType is unknown")
//    }
}




