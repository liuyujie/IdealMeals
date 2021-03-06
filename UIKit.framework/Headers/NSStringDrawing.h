//
//  NSStringDrawing.h
//  UIKit
//
//  Copyright (c) 2011-2012 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/NSAttributedString.h>
#import <UIKit/UIKitDefines.h>

NS_CLASS_AVAILABLE_IOS(6_0) @interface NSStringDrawingContext : NSObject {
@private
}

// Minimum scale factor for drawWithRect:options:context: and boundingRectWithSize:options:context: methods. If this property is set, the extended string drawing methods will attempt to draw the attributed string in the giv'en bounds by proportionally scaling the font(s) in the attributed string
@property(nonatomic) CGFloat minimumScaleFactor;
// Minimum tracking adjustment for drawWithRect:options:context: and boundingRectWithSize:options:context: methods. If this property is set, the extended string drawing methods will attempt to draw the attributed string in the given bounds by adjusting the tracking between the glyphs in the attributed string
@property(nonatomic) CGFloat minimumTrackingAdjustment;

// actual scale factor used by the last drawing call where minimum scale factor was specified
@property(nonatomic, readonly) CGFloat actualScaleFactor;
// actual tracking adjustment used by the last drawing call where minimum tracking factor was specified
@property(nonatomic, readonly) CGFloat actualTrackingAdjustment;

// bounds of the string drawn by the previous invocation of drawWithRect:options:context:
@property(nonatomic, readonly) CGRect totalBounds;

@end

@interface NSAttributedString(NSStringDrawing)
- (CGSize)size NS_AVAILABLE_IOS(6_0);
- (void)drawAtPoint:(CGPoint)point NS_AVAILABLE_IOS(6_0);
- (void)drawInRect:(CGRect)rect NS_AVAILABLE_IOS(6_0);
@end

typedef NS_ENUM(NSInteger, NSStringDrawingOptions) {
    NSStringDrawingTruncatesLastVisibleLine = 1 << 5, // Truncates and adds the ellipsis character to the last visible line if the text doesn't fit into the bounds specified. Ignored if NSStringDrawingUsesLineFragmentOrigin is not also set.
    NSStringDrawingUsesLineFragmentOrigin = 1 << 0, // The specified origin is the line fragment origin, not the base line origin
    NSStringDrawingUsesFontLeading = 1 << 1, // Uses the font leading for calculating line heights
    NSStringDrawingUsesDeviceMetrics = 1 << 3, // Uses image glyph bounds instead of typographic bounds
} NS_ENUM_AVAILABLE_IOS(6_0);

@interface NSAttributedString (NSExtendedStringDrawing)
- (void)drawWithRect:(CGRect)rect options:(NSStringDrawingOptions)options context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(6_0);
- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options context:(NSStringDrawingContext *)context NS_AVAILABLE_IOS(6_0);
@end
