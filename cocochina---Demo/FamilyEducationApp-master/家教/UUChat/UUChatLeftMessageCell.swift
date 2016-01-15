//
//  LeftMessageCell.swift
//  UUChatTableViewSwift
//
//  Created by XcodeYang on 8/13/15.
//  Copyright © 2015 XcodeYang. All rights reserved.
//

import UIKit

class UUChatLeftMessageCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var headImageView: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentButton: UIButton!
    
    @IBOutlet weak var contentLabel: UILabel!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.contentButton.titleLabel?.numberOfLines = 0;
        self.contentButton.contentEdgeInsets = UIEdgeInsetsMake(4, 29, 4, 9)
    }

    func configUIWithModel(num: NSInteger){
        self.dateLabel.text = random()%2==0 ? "2014-09-21 18：32":""
        self.contentLabel.text = self.getRandomStr(num) as String
    }
    
    func getRandomStr(num: NSInteger) -> NSString{
        let str = "卡农并非特指一首曲子，其原意为“规则”，“同一旋律以同度或五度等不同的高度在各声部先后出现，造成此起彼落连续不断的模仿；一个声部的曲调自始至终追逐着另一声部,直到最后,它们会融合在一起，永不分离”，一如人世间至死不渝的爱情，相爱的两人生死相随，缠绵至极。"
        return (str as NSString).substringToIndex(num)
    }
}
