//
//  AJMListView.swift
//  AJM Softwares
//
//  Created by AJM Softwares on 13/04/21.
//  Copyright © 2021 AJM Softwares. All rights reserved.
//

import UIKit
struct ListItem {
    var id : String?
    var title : String!
    var image : UIImage?
}
typealias ListCallback = (ListItem) -> Void
class AJMListView: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var dataSource : [ListItem] = []
    var callback : ListCallback?
    var font = UIFont.systemFont(ofSize: 18.0)
    var offset : CGFloat = 10.0
    let cellIdentifier = "Cell"
    var width : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
    }
    private func setupTableview() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "AJMTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    func getSizeFromDataSource() -> CGSize {
        var height : CGFloat = 0.0
        let leftOffset : CGFloat = 10.0
        let rightOffset : CGFloat = 20.0
        let topOffset : CGFloat = 12.0
        let stackviewSpace : CGFloat = 8.0
        let imageSize : CGFloat = 20.0 + stackviewSpace
        for item in dataSource {
            var totalOffset = (leftOffset + rightOffset)
            totalOffset += item.image != nil ? imageSize : 0.0
            let cellWidth = getWidth() - totalOffset
            height = height + item.title.height(withConstrainedWidth: cellWidth, font: font)
            height = height + (topOffset * 2)
        }
        return CGSize(width: getWidth(), height: height)
    }
    func getWidth() ->CGFloat {
        return width ?? self.view.frame.size.width / 2
    }
    class func getPopupController() -> AJMListView {
        let vc = AJMListView(nibName: "AJMListView", bundle: nil)
        vc.modalPresentationStyle = .popover;
        return vc
    }
}
extension AJMListView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            guard let callback = self.callback else { return }
            callback(self.dataSource[indexPath.row])
            self.callback = nil
        }
    }
}
extension AJMListView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AJMTableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier) as? AJMTableViewCell
        }
        cell?.titleLabel.font = font
        let item = dataSource[indexPath.row]
        cell?.titleLabel.text  = item.title
        cell?.icon.image = item.image
        cell?.icon.isHidden = item.image == nil
        return cell ?? UITableViewCell()
    }
}
extension UIViewController {
    func showPopupOn(_ popupView:UIView,list:[ListItem],selectionCallback:ListCallback?){
        let vc = AJMListView.getPopupController()
        vc.dataSource = list
        vc.callback = selectionCallback
        if let style = vc.popoverPresentationController {
            style.sourceView = popupView
            style.sourceRect = popupView.bounds
            vc.preferredContentSize = vc.getSizeFromDataSource()
            if let vc = self as? UIPopoverPresentationControllerDelegate {
                style.delegate = vc
            }
        }
        present(vc, animated: true, completion: nil)
    }
    func showPopupON(_ popupView:UIView,_ controller:AJMListView){
        if let style = controller.popoverPresentationController {
            style.sourceView = popupView
            style.sourceRect = popupView.bounds
            controller.preferredContentSize = controller.getSizeFromDataSource()
            if let vc = self as? UIPopoverPresentationControllerDelegate {
                style.delegate = vc
            }
        }
        present(controller, animated: true, completion: nil)
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

