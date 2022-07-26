//
//  CPFeedPostHeaderTableViewCell.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 22/06/22.
//

import UIKit

protocol CPFeedPostHeaderTableViewCellDelegate: AnyObject{
    func didTapMoreButton()
}

class CPFeedPostHeaderTableViewCell: UITableViewCell {
    
    weak var delegate: CPFeedPostHeaderTableViewCellDelegate?

    static let identifier = "CPFeedPostHeaderTableViewCell"
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "3")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndetifier: String?){
        super.init(style: style, reuseIdentifier: reuseIndetifier)
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("Init (coder:) has not been implemented")
    }
    
    @objc private func didTapButton(){
        delegate?.didTapMoreButton()
        
    }
    
    public func configure(with model: User){
        // configure the cell
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(named: "3")
    
        //profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height - 4
        profilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profilePhotoImageView.layer.cornerRadius = size / 2
        
        moreButton.frame = CGRect(x: contentView.width - size - 2, y: 2, width: size, height: size)
        
        usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 10, y: 2, width: contentView.width - (size * 2) - 15, height: contentView.height - 4)
        
        
       
    }
        override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }


}