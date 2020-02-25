//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import os.log

typealias Colors = Asset.Colors
typealias Images = Asset.Images

typealias VoidClosure = () -> Void
typealias BoolClosure = (Bool) -> Void
typealias IntClosure = (Int) -> Void
typealias StringClosure = (String) -> Void

func logMessage(message: String) {
    os_log("[INFO] %s", message)
}

func logWarning(message: String) {
    os_log("[WARNING] %s", message)
}

func logError(message: String) {
    os_log("[WARNING] %s", message)
}

func logDebug(message: String) {
    os_log("[DEBUG] %s", message)
}
