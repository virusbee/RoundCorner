//
//  RoundCorner.swift
//  RoundCorner-Swift
//
//  Created by virusbee on 2021/4/25.
//

import UIKit

struct CornerMask: OptionSet {
    let rawValue: UInt
    init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    static let MinXMinY = CornerMask(rawValue: 1 << 0)
    static let MaxXMinY = CornerMask(rawValue: 1 << 1)
    static let MinXMaxY = CornerMask(rawValue: 1 << 2)
    static let MaxXMaxY = CornerMask(rawValue: 1 << 3)
    static let All: CornerMask = [MinXMinY, MaxXMinY, MinXMaxY, MaxXMaxY]
    static let None = CornerMask(rawValue: UInt(0))
}

struct Configuration {
    var cornerMask: CornerMask?
    var rect: CGRect
    var cornerRadius: CGFloat?
    var fillColor: CGColor?
    var strokeColor: CGColor?
    
    init(rect: CGRect) {
        self.rect = rect
    }
}

extension CALayer {
    private static let RCRoundLayerName = "RCRoundLayer"
    
    func setRoundCorner(config: Configuration) {
        if config.rect.isEmpty {
            return
        }
        
        let layer = CAShapeLayer()
        layer.name = CALayer.RCRoundLayerName
        layer.fillColor = config.fillColor
        layer.strokeColor = config.strokeColor
        
        let path = pathForConfiguration(config: config)
        layer.path = path
        
        self.attach(roundLayer: layer)
    }
    
    private func attach(roundLayer: CAShapeLayer) {
        var existRoundLayer: CALayer?
        
        if let sublayers = self.sublayers {
            for layer in sublayers {
                if layer.name == CALayer.RCRoundLayerName {
                    existRoundLayer = layer
                    break
                }
            }
        }
        
        if let layer = existRoundLayer {
            self.replaceSublayer(layer, with: roundLayer)
        } else {
            self.insertSublayer(roundLayer, at: 0)
        }
    }
    
    /*
               (minX,minY)                 (midX,minY)                 (maxX,minY)
                    * ------------------------- * ------------------------- *
                    |                                                       |
                    |                                                       |
                    |                                                       |
                    |                                                       |
        StartPoint  |                                                       |
        (minX,midY) *                           *                           * (maxX,midY)
                    |                      (midX,midY)                      |
                    |                                                       |
                    |                                                       |
                    |                                                       |
                    |                                                       |
                    * ------------------------- * ------------------------- *
               (minX,maxY)                 (midX,maxY)                 (maxX,maxY)
     */
    private func pathForConfiguration(config: Configuration) -> CGPath {
        let mask = config.cornerMask ?? .None
        let radius = config.cornerRadius ?? 0
        
        let minX = config.rect.minX
        let midX = config.rect.midX
        let maxX = config.rect.maxX
        let minY = config.rect.minY
        let midY = config.rect.midY
        let maxY = config.rect.maxY
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: minX, y: midY))
        
        if mask.contains(.MinXMinY) {
            path.addArc(tangent1End: CGPoint(x: minX, y: minY), tangent2End: CGPoint(x: midX, y: minY), radius: radius)
        } else {
            path.addLine(to: CGPoint(x: minX, y: minY))
            path.addLine(to: CGPoint(x: midX, y: minY))
        }
        
        if mask.contains(.MaxXMinY) {
            path.addArc(tangent1End: CGPoint(x: maxX, y: minY), tangent2End: CGPoint(x: maxX, y: midY), radius: radius)
        } else {
            path.addLine(to: CGPoint(x: maxX, y: minY))
            path.addLine(to: CGPoint(x: maxX, y: midY))
        }
        
        if mask.contains(.MaxXMaxY) {
            path.addArc(tangent1End: CGPoint(x: maxX, y: maxY), tangent2End: CGPoint(x: midX, y: maxY), radius: radius)
        } else {
            path.addLine(to: CGPoint(x: maxX, y: maxY))
            path.addLine(to: CGPoint(x: midX, y: maxY))
        }
        
        if mask.contains(.MinXMaxY) {
            path.addArc(tangent1End: CGPoint(x: minX, y: maxY), tangent2End: CGPoint(x: minX, y: midY), radius: radius)
        } else {
            path.addLine(to: CGPoint(x: minX, y: maxY))
        }
        
        path.addLine(to: CGPoint(x: minX, y: midY))
        
        return path
    }
}
