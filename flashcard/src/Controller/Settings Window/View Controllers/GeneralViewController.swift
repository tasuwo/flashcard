//
//  GeneralViewController.swift
//  flashcard
//
//  Created by Tasuku Tozawa on 2017/03/22.
//  Copyright © 2017年 tasuku tozawa. All rights reserved.
//

import Cocoa
import KeyHolder
import Magnet

class GeneralViewController: NSViewController {
    var holdersPresenter: CardHoldersListPresenter!

    override func loadView() {
        let winSize = SettingsWindowController.defaultSize()
        let view = GeneralView(frame: NSMakeRect(0, 0, winSize.width, winSize.height))
        view.hotkeyDelegate = self

        holdersPresenter = CardHoldersListPresenter()
        holdersPresenter.load(updated: { changes in
            switch changes {
            case .initial:
                view.defaultHolderTableView.reloadData()
                if let s = AppSettings.get(), let hi = s.defaultHolderId, let h = CardHolder.get(hi), let i = self.holdersPresenter.holders?.index(of: h) {
                    view.defaultHolderTableView.selectRowIndexes(IndexSet([i]), byExtendingSelection: false)
                }

            case let .update(_, del, ins, upd):
                view.defaultHolderTableView.beginUpdates()
                view.defaultHolderTableView.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                view.defaultHolderTableView.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                view.defaultHolderTableView.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                view.defaultHolderTableView.endUpdates()
                if let s = AppSettings.get(), let hi = s.defaultHolderId, let h = CardHolder.get(hi), let i = self.holdersPresenter.holders?.index(of: h) {
                    view.defaultHolderTableView.selectRowIndexes(IndexSet([i]), byExtendingSelection: false)
                }

            default: break
            }
        })
        view.defaultHolderTableView.dataSource = self.holdersPresenter
        view.defaultHolderTableView.delegate = self

        self.view = view
    }
}

extension GeneralViewController: RecordViewDelegate {
    func recordViewShouldBeginRecording(_: RecordView) -> Bool {
        return true
    }

    func recordView(_: RecordView, canRecordKeyCombo _: KeyCombo) -> Bool {
        // You can customize validation
        return true
    }

    func recordViewDidClearShortcut(_ recordView: RecordView) {
        if let id = recordView.identifier,
            let settings = AppSettings.get() {
            switch id {
            case "Play":
                settings.playKeyCombo = nil
            case "Search":
                settings.searchKeyCombo = nil
            default:
                break
            }
            settings.apply()
            settings.save()
        }
    }

    func recordViewDidEndRecording(_: RecordView) {
    }

    func recordView(_ recordView: RecordView, didChangeKeyCombo keyCombo: KeyCombo) {
        if let id = recordView.identifier {
            let settings = AppSettings.get() ?? AppSettings(playKeyCombo: nil, searchKeyCombo: nil)
            switch id {
            case "Play":
                settings.playKeyCombo = keyCombo
            case "Search":
                settings.searchKeyCombo = keyCombo
            default:
                break
            }
            settings.apply()
            settings.save()
        }
    }
}

extension GeneralViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor _: NSTableColumn?, row _: Int) -> NSView? {

        var result = tableView.make(withIdentifier: "cardHolderCell", owner: nil) as? NSTextField

        if result == nil {
            result = NSTextField()
            result!.isBordered = false
            result!.drawsBackground = false
            result!.isBezeled = false
            result!.isEditable = false
            result!.identifier = "cardHolderCell"
        }

        return result
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let table = notification.object as! NSTableView
        if let p = self.holdersPresenter, let h = p.holders, !(table.selectedRow < 0), h.count > table.selectedRow {
            let settings = AppSettings.get() ?? AppSettings()
            settings.defaultHolderId = h[table.selectedRow].id
            settings.save()
        }
    }
}
