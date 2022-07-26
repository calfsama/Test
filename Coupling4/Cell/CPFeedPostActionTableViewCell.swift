//
//  CPFeedPostActionTableViewCell.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import SDWebImage
import UIKit

protocol CPFeedPostActionTableViewCellDelegate: AnyObject{
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class CPFeedPostActionTableViewCell: UITableViewCell {
    
    weak var delegate: CPFeedPostActionTableViewCellDelegate?

    static let identifier = "CPFeedPostActionTableViewCell"
    
   
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let image = UIImage(systemName: "paperplain", withConfiguration: config)
        button.tintColor = .label
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndetifier: String?){
        super.init(style: style, reuseIdentifier: reuseIndetifier)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("Init (coder:) has not been implemented")
    }
    
    @objc private func didTapLikeButton(){
        delegate?.didTapLikeButton()
        
    }
    
    
    @objc private func didTapCommentButton(){
        delegate?.didTapCommentButton()
    }
    
    
    @objc private func didTapSendButton(){
        delegate?.didTapSendButton()
    }
    
    
    
    public func configure(with post: UserPost){

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //like, comment, send
        
        
        let buttonSize = contentView.height - 10
       
        let buttons = [likeButton, commentButton, sendButton]
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x) * buttonSize) * (10 * CGFloat(x + 1)), y: 5, width: buttonSize, height: buttonSize)
        }
        
        
       
    }
        override func prepareForReuse() {
        super.prepareForReuse()
       
    }

}
