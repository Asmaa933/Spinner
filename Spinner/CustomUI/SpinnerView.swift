//
//  SpinnerView.swift
//  Spinner
//
//  Created by Asmaa Tarek on 13/09/2021.
//

import UIKit

class SpinnerView: UIView {

    private let mainLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showSpinner() {
        mainLayer.frame = self.bounds
        createFirstLayer()
        createSecondLayer()
        self.layer.addSublayer(mainLayer)
        mainLayer.add(createRotationAnimation(),
                      forKey: "rotation")
            
    }

    func removeSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeLoadingLayers()
            self.createSuccessLayer()
        }
    }
}

private extension SpinnerView {
    
    func configureLayer(_ layer: CAShapeLayer) {
        layer.lineWidth = 5
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
    }
    
    func createFirstLayer() {
        let firstLayer = CAShapeLayer()
        configureLayer(firstLayer)
        firstLayer.path = createFirstArrowPath(center: CGPoint(x: mainLayer.bounds.width / 2,
                                                               y: mainLayer.bounds.height / 2))
        mainLayer.addSublayer(firstLayer)
    }
    
    func createFirstArrowPath(center: CGPoint) -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: center,
                    radius: calculateRadius(center: center),
                    startAngle: (2 * .pi) * 12 / 16,
                    endAngle: (2 * .pi) * 3 / 16 ,
                    clockwise: true)
        let currentPoint = path.currentPoint
        path.move(to: CGPoint(x: currentPoint.x - 5, y: currentPoint.y))
        path.addLine(to: CGPoint(x: currentPoint.x , y: currentPoint.y + 5))
        path.addLine(to: CGPoint(x: currentPoint.x , y: currentPoint.y - 5))
        path.close()
        return path.cgPath
    }
    
    func createSecondLayer() {
        let secondLayer = CAShapeLayer()
        configureLayer(secondLayer)
        secondLayer.path = createSecondArrowPath(center: CGPoint(x: mainLayer.bounds.width / 2,
                                                                y: mainLayer.bounds.height / 2))
        mainLayer.addSublayer(secondLayer)
    }
    
    func createSecondArrowPath(center: CGPoint) -> CGPath {
        let path = UIBezierPath()
        path.addArc(withCenter: center,
                    radius: calculateRadius(center: center),
                    startAngle: (2 * .pi) * 4 / 16,
                    endAngle: (2 * .pi) * 11 / 16 ,
                    clockwise: true)
       let currentPoint = path.currentPoint
        path.move(to: CGPoint(x: currentPoint.x + 5, y: currentPoint.y))
        path.addLine(to: CGPoint(x: currentPoint.x , y: currentPoint.y + 5))
        path.addLine(to: CGPoint(x: currentPoint.x , y: currentPoint.y - 5))
        path.close()
        return path.cgPath
    }
    
    
    func calculateRadius(center: CGPoint) -> CGFloat {
        var radius = center.x > center.y ? center.x : center.y
        if radius > 50 {
            radius = 50
        }
        return radius - 8
    }
    
    func createRotationAnimation() -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 2
        rotationAnimation.repeatCount = .infinity
        return rotationAnimation
    }
    
    func removeLoadingLayers() {
        self.mainLayer.removeAnimation(forKey: "rotation")
        self.mainLayer.sublayers?.removeAll()
    }
    
    func createSuccessLayer() {
        let successLayer = CAShapeLayer()
        let path = UIBezierPath()
        let layerCenter = CGPoint(x: mainLayer.bounds.width / 2,
                                  y: mainLayer.bounds.height / 2)
        path.addArc(withCenter: layerCenter,
                    radius: calculateRadius(center: center),
                    startAngle: 0,
                    endAngle: 2 * .pi,
                    clockwise: true)
        successLayer.path = path.cgPath
        successLayer.fillColor = UIColor.green.cgColor
        mainLayer.addSublayer(successLayer)
        let checkMarkLayer = createCheckMarkLayer()
        checkMarkLayer.add(createCheckMarkAnimation(), forKey: "checkMarkAnimation")
        successLayer.addSublayer(checkMarkLayer)
    }
    
    // To Do make checkmark depend on size
    func createCheckMarkLayer() -> CAShapeLayer {
        let checkMarkLayer = CAShapeLayer()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20 , y: 50))
        path.addLine(to: CGPoint(x: 45, y:  75))
        path.addLine(to: CGPoint(x: 70, y: 20))
        checkMarkLayer.fillColor = UIColor.clear.cgColor
        checkMarkLayer.strokeColor = UIColor.white.cgColor
        checkMarkLayer.lineWidth = 5
        checkMarkLayer.path = path.cgPath
        return checkMarkLayer
    }
    
    func createCheckMarkAnimation() -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.isRemovedOnCompletion = true
        animation.delegate = self
        return animation
    }
}

extension SpinnerView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.removeFromSuperview()
    }
}
