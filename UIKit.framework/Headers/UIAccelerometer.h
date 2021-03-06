//
//  UIAccelerometer.h
//  UIKit
//
//  Copyright (c) 2007-2012, Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>

/* UIAcceleration and UIAccelerometer are deprecated as of iOS 5.0. These classes have been replaced by the Core Motion framework. These classes will be marked with formal deprecation attributes in a future release of iOS.
 */

typedef double UIAccelerationValue;

@protocol UIAccelerometerDelegate;

NS_CLASS_AVAILABLE_IOS(2_0)
@interface UIAcceleration : NSObject {
  @private
    NSTimeInterval timestamp;
    UIAccelerationValue x, y, z;
}

@property(nonatomic,readonly) NSTimeInterval timestamp;
@property(nonatomic,readonly) UIAccelerationValue x;
@property(nonatomic,readonly) UIAccelerationValue y;
@property(nonatomic,readonly) UIAccelerationValue z;

@end

NS_CLASS_AVAILABLE_IOS(2_0)
@interface UIAccelerometer : NSObject {
  @private
    NSTimeInterval               _updateInterval;
    id <UIAccelerometerDelegate> _delegate;
    struct {
        unsigned int delegateDidAccelerate:1;
        unsigned int reserved:31;
    } _accelerometerFlags;
}

+ (UIAccelerometer *)sharedAccelerometer;

@property(nonatomic) NSTimeInterval updateInterval; //May be capped at a minimum interval
@property(nonatomic,assign) id<UIAccelerometerDelegate> delegate;

@end

@protocol UIAccelerometerDelegate<NSObject>
@optional

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration NS_DEPRECATED_IOS(2_0, 5_0);

@end
