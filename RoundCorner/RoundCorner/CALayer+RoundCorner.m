//
//  CALayer+RoundCorner.m
//  RoundLayer
//
//  Created by virusbee on 2021/4/23.
//

#import "CALayer+RoundCorner.h"

static NSString *const RCRoundLayerName = @"RCRoundLayer";

@implementation RCConfiguration
@end

@implementation CALayer (RoundCorner)

- (void)setRoundCorner:(RCConfiguration *)config {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.name = RCRoundLayerName;
    layer.fillColor = config.fillColor;
    layer.strokeColor = config.strokeColor;
    
    CGPathRef path = [self pathForConfiguration:config];
    layer.path = path;
    CGPathRelease(path);
    
    [self attach:layer];
}

- (void)attach:(CAShapeLayer *)roundLayer {
    CALayer *existRoundLayer = nil;
    for (CALayer *layer in self.sublayers) {
        if ([layer.name isEqualToString:RCRoundLayerName]) {
            existRoundLayer = layer;
            break;
        }
    }

    if (existRoundLayer) {
        [self replaceSublayer:existRoundLayer with:roundLayer];
    } else {
        [self insertSublayer:roundLayer atIndex:0];
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
- (CGPathRef)pathForConfiguration:(RCConfiguration *)config {
    RCCornerMask mask = config.cornerMask;
    CGFloat radius = config.cornerRadius;
    
    CGFloat minX = CGRectGetMinX(config.rect);
    CGFloat midX = CGRectGetMidX(config.rect);
    CGFloat maxX = CGRectGetMaxX(config.rect);
    CGFloat minY = CGRectGetMinY(config.rect);
    CGFloat midY = CGRectGetMidY(config.rect);
    CGFloat maxY = CGRectGetMaxY(config.rect);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, minX, midY);
    
    if (mask & RCCornerMaskMinXMinY) {
        CGPathAddArcToPoint(path, nil, minX, minY, midX, minY, radius);
    } else {
        CGPathAddLineToPoint(path, nil, minX, minY);
        CGPathAddLineToPoint(path, nil, midX, minY);
    }
    
    if (mask & RCCornerMaskMaxXMinY) {
        CGPathAddArcToPoint(path, nil, maxX, minY, maxX, midY, radius);
    } else {
        CGPathAddLineToPoint(path, nil, maxX, minY);
        CGPathAddLineToPoint(path, nil, maxX, midY);
    }
    
    if (mask & RCCornerMaskMaxXMaxY) {
        CGPathAddArcToPoint(path, nil, maxX, maxY, midX, maxY, radius);
    } else {
        CGPathAddLineToPoint(path, nil, maxX, maxY);
        CGPathAddLineToPoint(path, nil, midX, maxY);
    }
    
    if (mask & RCCornerMaskMinXMaxY) {
        CGPathAddArcToPoint(path, nil, minX, maxY, minX, midY, radius);
    } else {
        CGPathAddLineToPoint(path, nil, minX, maxY);
    }
    
    CGPathAddLineToPoint(path, nil, minX, midY);
    
    return path;
}

@end
