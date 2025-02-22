//Created by Alexander Skorulis on 22/2/2025.

import Testing
@testable import ExpandingWorld

struct NumericExpressionTests {
    
    @Test func addition() {
        #expect(calculate { 5.c + 10.c } == 15)
        #expect(calculate { 1.c + 2.c + 3.c + 4.c } == 10)
    }
    
    @Test func orderOfOperations() {
        #expect(calculate { 5.c + 10.c * 5.c } == 55)
        #expect(calculate { 1.c * 5.c - 5.c } == 0)
    }
    
    private func calculate(@ExpressionBuilder _ builder: () -> NumericExpression) -> Double {
        return builder().evaluate()
    }
}
