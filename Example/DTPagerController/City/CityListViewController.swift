//
//  TableViewController.swift
//  DTOverlayController_Example
//
//  Created by Tung Vo on 9.6.2019.
//

import UIKit

// swiftlint:disable line_length

class CityListViewController: UITableViewController {
    enum CellType {
        case light
        case dark
    }

    var type: CellType

    var cities: [City] = [City.Amsterdam,
                          City.Bangkok,
                          City.Barcelona,
                          City.Berlin,
                          City.Lisbon,
                          City.London,
                          City.NewYork,
                          City.SanFrancisco,
                          City.Stockholm,
                          City.Tokyo
                          ]

    init(cellType: CellType) {
        type = cellType
        super.init(nibName: nil, bundle: nil)
        title = "Cities"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let cellIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension

        if case .light = type {
            tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        } else {
            tableView.register(UINib(nibName: "AlternativeCityTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]

        if case .light = type {
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CityTableViewCell
            cell.populate(from: city)
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlternativeCityTableViewCell
        cell.populate(from: city)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        let viewController = CityDetailViewController(city: city)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
