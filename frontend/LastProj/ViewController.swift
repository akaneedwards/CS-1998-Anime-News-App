//
//  ViewController.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//


import UIKit
import Alamofire

protocol NameDelegate: class{
    func AddAnime(newTitle:String)
}

protocol DeleteDelgate: class {
    func delAnime(id:Int)
}

class ViewController: UIViewController {
    
    
    
    private let showsTableView = UITableView()
    private let showReuseIdentifier = "ShowReuseIdentifier"
    private var shows: [Show] = []
    private var presentModalViewControllerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //color is ugly, change it
        view.backgroundColor = UIColor(red: 235/255, green: 204/255, blue: 234/255, alpha: 1)
        
        title = "Upcoming Anime"
        navigationController?.navigationBar.barTintColor = UIColor(red: 150/255, green: 75/255, blue: 150/255, alpha: 0.1)
        navigationController?.navigationBar.tintColor = .white
                
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsTableView.translatesAutoresizingMaskIntoConstraints = false
        showsTableView.separatorStyle = .none
        showsTableView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        showsTableView.register(ShowTableViewCell.self, forCellReuseIdentifier: showReuseIdentifier)
        view.addSubview(showsTableView)
        
        presentModalViewControllerButton = UIButton()
        presentModalViewControllerButton.translatesAutoresizingMaskIntoConstraints = false
        presentModalViewControllerButton.setTitle("Add Anime", for: .normal)
        presentModalViewControllerButton.setTitleColor(.systemPurple, for: .normal)
        presentModalViewControllerButton.backgroundColor = .white
        presentModalViewControllerButton.layer.cornerRadius = 4
        presentModalViewControllerButton.layer.borderWidth = 1
        presentModalViewControllerButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        presentModalViewControllerButton.layer.borderColor = UIColor.purple.cgColor
        presentModalViewControllerButton.addTarget(self, action: #selector(presentModalViewController), for: .touchUpInside)
        view.addSubview(presentModalViewControllerButton)
        
        getShows()
        setupConstraints()
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            showsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            showsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            showsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            showsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            presentModalViewControllerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presentModalViewControllerButton.bottomAnchor.constraint(equalTo: showsTableView.topAnchor, constant: -7.5),
            presentModalViewControllerButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    @objc func presentModalViewController() {
        let newViewController = AddAnimeViewController(placeHolder: presentModalViewControllerButton.titleLabel?.text ?? "Add anime")
       newViewController.delegate = self
       present(newViewController, animated: true, completion: nil)
       
    }
    
    // get all shows
   private func getShows(){
        NetworkManager.getShows { (shows) in
            self.shows = shows
            self.showsTableView.reloadData()
            
        }
    

    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = shows[indexPath.row]
        let showViewController = ShowViewController(show: show)
        navigationController?.pushViewController(showViewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: showReuseIdentifier) as? ShowTableViewCell else { return UITableViewCell() }
        let show = shows[indexPath.row]
        cell.configure(for: show)
        return cell
    }
}



extension ViewController: NameDelegate{
    func AddAnime(newTitle: String) {
        let show = Show(id: shows.count+1, name:newTitle, description: "")
        shows.append(show)
        showsTableView.reloadData()
    }
}

extension ViewController: DeleteDelgate{
    func delAnime(id: Int) {
        print(shows[id-1])
        shows.remove(at: id-1)
        showsTableView.reloadData()
    }
    
    
}
//
//extension ViewController: NameDelegate{
//    func AddAnime(newTitle: String) {
////        let show = Show(title: newTitle, summary: "", photo: "https://i2.wp.com/www.tor.com/wp-content/uploads/2015/12/NanaTai.png?type=vertical")
////        shows.append(show)
//        showsTableView.reloadData()
//    }
//}




