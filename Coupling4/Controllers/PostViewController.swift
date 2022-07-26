//
//  PostViewController.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 22/06/22.
//

import UIKit

/*
 
 Section
 - Header model
 Section
 - Post cell model
 Section
 - Action Button cell model
 Section
 - n Number for general models for comments
 
 */
/// States of a rendered cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}

/// Model of rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // Registe cells
        tableView.register(CPFeedPostTableViewCell.self, forCellReuseIdentifier: CPFeedPostTableViewCell.identifier)
        tableView.register(CPFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: CPFeedPostHeaderTableViewCell.identifier)
        tableView.register(CPFeedPostActionTableViewCell.self, forCellReuseIdentifier: CPFeedPostActionTableViewCell.identifier)
        tableView.register(CPFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: CPFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Init
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureModels(){
        guard let userPostModel = self.model else {
            return
        }
        
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        // Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)", username: "@mayson", text: "Great post!", createdeDate: Date(), likes: []))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .orange
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
extension PostViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostActionTableViewCell.identifier, for: indexPath) as! CPFeedPostActionTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostGeneralTableViewCell.identifier, for: indexPath) as! CPFeedPostGeneralTableViewCell
            return cell
        
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostTableViewCell.identifier, for: indexPath) as! CPFeedPostTableViewCell
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: CPFeedPostHeaderTableViewCell.identifier, for: indexPath) as! CPFeedPostHeaderTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_): return 60
            
        case .comments(_): return 0
        
        case .primaryContent(_): return tableView.width
        case .header(_): return 70
        }
    }
}
