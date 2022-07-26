//
//  CPFeedPostGeneralTableViewCell.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import UIKit

//Comments
class CPFeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "CPFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndetifier: String?){
        super.init(style: style, reuseIdentifier: reuseIndetifier)
        contentView.backgroundColor = .systemBlue
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        // configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
