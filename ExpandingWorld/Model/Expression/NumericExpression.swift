//Created by Alexander Skorulis on 22/2/2025.

import Foundation

extension NumericExpression {
    static func +(lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.add(lhs, rhs)
    }

    static func -(lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.subtract(lhs, rhs)
    }

    static func *(lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.multiply(lhs, rhs)
    }

    static func /(lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.divide(lhs, rhs)
    }
}

extension Double {
    var c: NumericExpression { return NumericExpression.number(self) }
}

indirect enum NumericExpression {
    case number(Double)
    case add(NumericExpression, NumericExpression)
    case subtract(NumericExpression, NumericExpression)
    case multiply(NumericExpression, NumericExpression)
    case divide(NumericExpression, NumericExpression)

    func evaluate() -> Double {
        switch self {
        case .number(let value):
            return value
        case .add(let lhs, let rhs):
            return lhs.evaluate() + rhs.evaluate()
        case .subtract(let lhs, let rhs):
            return lhs.evaluate() - rhs.evaluate()
        case .multiply(let lhs, let rhs):
            return lhs.evaluate() * rhs.evaluate()
        case .divide(let lhs, let rhs):
            return lhs.evaluate() / rhs.evaluate()
        }
    }
}

@resultBuilder
struct ExpressionBuilder {
    static func buildBlock(_ components: NumericExpression...) -> NumericExpression {
        return components.reduce(NumericExpression.number(0)) { $0 + $1 }
    }
}
