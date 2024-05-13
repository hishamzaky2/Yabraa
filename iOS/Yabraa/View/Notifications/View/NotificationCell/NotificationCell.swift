//
//  NotificationCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 22/11/2023.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var notificationContent: UILabel!
    @IBOutlet weak var notificationNumber: UILabel!
    @IBOutlet weak var notificationStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI() 
        // Initialization code
    }
    private func setUpUI() {
        self.containerView.addShadowToAllEdges(cornerRadius: 25)
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(notification: Notifications) {
        if UserDefualtUtils.isArabic() {
            notificationContent.text =  notification.titleAR ?? ""
            notificationStatus.text = notification.bodyAR ?? ""
        }else {
            notificationContent.text = notification.titleEn ?? ""
            notificationStatus.text = notification.bodyEn ?? ""
        }
        if notification.isRead ?? false {
            containerView.backgroundColor = .white
            notificationStatus.textColor = UIColor(named: "textBlackColor")
            notificationContent.textColor = UIColor(named: "textBlackColor")
            notificationNumber.textColor = UIColor(named: "textBlackColor")
        }else {
            containerView.backgroundColor = .primaryColor
            notificationStatus.textColor = UIColor(named: "TextGrayColor")
            notificationContent.textColor = UIColor(named: "TextGrayColor")
            notificationNumber.textColor = UIColor(named: "TextGrayColor")
        }
        notificationNumber.text = "Num # ".localized + String(notification.notificationId ?? 0)
    }
    
}
