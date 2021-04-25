//
//  CALayer+RoundCorner.h
//  RoundLayer
//
//  Created by virusbee on 2021/4/23.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS (NSUInteger, RCCornerMask) {
    RCCornerMaskMinXMinY = 1U << 0,
    RCCornerMaskMaxXMinY = 1U << 1,
    RCCornerMaskMinXMaxY = 1U << 2,
    RCCornerMaskMaxXMaxY = 1U << 3,
    RCCornerMaskAll = (RCCornerMaskMinXMinY | RCCornerMaskMaxXMinY | RCCornerMaskMinXMaxY | RCCornerMaskMaxXMaxY),
};


@interface RCConfiguration : NSObject

@property RCCornerMask cornerMask;
@property CGRect rect;
@property CGFloat cornerRadius;
@property(nullable) CGColorRef fillColor;
@property(nullable) CGColorRef strokeColor;

@end


@interface CALayer (RoundCorner)

- (void)setRoundCorner:(RCConfiguration *)config;

@end

NS_ASSUME_NONNULL_END
