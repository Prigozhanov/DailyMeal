//
//  Created by Vladimir on 2/4/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Networking
import os.log

typealias Colors = Asset.Colors
typealias Images = Asset.Images

typealias Localizable = L10n

typealias VoidClosure = () -> Void
typealias BoolClosure = (Bool) -> Void
typealias IntClosure = (Int) -> Void
typealias StringClosure = (String) -> Void

var menuByLanguage: Language {
	switch Locale.current.languageCode {
	case "en":
		return .en
	case "ru":
		return .ru
	default: return .en
	}
}

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
