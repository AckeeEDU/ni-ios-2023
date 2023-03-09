//
//  ViewController.swift
//  Introduction
//
//  Created by Lukáš Hromadník on 22.02.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let label = UILabel()
        label.text = "Ahoj asdkjhas dlaskjd asd alsjda sldkja lskdja sda"
        label.numberOfLines = 0
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 32)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        let label2 = UILabel()
        label2.text = "světe"
        label2.textColor = .blue
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.textAlignment = .center
        view.addSubview(label2)
        label2.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
