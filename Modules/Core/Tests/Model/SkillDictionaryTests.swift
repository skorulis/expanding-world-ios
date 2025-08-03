//  Created by Alexander Skorulis on 25/5/2025.

import Core
import Testing

struct SkillDictionaryTests {
    
    @Test func addXP() {
        var skills = SkillDictionary()
        skills.set(skill: .unarmed, value: 1)
        skills.add(skill: .unarmed, xp: 45)
        
        #expect(skills.value(.unarmed) == 1)
        #expect(skills.xp(.unarmed) == 45)
        
        skills.add(skill: .unarmed, xp: 5)
        #expect(skills.value(.unarmed) == 2)
        #expect(skills.xp(.unarmed) == 0)
    }
    
    @Test func multipleLevelGain() {
        var skills = SkillDictionary()
        skills.set(skill: .unarmed, value: 1)
        skills.add(skill: .unarmed, xp: 200)
        #expect(skills.value(.unarmed) == 3)
        #expect(skills.xp(.unarmed) == 50)
    }
    
    @Test func totalLevel() {
        var skills = SkillDictionary()
        skills.set(skill: .unarmed, value: 3)
        skills.set(skill: .toughness, value: 2)
        
        #expect(skills.totalLevel == 3)
        
    }
    
}
