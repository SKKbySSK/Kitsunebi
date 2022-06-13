//
//  File.swift
//  
//
//  Created by Kaisei Sunaga on 2022/06/13.
//

import Foundation

public protocol LoggerDelegate: AnyObject {
  func didEmit(log: String, userInfo: [String: Any?])
}

public class Logger {
  private init() {}
  
  public static let shared = Logger()
  
  private let logQueue: DispatchQueue = .global(qos: .background)
  public weak var delegate: LoggerDelegate?
  
  func log(_ log: String, userInfo: [String: Any?] = [:]) {
    logQueue.async { [weak self] in
      self?.delegate?.didEmit(log: log, userInfo: userInfo)
    }
  }
}
