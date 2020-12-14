//
//  AddAnimeViewController.swift
//  LastProj
//
//  Created by Juliet DeNapoli on 12/4/20.
//

import UIKit
//import ViewController

class AddAnimeViewController: UIViewController {
    weak var delegate: NameDelegate?
    var button: UIButton!
    var textField: UITextField!
    var placeHolderText: String

    
    init(placeHolder: String){
        self.placeHolderText = placeHolder
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .white
        
          textField = UITextField()
          textField.translatesAutoresizingMaskIntoConstraints = false
          textField.text = placeHolderText
          textField.borderStyle = .roundedRect
          textField.backgroundColor = .white
          textField.textAlignment = .center
          textField.clearsOnBeginEditing = true
          view.addSubview(textField)

        
        
        
       button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.setTitle("Add", for: .normal)
       button.backgroundColor = .white
       button.layer.cornerRadius = 4
       button.setTitleColor(.blue, for: .normal)
       button.addTarget(self, action: #selector(addText), for: .touchUpInside)
        view.addSubview(button)
        


        
          setupConstraints()
      }

      func setupConstraints() {
          NSLayoutConstraint.activate([
              textField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
              textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
              textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
              textField.heightAnchor.constraint(equalToConstant: 24)
              ])

         NSLayoutConstraint.activate([
              button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
              button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              button.heightAnchor.constraint(equalToConstant: 24)
              ])

      }

    @objc func addText() {
        if let name = textField.text, name != ""{
            let description = ""
            NetworkManager.addShow(name: name, description: description) { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                self.dismiss(animated: true, completion: nil)
                self.delegate?.AddAnime(newTitle: name)
            })
            
        }
    }
    dismiss(animated: true, completion: nil)
}


}
