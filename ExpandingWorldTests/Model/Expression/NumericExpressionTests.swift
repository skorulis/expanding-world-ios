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
    
    @Test func lessThan() {
        #expect(calculate { 4.c < 5.c} == 1)
        #expect(calculate { 6.c < 5.c} == 0)
    }
    
    @Test func greaterThanOrEqual() {
        #expect(calculate { 1.c >= 1.c} == 1)
        #expect(calculate { 0.c >= 0.c} == 1)
        #expect(calculate { 0.c >= 0.5.c} == 0)
    }
    
    @Test func statusValue() {
        #expect(calculate { Player.Status.intoxication.v * 6.c } == 30)
    }
    
    private func calculate(
        context: NumericExpression.Context = .fixed,
        @ExpressionBuilder _ builder: () -> NumericExpression
    ) -> Double {
        return builder().evaluate(context)
    }
}

extension NumericExpression.Context {
    static var fixed: Self {
        .init(status: { _ in 5 })
    }
}
