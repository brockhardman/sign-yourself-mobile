

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.9725490196, alpha: 1)
        self.selectedBackgroundView = bgColorView
    }

}
