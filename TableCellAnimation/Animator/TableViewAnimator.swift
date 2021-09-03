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
    case rotate(duration: TimeInterval, delay: TimeInterval)
    case moveRight(duration: TimeInterval, delay: TimeInterval)
    case moveRightWithFade(duration: TimeInterval, delay: TimeInterval)
    case moveRightBounce(duration: TimeInterval, delay: TimeInterval)
    case moveLeft(duration: TimeInterval, delay: TimeInterval)
    case moveLeftWithFade(duration: TimeInterval, delay: TimeInterval)
    case moveLeftBounce(duration: TimeInterval, delay: TimeInterval)
    case moveLinearBounce(duration: TimeInterval, delay: TimeInterval)
    case zoomOutBounce(duration: TimeInterval, delay: TimeInterval)
    case moveCenterBounce(duration: TimeInterval, delay: TimeInterval)
    case cardDropBounce(duration: TimeInterval, delay: TimeInterval)
    
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
        case .rotate(let duration, let delay):
            return TableAnimationFactory.makeRotationAnimation(duration: duration, delayFactor: delay)
        case .moveRight(let duration, let delay):
            return TableAnimationFactory.makeMoveRightAnimation(duration: duration, delayFactor: delay)
        case .moveRightWithFade(let duration, let delay):
            return TableAnimationFactory.makeMoveRightWithFadeAnimation(duration: duration, delayFactor: delay)
        case .moveRightBounce(let duration, let delay):
            return TableAnimationFactory.makeMoveRightBounceAnimation(duration: duration, delayFactor: delay)
        case .moveLeft(let duration, let delay):
            return TableAnimationFactory.makeMoveLeftAnimation(duration: duration, delayFactor: delay)
        case .moveLeftWithFade(let duration, let delay):
            return TableAnimationFactory.makeMoveLeftWithFadeAnimation(duration: duration, delayFactor: delay)
        case .moveLeftBounce(let duration, let delay):
            return TableAnimationFactory.makeMoveLeftBounceAnimation(duration: duration, delayFactor: delay)
        case .moveLinearBounce(let duration, let delay):
            return TableAnimationFactory.makeMoveLinearBounceAnimation(duration: duration, delayFactor: delay)
        case .zoomOutBounce(let duration, let delay):
            return TableAnimationFactory.makeZoomOutBounceAnimation(duration: duration, delayFactor: delay)
        case .moveCenterBounce(let duration, let delay):
            return TableAnimationFactory.makeMoveCenterBounceAnimation(duration: duration, delayFactor: delay)
        case .cardDropBounce(let duration, let delay):
            return TableAnimationFactory.makeCardDropBounceAnimation(duration: duration, delayFactor: delay)
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
        case .rotate:
            return "Rotate Animation"
        case .moveRight:
            return "Move-Right Animation"
        case .moveRightWithFade:
            return "Move-Right-Fade Animation"
        case .moveRightBounce:
            return "Move-Right-Bounce Animation"
        case .moveLeft:
            return "Move-Left Animation"
        case .moveLeftWithFade:
            return "Move-Left-Fade Animation"
        case .moveLeftBounce:
            return "Move-Left-Bounce Animation"
        case .moveLinearBounce:
            return "Move-Linear-Bounce Animation"
        case .zoomOutBounce:
            return "Move-Zoom-Out-Bounce Animation"
        case .moveCenterBounce:
            return "Move-Center-Bounce Animation"
        case .cardDropBounce:
            return "Card-Drop-Bounce Animation"
        }
    }
}

enum TableAnimationFactory {
    static let TipInCellAnimatorStartTransform: CATransform3D = {
        let rotationDegrees: CGFloat = -15.0
        let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
        let offset = CGPoint(x: -20, y: -20)
        var startTransform = CATransform3DIdentity
        startTransform = CATransform3DRotate(CATransform3DIdentity,
                                             rotationRadians, 0.0, 0.0, 1.0)
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
        
        return startTransform
    }()
    
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
    
    /// Rotate the cell
    static func makeRotationAnimation(duration: TimeInterval, delayFactor: Double) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(rotationAngle: 360)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(rotationAngle: 0.0)
            })
        }
    }
    
    static func makeMoveRightAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                  cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
            })
        }
    }
    
    static func makeMoveRightWithFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
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
    
    static func makeMoveRightBounceAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
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
    
    static func makeMoveLeftAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                  cell.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    static func makeMoveLeftWithFadeAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
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
    
    static func makeMoveLeftBounceAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: 0)
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
    
    static func makeMoveLinearBounceAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
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
    
    static func makeZoomOutBounceAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.transform = CGAffineTransform(scaleX: 0, y : 0)
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(scaleX: 1, y : 1)
            })
        }
    }
    
    static func makeMoveCenterBounceAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            cell.center.x += 200
            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.1,
                options: [.curveEaseInOut],
                animations: {
                    cell.center.x -= 200
            })
        }
    }
    
    static func makeCardDropBounceAnimation(duration: TimeInterval, delayFactor: TimeInterval) -> TableCellAnimation {
        return { cell, indexPath, tableView in
            let view = cell.contentView
            view.layer.transform = TipInCellAnimatorStartTransform
            view.layer.opacity = 0.8
            UIView.animate(
                withDuration: duration,
                animations: {
                    view.layer.transform = CATransform3DIdentity
                    view.layer.opacity = 1
            })
        }
    }
}
