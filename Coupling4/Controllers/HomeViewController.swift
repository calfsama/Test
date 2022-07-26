//
//  HomeViewController.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import FirebaseAuth
import UIKit

//struct HomeFeedRenderViewModel{
//    let header: PostRenderViewModel
//    let post: PostRenderViewModel
//    let actions: PostrenderViewModel
//    let comments: PostrenderViewModel
//}


struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let action: PostRenderViewModel
    let comments: PostRenderViewModel
}




class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    var cells = [ImageView]()
//
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CPFeedPostTableViewCell.self, forCellReuseIdentifier: CPFeedPostTableViewCell.identifier)
        tableView.register(CPFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: CPFeedPostHeaderTableViewCell.identifier)
        tableView.register(CPFeedPostActionTableViewCell.self, forCellReuseIdentifier: CPFeedPostActionTableViewCell.identifier)
        tableView.register(CPFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: CPFeedPostGeneralTableViewCell.identifier)
        return tableView
//
   }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//
   }
    var groups: [ImageView] = [ImageView(image: "2"),ImageView(image: "1")]
    
    private func createMockModels(){
        
        let user = User(username: "umi", bio: "", name: (first: "Umka", last: "Negmatov"), profilePhoto: URL(string: "https://www.google.com/")!, birthDate: Date(), gender: .male, count: UserCount(followers: 1, following: 1, post: 1), joinedDate: Date())
        
        let post = UserPost(identifier: "",postType: .photo,thumbnailImage: URL(string: "https://www.google.com/")!,
    postURL: URL(string: "https://www.google.com/")!,caption: nil,likeCount: [],
                            comments: [], createddate: Date(),taggeUsers: [], owner: user)
        
        
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)", username: "@jenny", text: "This is the best post I've seen", createdeDate: Date(), likes: []))
        }
        
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), post: PostRenderViewModel(renderType: .primaryContent(provider: post)), action: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            tableView.frame = view.bounds
        }

//
    
//    private let tableView: UITableView =
//    {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(CPFeedPostTableViewCell.self, forCellReuseIdentifier: CPFeedPostTableViewCell.identifier)
//        return tableView
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
//    }
    
    
    func set(cells:[ImageView]){
        self.cells = cells
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //handleNotAuthenticated()
    }

    private func handleNotAuthenticated(){

        // Check auth status
        if Auth.auth().currentUser == nil {

            // Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)

        }
    }

    
//    private var homeCollectionView = HomeCollectionView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//        view.addSubview(homeCollectionView)
//
//        homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
//        homeCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
//
//        homeCollectionView.set(cells: ProfileScroll.profile())
//    }
    


//}
//
//extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
//
//    func numberOfSections(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostTableViewCell.identifier, for: indexPath) as! CPFeedPostTableViewCell
//        return cell
//    }
//}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch renderModels[section].renderType {
//        case .actions(_): return 1
//        case .comments(let comments): return comments.count > 4 ? 4: comments.count
//        case .primaryContent(_): return 1
//        case .header(_): return 1
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath IndexPath) -> UITableViewCell {
//        let model = renderModels[indexPath.section]
//        switch model.renderType{
//        case .actions(let actions):
//            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostActionTableViewCell.identifier, for: indexPath) as! CPFeedPostActionTableViewCell
//            return cell
//
//        case .comments(let comments):
//            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostGeneralTableViewCell.identifier, for: indexPath) as! CPFeedPostGeneralTableViewCell
//            return cell
//
//        case .primaryContent(let post):
//            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostTableViewCell.identifier, for: indexPath) as! CPFeedPostTableViewCell
//            return cell
//        case .header(let user):
//            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedHeaderTableViewCell.identifier, for: indexPath) as! CPFeedHeaderTableViewCell
//            return cell
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let model = renderModels[indexPath.section]
//        switch model.renderType {
//        case .actions(_): return 60
//        case .comments(_): return 50
//        case .primaryContent(_): return tableView.width
//        case .header(_): return 70
//        }
//    }
   }
//}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0{
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x / 4 : ((x % 4) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0{
            //header
            return 1
        }
        else if subSection == 1{
            //post
            return 1
        }
        else if subSection == 2{
            //action
            return 1
        }
        else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0{
            model = feedRenderModels[0]
        }
        else {
            let position = x % 4 == 0 ? x / 4 : ((x % 4) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        if subSection == 0{
            //header
            switch model.header.renderType {
            case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier:CPFeedPostHeaderTableViewCell.identifier, for: indexPath) as! CPFeedPostHeaderTableViewCell
                
            cell.configure(with: user)
            cell.delegate = self
            return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 1{
            //post
            switch model.post.renderType {
            case .primaryContent(let post):
                //let group = groups[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostTableViewCell.identifier, for: indexPath) as! CPFeedPostTableViewCell
                cell.configure(with: post)
                //cell.postimageView.image = UIImage(named: group.image)
                //set(cells: ImageView.postImage())
            return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
            }
        else if subSection == 2{
            //action
            switch model.action.renderType {
            case .actions(let provider):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostActionTableViewCell.identifier, for: indexPath) as! CPFeedPostActionTableViewCell
                cell.delegate = self
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 3 {
            //comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostGeneralTableViewCell.identifier, for: indexPath) as! CPFeedPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
            
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0{
            return 70
        }
        else if subSection == 1{
            return tableView.width
        }
        else if subSection == 2{
            return 60
        }
        else if subSection == 3{
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
}
extension HomeViewController: CPFeedPostHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: {[weak self] _ in
            self?.reportPost()}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    func reportPost() {
        
    }
}
extension HomeViewController: CPFeedPostActionTableViewCellDelegate{
    func didTapLikeButton() {
        print("like")
    }
    func didTapCommentButton() {
        print("comment")
    }
    func didTapSendButton() {
        print("send")
    }
}
