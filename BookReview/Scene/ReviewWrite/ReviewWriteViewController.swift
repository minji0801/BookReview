//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by 김민지 on 2022/01/27.
//

import UIKit
import SnapKit

final class ReviewWriteViewController: UIViewController {
    
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        
        return button
    }()
    
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = "내용을 입력해주세요."
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

// MARK: UITextViewDelegate
extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    // Navigation Bar
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapRightBarButton)
        )
    }
    
    // Cancel Alert
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?", message: nil, preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in    // [weak self] : 메모리 누수 방지(클로저 안에서 사용 추천)
            self?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        [closeAction, cancelAction].forEach { action in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true)
    }
    
    func close() {
        dismiss(animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [bookTitleButton, contentsTextView, imageView].forEach {
            view.addSubview($0)
        }
        
        bookTitleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16.0)
        }
        
        imageView.snp.makeConstraints {
            $0.leading.equalTo(contentsTextView.snp.leading)
            $0.trailing.equalTo(contentsTextView.snp.trailing)
            $0.top.equalTo(contentsTextView.snp.bottom).offset(16.0)
            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
}
