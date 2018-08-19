

import UIKit

class MenuItemViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rows: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rows = MenuItem.allMenuItems()
    }

    //MARK: Menu Actions
    
    func homeAction() {
    }
    
    
    func documentsAction() {
    }
    
    
    func walletAction() {
    }
    
    
    func inviteAction() {
    }
    
    
    func settingsAction() {
    }
    
    
    func contactUsAction() {
    }
    
    
    func helpAction() {
    }
    
    
    func packageAction() {
    }
    
    
    func carsAction() {
    }

}

extension MenuItemViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row: MenuItem = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier, for: indexPath) as! MenuItemCell
        cell.lblTitle.text = row.name
        cell.icon.image = UIImage(named: row.iconName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let menuVC: MenuViewController = self.parent as? MenuViewController else { return }
        menuVC.hideMenu()
        
        let row = rows[indexPath.row]
        
        switch row {
        case .home: homeAction()
        case .documents: documentsAction()
        case .wallet: walletAction()
        case .invite: inviteAction()
        case .settings: settingsAction()
        case .contactUs: contactUsAction()
        case .help: helpAction()
        case .package: packageAction()
        case .cars: carsAction()
        }
    }

}
