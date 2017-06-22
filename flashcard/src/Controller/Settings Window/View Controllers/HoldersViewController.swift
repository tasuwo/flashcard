//
//  HoldersViewController.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

class HoldersViewController: NSObject {
    var presenter: CardHoldersListPresenter
    var view: HoldersView

    init(view: HoldersView) {
        self.view = view
        self.presenter = CardHoldersListPresenter()
        super.init()
        presenter.load(updated: { changes in
            switch changes {
            case .initial:
                view.holdersList.reloadData()

            case let .update(_, del, ins, upd):
                view.holdersList.beginUpdates()
                view.holdersList.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                view.holdersList.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                view.holdersList.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                view.holdersList.endUpdates()

            default: break
            }
        })
        view.holdersList.dataSource = presenter
        view.holdersList.delegate = self
    }
}

extension HoldersViewController: NSTableViewDelegate {
    // WARNING: MUST NOT implement `table​View(_:​view​For:​row:​)` because if it was implemented, this method would be ignored.
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        let cell = CardHolderCell()
        if let v = self.presenter.tableView(tableView, objectValueFor: tableColumn, row: row) as? String {
            cell.stringValue = v
            return cell
        }

        return nil
    }

    func tableView(_ tableView: NSTableView, heightOfRow _: Int) -> CGFloat {
        return tableView.rowHeight
    }

    func tableViewSelectionDidChange(_: Notification) {
        // TODO: CardsView を更新させる
        /* let table = notification.object as! NSTableView
         if let h = self.holdersPresenter.holders,
         h.count > table.selectedRow,
         !(table.selectedRow < 0)
         {
         view.cardsList.dataSource = self.cardsPresenter
         self.cardsPresenter.loadCards(in: h[table.selectedRow].id, updated: { changes in
         switch changes {
         case .initial:
         view.cardsList.reloadData()

         case let .update(_, del, ins, upd):
         view.cardsList.beginUpdates()
         view.cardsList.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
         view.cardsList.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
         view.cardsList.removeRows(at: IndexSet(del), withAnimation: .slideUp)
         view.cardsList.endUpdates()

         default: break
         }
         })
         } else {
         view.cardsList.dataSource = nil
         self.cardsPresenter.releaseNotificationBlock()
         view.cardsList.reloadData()
         } */
    }
}

extension HoldersViewController: HoldersViewDelegate {
    func didPressAddCardHolder() {
        let holder = CardHolder(name: "Untitled")
        CardHolder.add(holder)
    }

    func didPressRemoveCardHolder(selectedRow: Int) {
        if selectedRow == 0 { return }
        view.holdersList.deselectAll(self)

        if selectedRow == -1 { return }
        if let selectedCardHolder = self.presenter.holders?[selectedRow] {
            CardHolder.delete(selectedCardHolder)
        }
    }
}
