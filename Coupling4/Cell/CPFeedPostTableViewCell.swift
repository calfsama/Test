//
//  CPFeedPostTableViewCell.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//
import AVFoundation
import SDWebImage
import UIKit

/// Cell for primary post content
final class CPFeedPostTableViewCell: UITableViewCell {
    
   
    
    static let identifier = "CPFeedPostTableViewCell"
    
        public let postimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
            imageView.clipsToBounds = true
        return imageView
    }()
    
    
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndetifier: String?){
        super.init(style: style, reuseIdentifier: reuseIndetifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postimageView)
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var groups: [ImageView] = [ImageView(image: "2"),ImageView(image: "1")]
    
    public func configure(with post: UserPost){
        // configure the cell
        postimageView.image = UIImage(named: "4")
        return
        
        switch post.postType{
        case .photo:
            //show image
            postimageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            //load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postimageView.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postimageView.image = nil
    }
}
