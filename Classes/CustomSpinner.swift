//
//  CustomSpinner.swift
//  CustomSpinner
//
//  Created by WYH IOS  on 30/10/23.
//

import Foundation
import UIKit


@IBDesignable class CustomSpinner : UIView {
    
    
    //Dot Attributes
    @IBInspectable var dotSize : CGFloat = 10 {
        didSet {
            drawBoll()
        }
    }
    @IBInspectable var dotFillColor : UIColor = UIColor.red {
        didSet {
            dotView?.backgroundColor = dotFillColor
        }
    }
    
    //Line Attribues
    @IBInspectable var lineFillColor : UIColor = UIColor.black {
        didSet {
            line.strokeColor = lineFillColor.cgColor
        }
    }
    
    let line = CAShapeLayer()
    var dotView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        animationBallVerticalBounce(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        animationBallVerticalBounce(self)
    }
    
    
    private func animationBallVerticalBounce(_ view: UIView) {
        

        line.strokeColor = lineFillColor.cgColor
        line.lineWidth = view.frame.height / 15
        line.lineCap = .round
        line.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(line)


        let animationSpringCurve = CAKeyframeAnimation(keyPath: "path")
        animationSpringCurve.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animationSpringCurve.duration = 0.4
        animationSpringCurve.values = [initialCurvePath(view).cgPath, downCurvePath(view).cgPath]
        animationSpringCurve.autoreverses = true

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationSpringCurve]
        animationGroup.duration = 0.8
        animationGroup.repeatCount = .infinity

        line.add(animationGroup, forKey: "animationSpringCurve")
        let curvePath = downCurvePath(view).cgPath
        line.path = curvePath
        
        drawBoll()
    }

    private func initialCurvePath(_ view: UIView) -> UIBezierPath {
        let width = view.frame.size.width
        let height = view.frame.size.height + view.frame.size.height / 3
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addQuadCurve(to: CGPoint(x: width, y: height / 2), controlPoint: CGPoint(x: width / 2, y: height / 2))
        return path
    }

    private func downCurvePath(_ view: UIView) -> UIBezierPath {
        let width = view.frame.size.width
        let height = view.frame.size.height + view.frame.size.height / 3
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: height / 2))
        path.addQuadCurve(to: CGPoint(x: width, y: height / 2), controlPoint: CGPoint(x: width / 2, y: height / 1.1))
        return path
    }

    private func drawBoll() {
        
        dotView = UIView(frame: CGRect(x: self.frame.width/2 - dotSize/2, y: 0, width: dotSize, height: dotSize))
        dotView?.layer.cornerRadius = dotSize/2
        dotView?.backgroundColor = dotFillColor
        self.addSubview(dotView ?? UIView())
        
        let bollBounsAnimation = CABasicAnimation(keyPath: "position.y")
        bollBounsAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        bollBounsAnimation.duration = 0.4
        bollBounsAnimation.fromValue = 0
        bollBounsAnimation.toValue = self.frame.height/1.4
        bollBounsAnimation.repeatCount = .infinity
        bollBounsAnimation.autoreverses = true
        dotView?.layer.add(bollBounsAnimation, forKey: "bollBounsAnimation")
    }
    
}
