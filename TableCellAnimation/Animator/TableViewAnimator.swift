//
//  TableViewAnimator.swift
//  TableCellAnimation
//
//  Created by ramsey on 03/09/2021.
//

import UIKit

typealias TableCellAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

final class TableViewAnimator {
    private let animation: TableCellAnimation
    
    init(animation: @escaping TableCellAnimation) {
        self.animation = animation
    }
    
    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        animation(cell, indexPath, tableView)
    }
}

enum TableAnimation {
    case fadeIn(duration: TimeInterval, delay: TimeInterval)
    case moveUp(duration: TimeInterval, delay: TimeInterval)
    case moveUpWithFade(duration: TimeInterval, delay: TimeInterval)
    case moveUpBounce(duration: TimeInterval, delay: TimeInterval)
    case moveDown(duration: TimeInterval, delay: TimeInterval)
    case moveDownWithFade(duration: TimeInterval, delay: TimeInterval)
    case moveDownBounce(duration: TimeInterval, delay: TimeInterval)
    
    // provides an animation with duration and delay associated with the case
    func getAnimation() -> TableCellAnimation {
        switch self {
        case .fadeIn(let duration, let delay):
            return TableAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        case .moveUp(let duration, let delay):
            return TableAnimationFactory.makeMoveUpAnimation(duration: duration, delayFactor: delay)
        case .moveUpWithFade(let duration, let delay):
            return TableAnimationFactory.makeMoveUpWithFadeAnimation(duration: duration, delayFactor: delay)
        case .moveUpBounce(let duration, let delay):
            return TableAnimationFactory.makeMoveUpBounceAnimation(duration: duration, delayFactor: delay)
        case .moveDown(let duration, let delay):
            return TableAnimationFactory.makeMoveDownAnimation(duration: duration, delayFactor: delay)
        case .moveDownWithFade(let duration, let delay):
            return TableAnimationFactory.makeMoveDownWithFadeAnimation(duration: duration, delayFactor: delay)
        case .moveDownBounce(let duration, let delay):
            return TableAnimationFactory.makeMoveDownBounceAnimation(duration: duration, delayFactor: delay)
        }
    }
    
    // provides the title based on the case
    func getTitle() -> String {
        switch self {
        case .fadeIn:
            return "Fade-In Animation"
        case .moveUp:
            return "Move-Up Animation"
        case .moveUpWithFade:
            return "Move-Up-Fade Animation"
        case .moveUpBounce:
            return "Move-Up-Bounce Animation"
        case .moveDown:
            return "Move-Down Animation"
        case .moveDownWithFade:
            return "Move-Down-Fade Animation"
        case .moveDownBounce:
            return "Move-Down-Bounce Animation"
        }
    }
}

enum TableAnimationFactory {
    
    /// fades the cell by setting alpha as zero and then animates the cell's alpha based on indexPaths
    static func makeFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                animations: {
                    cell.alpha = 1
            })
        }
    }
    
    /// fades the cell by setting alpha as zero and moves the cell downwards, then animates the cell's alpha and returns it to it's original position based on indexPaths
    static func makeMoveUpWithFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height*1.4)
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })
        }
    }

    /// moves the cell downwards, then animates the cell's by returning them to their original position based on indexPaths
    static func makeMoveUpAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height*1.4)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    /// moves the cell downwards, then animates the cell's by returning them to their original position with spring bounce based on indexPaths
    static func makeMoveUpBounceAnimation(duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height*1.4)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    /// moves the cell upwards, then animates the cell's by returning them to their original position based on indexPaths
    static func makeMoveDownWithFadeAnimation(duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
            cell.alpha = 0
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
                    cell.alpha = 1
            })
        }
    }
    
    /// moves the cell upwards, then animates the cell's by returning them to their original position based on indexPaths
    static func makeMoveDownAnimation(duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
            })
        }
    }
    
    /// moves the cell upwards, then animates the cell's by returning them to their original position with spring bounce based on indexPaths
    static func makeMoveDownBounceAnimation(duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
            })
        }
    }
}
