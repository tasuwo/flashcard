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
        let winSize = SettingsWindowController.winSize
        let view = GeneralView(frame: NSMakeRect(0,0,winSize.width, winSize.height))
        view.hotkeyDelegate = self
        
        holdersPresenter = CardHoldersListPresenter()
        holdersPresenter.load(updated:{ changes in
            switch changes {
            case .initial:
                view.defaultHolderTableView.reloadData()
                if let s = AppSettings.get(), let h = s.defaultHolder, let i = self.holdersPresenter.holders?.index(of: h) {
                    view.defaultHolderTableView.selectRowIndexes(IndexSet([i]), byExtendingSelection: false)
                }
                
            case .update(_, let del, let ins, let upd):
                view.defaultHolderTableView.beginUpdates()
                view.defaultHolderTableView.insertRows(at: IndexSet(ins), withAnimation: .slideDown)
                view.defaultHolderTableView.reloadData(forRowIndexes: IndexSet(upd), columnIndexes: IndexSet(integer: 0))
                view.defaultHolderTableView.removeRows(at: IndexSet(del), withAnimation: .slideUp)
                view.defaultHolderTableView.endUpdates()
                if let s = AppSettings.get(), let h = s.defaultHolder, let i = self.holdersPresenter.holders?.index(of: h) {
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

extension GeneralViewController : RecordViewDelegate {
    func recordViewShouldBeginRecording(_ recordView: RecordView) -> Bool {
        return true
    }
    
    func recordView(_ recordView: RecordView, canRecordKeyCombo keyCombo: KeyCombo) -> Bool {
        // You can customize validation
        return true
    }
    
    func recordViewDidClearShortcut(_ recordView: RecordView) {
        // TODO: Remove hot key and save it to userdefault
    }
    
    func recordViewDidEndRecording(_ recordView: RecordView) {
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
            settings.setHotKey()
            settings.save()
        }
    }
}

extension GeneralViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
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
            settings.defaultHolder = h[table.selectedRow]
            settings.save()
        }
    }
}
