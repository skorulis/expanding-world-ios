//  Created by Alexander Skorulis on 23/5/2025.

import Foundation
import SwiftUI

public struct TitleBar<TrailingIcon: View>: View {
    
    private let title: String
    private let trailing: () -> TrailingIcon
    
    public init(
        title: String,
        trailing: @escaping () -> TrailingIcon
    ) {
        self.title = title
        self.trailing = trailing
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.title)
                Spacer()
                trailing()
            }
            .frame(minHeight: 44)
            .padding(.horizontal, 16)
            Divider()
        }
    }
}

public extension TitleBar where TrailingIcon == EmptyView {
    public init(title: String) {
        self.init(title: title, trailing: { EmptyView() })
    }
}

#Preview {
    VStack {
        TitleBar(title: "Test") {
            Image(systemName: "square.and.arrow.down")
                .frame(width: 44, height: 44)
        }
        Spacer()
    }
    
}
