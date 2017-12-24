//
//  HtmlTextView.swift
//  HtmlTextView
//
//  Created by yang on 2017/12/19.
//  Copyright © 2017年 yang. All rights reserved.
//

import UIKit

class HtmlTextView: UITextView, UITextViewDelegate {
    public static let baseURL = URL(string: Urls.baseUrl)

    var linkClickDelegate: ((LinkClickType) -> Void)?
    var htmlText: String? {
        didSet {
            if let text = htmlText {
                attributedText = AttributeConverter(font: UIFont.systemFont(ofSize: 16), textColor: UIColor.darkText,
                        linkTextAttributes: linkTextAttributes).convert(src: text)
            } else {
                attributedText = nil
            }
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        isEditable = false
        textContainerInset = UIEdgeInsets.zero
        //textContainer.lineFragmentPadding = 0
        //layoutManager.usesFontLeading = false

        textColor = UIColor.darkText
        isScrollEnabled = false
        delegate = self

        //linkTextAttributes = []
    }


    // textview 链接点击事件
    // textView.delegate = self
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if let d = self.linkClickDelegate {
            LinkClickHandler.handle(url: URL.absoluteString, delegate: d)
        }
        return false
    }


    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("image click", textAttachment)

        return false
    }

}