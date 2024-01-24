//
//  TextView+.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/24.
//

import UIKit

extension UITextView: UITextViewDelegate {

    private struct Holder {
        static var placeholderLabel: UILabel = UILabel()
    }

    var placeholderLabel: UILabel {
        get {
            return Holder.placeholderLabel
        }
        set {
            Holder.placeholderLabel = newValue
        }
    }

    func addPlaceholder(_ placeholderText: String) {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: nil)

        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
//        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize) / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !self.text.isEmpty

        self.addSubview(placeholderLabel)
        self.delegate = self
    }

    @objc func textViewDidChange(_ notification: Notification) {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
}

