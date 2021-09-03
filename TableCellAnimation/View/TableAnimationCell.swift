//
//  TableAnimationCell.swift
//  TableCellAnimation
//
//  Created by ramsey on 03/09/2021.
//

import UIKit

class TableAnimationCell: UITableViewCell {
       
    // MARK: - Pubilc Properties
    var color = UIColor.white {
        didSet {
            self.containerView.backgroundColor = color
        }
    }
    // MARK: - Public Methods
    
    // MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubComponents()
        addSubComponets()
        layoutSubComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initSubComponents()
        addSubComponets()
        layoutSubComponents()
    }
    
    // MARK: - Super Delegate Methods
    override class func description() -> String {
        return String(describing: TableAnimationCell.self)
    }
    
    override func layoutSubviews() {
        layoutSubComponents()
    }
    
    // MARK: - Private Properties
    private let containerView = UIView()
    
    // MARK: - Private Methods
    private func initSubComponents() {
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
        selectionStyle = .none
    }
    
    private func addSubComponets() {
        addSubview(containerView)
    }
    
    private func layoutSubComponents() {
        containerView.frame = CGRect(x: 12, y: 5, width: bounds.width-24, height: bounds.height-10)
    }
}
