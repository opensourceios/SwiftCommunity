//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

extension UITabBarItem {

    public convenience init(titleKey: String, image: UIImage?, tag: Int) {
        self.init(title: titleKey.localized, image: image, tag: tag)
    }

}
