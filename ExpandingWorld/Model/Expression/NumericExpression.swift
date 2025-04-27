//Created by Alexander Skorulis on 22/2/2025.

import Core
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
    
    static func < (lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.lessThan(lhs, rhs)
    }
    
    static func > (lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.greaterThan(lhs, rhs)
    }
    
    static func >= (lhs: NumericExpression, rhs: NumericExpression) -> NumericExpression {
        return NumericExpression.greaterThanOrEqual(lhs, rhs)
    }
}

indirect enum NumericExpression {
    case number(Double)
    case add(NumericExpression, NumericExpression)
    case subtract(NumericExpression, NumericExpression)
    case multiply(NumericExpression, NumericExpression)
    case divide(NumericExpression, NumericExpression)
    case lessThan(NumericExpression, NumericExpression)
    case greaterThan(NumericExpression, NumericExpression)
    case greaterThanOrEqual(NumericExpression, NumericExpression)
    
    // Variables
    case status(Player.Status)
    // TODO: Add greater than and less than

    func evaluate(_ context: Context) -> Double {
        switch self {
        case let .number(value):
            return value
        case let .add(lhs, rhs):
            return lhs.evaluate(context) + rhs.evaluate(context)
        case let .subtract(lhs, rhs):
            return lhs.evaluate(context) - rhs.evaluate(context)
        case let .multiply(lhs, rhs):
            return lhs.evaluate(context) * rhs.evaluate(context)
        case let .divide(lhs, rhs):
            return lhs.evaluate(context) / rhs.evaluate(context)
        case let .lessThan(lhs, rhs):
            return lhs.evaluate(context) < rhs.evaluate(context) ? 1 : 0
        case let .greaterThan(lhs, rhs):
            return lhs.evaluate(context) > rhs.evaluate(context) ? 1 : 0
        case let .greaterThanOrEqual(lhs, rhs):
            return lhs.evaluate(context) >= rhs.evaluate(context) ? 1 : 0
        case let .status(status):
            return context.status(status)
        }
    }
}

extension NumericExpression {
    struct Context {
        var status: (Player.Status) -> Double
    }
}

@resultBuilder
struct ExpressionBuilder {
    static func buildBlock(_ components: NumericExpression...) -> NumericExpression {
        return components.reduce(NumericExpression.number(0)) { $0 + $1 }
    }
}

extension Double {
    var c: NumericExpression { return NumericExpression.number(self) }
}

extension Player.Status {
    var v: NumericExpression { NumericExpression.status(self) }
}
