//
//  UITableView+Extension.swift
//  GitRepos
//
//  Created by Abdullah on 01/01/2024.
//

import UIKit

// MARK: - UITableView Extensions
extension UITableView {

    func showLoading() {
        let container = UIView()
        
        let activity: UIActivityIndicatorView = {
            let activity = UIActivityIndicatorView.init(style: .large)
            activity.startAnimating()
            return activity
        }()
        
        container.addSubviews(activity)
        container.backgroundColor = .hexE5E5E5
        activity.placeAtCenterOf(centerY: container.centerYAnchor, centerX: container.centerXAnchor, size: .init(width: 30, height: 30))

        backgroundView = container
    }
    
    func setNoValuesFoundBackgroundMessage(_ message: String = "Data not found", separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        //messageLabel.textColor = .aLabel
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        //messageLabel.font = .avenirRegular(size: 15)
        messageLabel.sizeToFit()

        backgroundView = messageLabel
        isScrollEnabled = false
        self.separatorStyle = separatorStyle
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    func removeBackgroundView(separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        self.backgroundView = nil
        self.isScrollEnabled = true
        self.separatorStyle = separatorStyle
    }
    
    func registerCellNib<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
    /// Shows a loader on the table view when the user drags it down and triggers a refresh action.
    /// - Parameters:
    ///   - target: The object that will handle the refresh action.
    ///   - selector: The selector that will handle the refresh action.
    func addRefreshControl(target: Any, action: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        self.refreshControl?.beginRefreshing()
    }
    
    /// Hides the loader on the table view after the refresh action is complete.
    func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }
}
