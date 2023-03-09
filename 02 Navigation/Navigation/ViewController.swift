//
//  ViewController.swift
//  Introduction
//
//  Created by Lukáš Hromadník on 22.02.2023.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    private weak var label: UILabel!

    private var text: String

    init(text: String) {
        self.text = text

        super.init(nibName: nil, bundle: nil)

        print(#function, self)
    }

    deinit {
        print("deinit \(self)")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 32)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.label = label
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = text
        navigationItem.title = text
    }
}

class Text2ViewController: UIViewController {
    private var text: String
    private var onTap: () -> Void

    init(text: String, onTap: @escaping () -> Void) {
        self.text = text
        self.onTap = onTap

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        let hosting = UIHostingController(
            rootView: ContentView(
                text: text,
                onTap: {
                    self.onTap()
                }
            )
        )
        addChild(hosting)
        view.addSubview(hosting.view)
        hosting.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        hosting.didMove(toParent: self)
    }
}

class ViewController: UIViewController {
    private weak var vc: TextViewController!

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "asdasdas"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )
    }

    private weak var vc2: UIViewController!
    @objc
    func buttonTapped() {
        let vc = Text2ViewController(
            text: "ahoj",
            onTap: {
                self.closeTapped()
            }
        )
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeTapped)
        )
        self.vc2 = vc

//        let hosting = UIHostingController(rootView: ContentView(text: "ahoj", onTap: { self.closeTapped() }))

        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)

//        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    func doneTapped() {
        print(#function)
    }

    @objc
    func closeTapped() {
        vc2.dismiss(animated: true)
    }
}

import SwiftUI

struct ContentView: View {
    let text: String
    let onTap: () -> Void

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)

            VStack {
                Text(text)
                    .bold()
                    .foregroundColor(.red)

                Button("Tap me again") {
                    onTap()
                }
            }
        }
    }
}

struct MyView: UIViewControllerRepresentable {
    @State var text = ""

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // ..
    }
}


struct PostDetailView: View {
    let imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
    }
}

class TestViewController: UIViewController {
    override func loadView() {
        super.loadView()

        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }

        let postDetail = UIHostingController(rootView: PostDetailView(imageName: "ahoj"))
        addChild(postDetail)
        view.addSubview(postDetail.view)
        postDetail.view.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        postDetail.didMove(toParent: self)
    }
}

extension UIColor {
    static var myRed: UIColor = .red
}

extension SwiftUI.Color {
    static var myRed = Color(UIColor.myRed)
}
