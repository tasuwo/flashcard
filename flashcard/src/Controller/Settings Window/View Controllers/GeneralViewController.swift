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
    var presenter: CardHolderPresenter
    var settings: AppSettings
    var generalView: GeneralView!

    convenience init() {
        self.init(presenter: CardHolderPresenterImpl(), appSettings: AppSettingsImpl())
    }

    init(presenter: CardHolderPresenter, appSettings: AppSettings) {
        self.presenter = presenter
        self.settings = appSettings
        super.init(nibName: nil, bundle: nil)!
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let winSize = SettingsWindowController.defaultSize()
        self.generalView = GeneralView(frame: NSMakeRect(0, 0, winSize.width, winSize.height))
        generalView.hotkeyDelegate = self

        let tableView = generalView.defaultHolderTableView!
        presenter.load(targetTableView: tableView)
        tableView.dataSource = presenter
        tableView.delegate = self

        self.view = generalView
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
        if let id = recordView.identifier {
            do {
                try settings.setKeyCombo(id, value: nil)
            } catch AppSettingsError.NoSuchKey {
                print("Unexpected key was passed to AppSettings. Check the definition of row identifier in record view.")
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("A Row identifier in record view is nil. Check the definition.")
        }
    }

    func recordViewDidEndRecording(_: RecordView) {
    }

    func recordView(_ recordView: RecordView, didChangeKeyCombo keyCombo: KeyCombo) {
        if let id = recordView.identifier {
            do {
                try settings.setKeyCombo(id, value: keyCombo)
            } catch AppSettingsError.NoSuchKey {
                print("Unexpected key was passed to AppSettings. Check the definition of row identifier in record view.")
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("A Row identifier in record view is nil. Check the definition.")
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
        didSelectDefaultHolder(row: table.selectedRow)
    }

    func didSelectDefaultHolder(row: Int) {
        if let selectedHolder = presenter.getHolder(at: row) {
            settings.setDefaultHolderId(selectedHolder.id)
        }
    }
}
