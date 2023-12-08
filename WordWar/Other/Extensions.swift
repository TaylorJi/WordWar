//
//  Extensions.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import Foundation

extension Encodable {
    // add new functionality to an existing class, struct, enumeration, or protocol type
    // convert an instance of any type that conforms to the Encodable protocol into a dictionary of type [String: Any].
   func asDictionary() -> [String: Any] {
      guard let data = try? JSONEncoder().encode(self) else {
         return [:]
      }
      
      do {
         let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
         return json ?? [:]
      } catch {
         return [:]
      }
               
   }
}
