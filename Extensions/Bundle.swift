//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public extension Bundle {
    static var id: String {
        return main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
}
