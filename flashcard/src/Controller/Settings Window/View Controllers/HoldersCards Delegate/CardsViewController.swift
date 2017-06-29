//
//  CardsViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardsViewController: NSObject {
    var view: CardsView
    var presenter: CardPresenter

    init(view: CardsView, presenter: CardPresenter) {
        self.view = view
        self.presenter = presenter
        super.init()

        view.cardsList.dataSource = presenter
        view.cardsList.delegate = self
        view.delegate = self
    }
}

extension CardsViewController: CardsViewDelegate {
    func didPressAddCard() {}

    func didPressRemoveCard(selectedRow: Int) {
        if let selectedCard = self.presenter.getCard(at: selectedRow) {
            Card.delete(selectedCard)
        }
    }
}

extension CardsViewController: NSTableViewDelegate {
    // WARNING: MUST NOT implement `table​View(_:​view​For:​row:​)` because if it was implemented, this method would be ignored.
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        let cell = NSCell()
        cell.wraps = true
        cell.isEditable = true
        cell.font = NSFont.systemFont(ofSize: NSFont.systemFontSize())
        if let v = self.presenter.tableView!(tableView, objectValueFor: tableColumn, row: row) as? String {
            cell.stringValue = v
            return cell
        }

        return nil
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        if let c = presenter.getCard(at: row) {
            return Card.calcRowHeight(c, tableView: tableView)
        }

        return tableView.rowHeight
    }
}

extension CardsViewController: HolderSelectDelegate {
    func didSelectHolder(holderId: Int?) {
        if let id = holderId {
            view.cardsList.dataSource = presenter
            self.presenter.load(holderId: id, targetTableView: self.view.cardsList)
        } else {
            view.cardsList.dataSource = nil
            self.presenter.releaseNotificationBlock()
            view.cardsList.reloadData()
        }
    }
}
