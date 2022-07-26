//
//  SettingViewController.swift
//  Coupling4
//
//  Created by Tomiris Negmatova on 21/06/22.
//

import SafariServices
import UIKit

struct SettingCellModel{
    let title: String
    let handler: (() -> Void)
}

// View Controller to show user settings
final class SettingViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.delegate = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
               
                
            },
            SettingCellModel(title: "Invite friends") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save originals posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        data.append([
          
            SettingCellModel(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingCellModel(title: "Log out") { [weak self] in
                self?.didTapLogOut()
                
            }
        ])
    }
    
    enum SettingsURLType{
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type{
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0"
        case .help: urlString = "https://help.instagram.com"
        }
        guard let url = URL(string: urlString) else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    private func didTapSaveOriginalPosts(){
        // Show share sheet to invite friends
        
    }
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends(){
        
    }
    
    private func didTapLogOut(){
//
//        AuthManager.shared.LogOut(completion: { success in
//            DispatchQueue.main.async{
//                if success{
//                   // present log in
////                    let loginVC = LoginViewController()
////                    loginVC.modalPresentationStyle = .fullScreen
////                    self.present(loginVC, animated: true) {
////                    self.navigationController?.popToRootViewController(animated: false)
////                    self.tabBarController?.selectedIndex = 0
////                }
//                }
//                else{
//                    //error occured
//
//                }
//            }
//
//        })
        
    }

}
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
