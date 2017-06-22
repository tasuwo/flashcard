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
        let cell = NSCell()
        cell.wraps = true
        cell.isEditable = true
        cell.font = NSFont.systemFont(ofSize: NSFont.systemFontSize())
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

extension CardsViewController: HolderSelectDelegate {
    func didSelectHolder(holderId: Int?) {
        if let id = holderId {
            view.cardsList.dataSource = presenter
            self.presenter.loadCards(in: id, updated: { changes in
                switch changes {
                case .initial:
                    self.view.cardsList.reloadData()

                case let .update(_, del, ins, upd):
                    self.view.cardsList.beginUpdates()
                    self.view.cardsList.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                    self.view.cardsList.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                    self.view.cardsList.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                    self.view.cardsList.endUpdates()

                default: break
                }
            })
        } else {
            view.cardsList.dataSource = nil
            self.presenter.releaseNotificationBlock()
            view.cardsList.reloadData()
        }
    }
}
