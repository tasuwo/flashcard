//
//  CardsViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardHolderCell: NSCell {
    override init() {
        super.init()
        self.wraps = true
        self.isEditable = true
        self.font = NSFont.systemFont(ofSize: NSFont.systemFontSize())
    }

    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CardsViewController: NSObject {
    var view: CardsView
    var presenter: CardsListPresenter

    init(view: CardsView) {
        self.view = view
        self.presenter = CardsListPresenter()
        super.init()
        view.cardsList.dataSource = presenter
        view.cardsList.delegate = self
    }
}

extension CardsViewController: CardsViewDelegate {
    func didPressAddCard() {}

    func didPressRemoveCard(selectedRow: Int) {
        if selectedRow == -1 { return }
        if let selectedCard = self.presenter.cards?[selectedRow] {
            Card.delete(selectedCard)
        }
    }
}

extension CardsViewController: NSTableViewDelegate {
    // WARNING: MUST NOT implement `table​View(_:​view​For:​row:​)` because if it was implemented, this method would be ignored.
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        let cell = CardHolderCell()
        if let v = self.presenter.tableView(tableView, objectValueFor: tableColumn, row: row) as? String {
            cell.stringValue = v
            return cell
        }

        return nil
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if let c = presenter.cards, row < c.count {
            return Card.calcRowHeight(c[row], tableView: tableView)
        }

        return tableView.rowHeight
    }
}
