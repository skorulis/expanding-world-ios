//Created by Alexander Skorulis on 23/2/2025.

import Foundation

struct TimeFormatter {
    
    static let `default` = TimeFormatter()
    
    static let hourLength: Int64 = 3600
    static let dayLength: Int64 = 86400
    
    func format(time: Int64) -> String {
        let remainder = time % Self.dayLength
        let hour = remainder / Self.hourLength
        let minutes = (remainder - hour * Self.hourLength) / 60
        let hourString = String(format: "%02d", hour)
        let minutesString = String(format: "%02d", minutes)
        return "\(hourString):\(minutesString)"
    }
}
