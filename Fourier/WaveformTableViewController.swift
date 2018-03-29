//
//  WaveformTableViewController.swift
//  Fourier
//
//  Created by Blocry Glass on 3/29/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import UIKit

public class WaveformTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var waveFormViewControllers = [WaveformViewController]()
    private var tableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waveFormViewControllers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let waveFormView = waveFormViewControllers[indexPath.row].view!
        let cell = tableView.dequeueReusableCell(withIdentifier: "plain") ?? UITableViewCell(style: .default, reuseIdentifier: "plain")
        cell.contentView.fillSelfWith(subView: waveFormView)
        return cell
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        view.fillSelfWith(subView: tableView)
    }
    
    public func addWaveForm(withFrequency frequency: Int) {
        let waveFormViewController = WaveformViewController()
        waveFormViewController.mediaType = .frequency(frequency)
        waveFormViewController.titleText = String(frequency) + " Hz"
        waveFormViewControllers.append(waveFormViewController)
    }
}

