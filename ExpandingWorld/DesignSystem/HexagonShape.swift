//Created by Alexander Skorulis on 15/2/2025.

import Foundation
import SwiftUI

struct HexagonShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        var path = Path()
        
        path.move(
            to: CGPoint(
                x: width * 0.2,
                y: height * 0.95
            )
        )

        HexagonParameters.segments.forEach { segment in
            path.addLine(
                to: CGPoint(
                    x: width * segment.line.y,
                    y: height * segment.line.x
                )
            )
            
            path.addQuadCurve(
                to: CGPoint(
                    x: width * segment.curve.y,
                    y: height * segment.curve.x
                ),
                control: CGPoint(
                    x: width * segment.control.y,
                    y: height * segment.control.x
                )
            )
        }
        
        return path
    }
    
    
}

struct HexagonParameters {
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }


    static let segments = [
        Segment(
            line:    CGPoint(x: 0.60, y: 0.05),
            curve:   CGPoint(x: 0.40, y: 0.05),
            control: CGPoint(x: 0.50, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.05, y: 0.20),
            curve:   CGPoint(x: 0.00, y: 0.30),
            control: CGPoint(x: 0.00, y: 0.25)
        ),
        Segment(
            line:    CGPoint(x: 0.00, y: 0.70),
            curve:   CGPoint(x: 0.05, y: 0.80),
            control: CGPoint(x: 0.00, y: 0.75)
        ),
        Segment(
            line:    CGPoint(x: 0.40, y: 0.95),
            curve:   CGPoint(x: 0.60, y: 0.95),
            control: CGPoint(x: 0.50, y: 1.00)
        ),
        Segment(
            line:    CGPoint(x: 0.95, y: 0.80),
            curve:   CGPoint(x: 1.00, y: 0.70),
            control: CGPoint(x: 1.00, y: 0.75)
        ),
        Segment(
            line:    CGPoint(x: 1.00, y: 0.30),
            curve:   CGPoint(x: 0.95, y: 0.20),
            control: CGPoint(x: 1.00, y: 0.25)
        )
    ]
}


#Preview {
    HexagonShape()
        .stroke(Color.black)
        .frame(width: 100, height: 100)
        .border(Color.red)
}
