//
//  ViewController.swift
//  TableCellAnimation
//
//  Created by ramsey on 03/09/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Pubilc Properties
    
    // MARK: - Public Methods
    
    // MARK: - Init Methods
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubComponents()
        addSubComponets()
        layoutSubComponents()
    }
    
    // MARK: - Super Delegate Methods
    
    // MARK: - Private Properties
    private let tableView = UITableView()
    private let cellColor = [UIColor(named: "BlueJeans"), UIColor(named: "CaribbeanGreen"), UIColor(named: "DeepSaffron"), UIColor(named: "GlossyGrape"), UIColor(named: "Rose"), UIColor(named: "YelloCrayola")]
    private var animationSeg = UISegmentedControl()
    private var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.85, delay: 0.03)
    private var animationDuration: TimeInterval = 0.85
    private var delay: TimeInterval = 0.05
    
    // MARK: - Private Methods
    private func initSubComponents() {
        view.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.3)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.register(TableAnimationCell.self, forCellReuseIdentifier: TableAnimationCell.description())
        animationSeg = UISegmentedControl(items: ["1", "2", "3", "4", "5", "6", "7"])
        animationSeg.addTarget(self, action: #selector(chooseAni(sender:)), for: .valueChanged)
        animationSeg.selectedSegmentIndex = 0
        animationSeg.backgroundColor = UIColor(named: "AccentColor")
        animationSeg.layer.cornerRadius = 4
        animationSeg.layer.masksToBounds = true
    }

    private func addSubComponets() {
        view.addSubview(tableView)
        view.addSubview(animationSeg)
    }

    private func layoutSubComponents() {
        tableView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: view.bounds.width, height: view.bounds.height*0.9))
        animationSeg.frame = CGRect(x: 5, y: tableView.frame.height+10, width: view.bounds.width-10, height: 45)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Event Response
    @objc private func chooseAni(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentTableAnimation = TableAnimation.fadeIn(duration: animationDuration, delay: delay)
        case 1:
            currentTableAnimation = TableAnimation.moveUp(duration: animationDuration, delay: delay)
        case 2:
            currentTableAnimation = TableAnimation.moveUpWithFade(duration: animationDuration, delay: delay)
        case 3:
            currentTableAnimation = TableAnimation.moveUpBounce(duration: animationDuration + 0.2, delay: delay)
        case 4:
            currentTableAnimation = TableAnimation.moveDown(duration: animationDuration, delay: delay)
        case 5:
            currentTableAnimation = TableAnimation.moveDownWithFade(duration: animationDuration, delay: delay)
        case 6:
            currentTableAnimation = TableAnimation.moveDownBounce(duration: animationDuration + 0.2, delay: delay)
        default:
            currentTableAnimation = TableAnimation.fadeIn(duration: animationDuration, delay: delay)
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableAnimationCell.description(), for: indexPath) as? TableAnimationCell else { return UITableViewCell() }
        cell.color = cellColor[indexPath.row%6] ?? UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 42))
        headerView.backgroundColor = .clear
        
        let label = UILabel()
        label.frame = CGRect(x: 24, y: 12, width: self.view.frame.width, height: 42)
        label.text = currentTableAnimation.getTitle()
        label.textColor = UIColor(named: "Rose")?.withAlphaComponent(0.9)
        label.font = UIFont.systemFont(ofSize: 26, weight: .medium)
        label.backgroundColor = .clear
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}
