//
//  TableController.swift
//  GeoTag
//
//  Created by Marco S Hyman on 6/24/14.
//  Copyright (c) 2014 Marco S Hyman. All rights reserved.
//

import Cocoa

@objc(TableViewController)
class TableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet var tableView: NSTableView
    var images: [ImageData] = []

    // startup

    override func viewDidLoad() {       // 10.10 and later
        super.viewDidLoad()
    }

    func addImageNamed(name: String) {
        images.append(ImageData(path: NSURL(string: name)))
    }

    // data source functions
    
    func numberOfRowsInTableView(tableView: NSTableView!) -> Int {
        addImageNamed("file:///Users/marc/Desktop/p-141711415-1432.jpg")
        addImageNamed("file:///Users/marc/Desktop/p-141660942-1403.raf")
        // Number of active rows
        println("\(images.count) active rows")
        println("arg: \(tableView) outlet: \(self.tableView)")
        return images.count
    }

    func tableView(tableView: NSTableView!,
        viewForTableColumn tableColumn: NSTableColumn!,
        row: Int) -> NSView! {
        let image = images[row]
        var value = ""
        if let id = tableColumn.identifier {
            switch id {
            case "imageName":
                value = image.name
            case "dateTime":
                value = image.date
            case "latitude":
                if let lat = image.latitude {
                    value = NSString(format: "% 2.6f", lat)
                }
            case "longitude":
                if let lon = image.longitude {
                    value = NSString(format: "% 2.6f", lon)
                }
            default:
                break
            }
            var colView = tableView.makeViewWithIdentifier(id, owner: nil) as NSTableCellView
            colView.textField.stringValue = value;
            return colView
        }
        return nil
    }
}