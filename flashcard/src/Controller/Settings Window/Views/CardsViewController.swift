//
//  CardsViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa

class CardsViewController: NSViewController {
    var holdersPresenter: CardHoldersListPresenter!
    var cardsPresenter: CardsListPresenter!
    
    override func loadView() {
        let winSize = SettingsWindowController.winSize
        let view = CardsView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        view.delegate = self
        
        holdersPresenter = CardHoldersListPresenter()
        holdersPresenter.load(updated:{ changes in
            switch changes {
            case .initial:
                view.holdersList.reloadData()
                
            case .update(_, let del, let ins, let upd):
                view.holdersList.beginUpdates()
                view.holdersList.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                view.holdersList.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                view.holdersList.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                view.holdersList.endUpdates()
                
            default: break
            }
        })
        view.holdersList.dataSource = self.holdersPresenter
        view.holdersList.delegate = self
        
        cardsPresenter = CardsListPresenter()
        view.cardsList.delegate = self
        
        self.view = view
    }
}

extension CardsViewController : CardsViewDelegate {
    func didPressAddCard() {}
    
    func didPressRemoveCard(selectedRow: Int) {
        if selectedRow != -1 {
            if let selectedCard = self.cardsPresenter.cards?[selectedRow] {
                Card.delete(selectedCard)
            }
        }
    }
    
    func didPressAddCardHolder() {
        let holder = CardHolder(name: "")
        CardHolder.add(holder)
        
        // TODO: Focus holder's cell and edit, save the name
    }
    
    func didPressRemoveCardHolder(selectedRow: Int) {
        if selectedRow != -1 {
            if let selectedCardHolder = self.holdersPresenter.holders?[selectedRow] {
                CardHolder.delete(selectedCardHolder)
            }
        }
    }
}

extension CardsViewController: NSTableViewDelegate {
    // WARNING: MUST NOT implement `table​View(_:​view​For:​row:​)` because if it was implemented, this method would ignored.
    func tableView(_ tableView: NSTableView, dataCellFor tableColumn: NSTableColumn?, row: Int) -> NSCell? {
        let view = self.view as! CardsView
        if tableView === view.cardsList {
            let cell = NSCell()
            cell.wraps = true
            cell.isEditable = true
            cell.font = NSFont.systemFont(ofSize: NSFont.systemFontSize())
            if let v = self.cardsPresenter.tableView(tableView, objectValueFor: tableColumn, row: row) as? String {
                cell.stringValue = v
                return cell
            }
            return nil
        } else if tableView == view.holdersList {
            let cell = NSCell()
            cell.wraps = true
            cell.isEditable = true
            cell.font = NSFont.systemFont(ofSize: NSFont.systemFontSize())
            if let v = self.holdersPresenter.tableView(tableView, objectValueFor: tableColumn, row: row) as? String {
                cell.stringValue = v
                return cell
            }
            return nil
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let view = self.view as! CardsView
        if tableView === view.cardsList {
            if let p = self.cardsPresenter, let c = p.cards, row < c.count {
                return Card.calcRowHeight(c[row], tableView: tableView)
            }
        }
        
        return tableView.rowHeight
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let view = self.view as! CardsView
        let table = notification.object as! NSTableView
        if table === view.holdersList {
            if let p = self.holdersPresenter, let h = p.holders, h.count > table.selectedRow, !(table.selectedRow < 0) {
                view.cardsList.dataSource = self.cardsPresenter
                self.cardsPresenter.loadCards(in: h[table.selectedRow].id, updated: { changes in
                    switch changes {
                    case .initial:
                        view.cardsList.reloadData()
                        
                    case .update(_, let del, let ins, let upd):
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
                view.cardsList.reloadData()
            }
        }
    }
}
