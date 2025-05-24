//  Created by Alexander Skorulis on 24/5/2025.

import Foundation

public struct SkillDictionary: Sendable, Codable {
    public private(set) var skills: [Skill: Int] = [:]
    
    public init(_ skills: [Skill: Int] = [:]) {
        self.skills = skills
    }
    
    public func value(_ skill: Skill) -> Int {
        skills[skill] ?? 0
    }
    
    public mutating func set(skill: Skill, value: Int) {
        self.skills[skill] = value
    }
}
