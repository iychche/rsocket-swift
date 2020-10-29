//
//  RSocketErrorException.swift
//  RSocketSwift
//
//  Created by npatil5  on 10/29/20.
//

import Foundation

/**TODO:- This is just for design. The full implementation need to be based on
https://github.com/rsocket/rsocket-java/blob/82241f35a6628430a9ce1ea965ecac58e4a4aca8/rsocket-core/src/main/java/io/rsocket/RSocketErrorException.java
*/

public class RSocketErrorException {
    
    //private static let serialVersionUID: Int64 = -1628781753426267554L

    private static let MIN_ERROR_CODE = 0x00000001

    private static let MAX_ERROR_CODE = 0xFFFFFFFE

    private let errorCode: Int
    
   public init(errorCode: Int, message: String)  throws {
        self.errorCode = errorCode
        if errorCode > RSocketErrorException.MAX_ERROR_CODE && errorCode < RSocketErrorException.MIN_ERROR_CODE {
            
        }
    }
    public func getErrorCode() -> Int {
      return errorCode
    }
    
}
