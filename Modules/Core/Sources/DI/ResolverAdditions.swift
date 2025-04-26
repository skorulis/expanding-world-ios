//  Created by Alexander Skorulis on 26/4/2025.

import Knit
import Swinject
import Foundation

// Resolver for services available in the app scope
public protocol AppResolver: Knit.Resolver {}

extension Knit.Container: AppResolver {}
