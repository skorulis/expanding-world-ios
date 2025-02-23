//Created by Alexander Skorulis on 23/2/2025.

import Testing
@testable import ExpandingWorld

struct TimeFormatterTests {
    
    @Test func formatting() {
        let formatter = TimeFormatter()
        #expect(formatter.format(time: 0) == "00:00")
        #expect(formatter.format(time: 60) == "00:01")
        #expect(formatter.format(time: 3600) == "01:00")
        #expect(formatter.format(time: 86000) == "23:53")
    }
}
