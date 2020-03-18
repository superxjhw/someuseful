//
//  SPView.m
//  Quartz 2D
//
//  Created by Super Y on 2020/3/18.
//  Copyright © 2020 Super Y. All rights reserved.
//

#import "SPView.h"

@implementation SPView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self testGradient];
}

- (void)testGradient {
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    
    // Creating a CGGradient object
    CGColorSpaceRef myColorspace;
    size_t num_locations = 3;
    CGFloat locations[4] = { 0.0, 0.3, 1.0 };
    CGFloat components[12] = { 0.0, 1.0, 0.5, 1.0,  // Start color
                               0.0, 0.2, 1.0, 1.0,
                               1.0, 0.2, 0.0, 0.9 }; // End color
//    myColorspace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    // In iOS, where generic RGB color spaces are not available, your code should call CGColorSpaceCreateDeviceRGB instead
    myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                              locations, num_locations);
    
    /*
    // Painting an axial gradient using a CGGradient object
    CGPoint myStartPoint = CGPointMake(0, 0);
    CGPoint myEndPoint = CGPointMake(300, 300);
    CGContextDrawLinearGradient (myContext, myGradient, myStartPoint, myEndPoint, kCGGradientDrawsBeforeStartLocation);
     */
    
    // Painting a radial gradient using a CGGradient object
    CGPoint startCenter = self.center;
    CGPoint endCenter = startCenter;
    CGFloat startRadius = 0;
    CGFloat endRadius = 200;
    CGContextDrawRadialGradient(myContext, myGradient, startCenter, startRadius, endCenter, endRadius, kCGGradientDrawsBeforeStartLocation);
}

@end
