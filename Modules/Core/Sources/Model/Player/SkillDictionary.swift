//  Created by Alexander Skorulis on 24/5/2025.

import Foundation

public struct SkillDictionary: Sendable, Codable {
    public private(set) var skills: [Skill: Int] = [:]
    private var skillXP: [Skill: Int] = [:]
    
    public init(_ skills: [Skill: Int] = [:]) {
        self.skills = skills
    }
    
    public func value(_ skill: Skill) -> Int {
        skills[skill] ?? 0
    }
    
    public mutating func set(skill: Skill, value: Int) {
        self.skills[skill] = value
    }
    
    public func xp(_ skill: Skill) -> Int {
        return skillXP[skill] ?? 0
    }
    
    public mutating func add(skill: Skill, xp: Int) {
        skillXP[skill] = self.xp(skill) + xp
        while remainingXP(skill: skill) <= 0 {
            let newXP = (skillXP[skill] ?? 0) - neededXP(skill: skill)
            skillXP[skill] = newXP
            self.set(skill: skill, value: value(skill) + 1)
        }
    }
    
    public func neededXP(skill: Skill) -> Int {
        let level = skills[skill] ?? 0
        return SkillXPTable.xp(forLevel: level + 1)
    }
    
    public func remainingXP(skill: Skill) -> Int {
        return neededXP(skill: skill) - xp(skill)
    }
    
    public func isKnown(skill: Skill) -> Bool {
        return skills[skill] != nil
    }

    public func state(skill: Skill) -> SkillState {
        return SkillState(
            level: value(skill),
            xp: xp(skill)
        )
    }
    
    public var totalLevel: Int {
        return 1 + skills.values.map { max($0 - 1, 0) }.reduce(0, +)
    }
    
}

public struct SkillState: Sendable, Codable {
    public let level: Int
    public let xp: Int
    
    public var neededXP: Int {
        SkillXPTable.xp(forLevel: level + 1)
    }
    
    public var remainingXP: Int {
        neededXP - xp
    }
    
    public init(level: Int, xp: Int) {
        self.level = level
        self.xp = xp
    }
}


enum SkillXPTable {
    
    static let fixedTable: [Int: Int] = [
        1: 0, // Level 1 should be granted automatically
        2: 50,
        3: 100,
        4: 500,
        5: 1000,
        6: 2000,
        7: 4000,
        8: 8000,
        9: 16000,
        10: 32000
    ]
    
    static func xp(forLevel level: Int) -> Int {
        // TODO: Add calculations for higher levels
        return fixedTable[level] ?? 5000000
    }
}
