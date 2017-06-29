//
//  HoldersViewController.swift
//  flashcard
//
//  Created by 兎澤　佑　 on 2017/06/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Foundation
import Cocoa

protocol HolderSelectDelegate {
    func didSelectHolder(holderId: Int?)
}

class HoldersViewController: NSObject {
    open var delegate: HolderSelectDelegate?
    var presenter: CardHolderPresenter
    var view: HoldersView

    init(view: HoldersView, presenter: CardHolderPresenter) {
        self.view = view
        self.presenter = presenter
        super.init()

        presenter.load(targetTableView: view.holdersList)
        view.holdersList.dataSource = presenter
        view.holdersList.delegate = self

        view.delegate = self
    }
}

extension HoldersViewController: NSTableViewDelegate {
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

    func tableView(_ tableView: NSTableView, heightOfRow _: Int) -> CGFloat {
        return tableView.rowHeight
    }

    func tableViewSelectionDidChange(_: Notification) {
        if let _ = presenter.getHolder(at: view.holdersList.selectedRow) {
            self.delegate?.didSelectHolder(holderId: self.view.holdersList.selectedRow)
        } else {
            self.delegate?.didSelectHolder(holderId: nil)
        }
    }
}

extension HoldersViewController: HoldersViewDelegate {
    func didPressAddCardHolder() {
        CardHolder.add(CardHolder(name: "Untitled"))
    }

    func didPressRemoveCardHolder(selectedRow: Int) {
        view.holdersList.deselectAll(self)
        if let selectedCardHolder = self.presenter.getHolder(at: selectedRow) {
            CardHolder.delete(selectedCardHolder)
        }
    }
}
