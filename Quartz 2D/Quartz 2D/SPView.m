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
    
//    [self testGradient];
    [self testCGShading];
}

#pragma mark- Gradient
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
    
    // release
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
}

#pragma mark- CGShading
- (void)testCGShading {
    /*
    To paint the axial gradient shown in the figure, follow the steps explained in these sections:

    1. Set Up a CGFunction Object to Compute Color Values
    2. Create a CGShading Object for an Axial Gradient
    3. Clip the Context
    4. Paint the Axial Gradient Using a CGShading Object
    5. Release Objects
     
    To paint a radial gradient, follow the steps explained in the following sections:

    1. Set Up a CGFunction Object to Compute Color Values.
    2. Create a CGShading Object for a Radial Gradient
    3. Paint a Radial Gradient Using a CGShading Object
    4. Release Objects

     */
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    myPaintRadialShading(myContext, self.bounds);
}


// 1. Set Up a CGFunction Object to Compute Color Values
static void  myCalculateShadingValues (void *info,
                                const CGFloat *in,
                                CGFloat *out)
{
    size_t k, components;
    double frequency[4] = { 55, 220, 110, 0 };
    components = (size_t)info;
    for (k = 0; k < components - 1; k++)
        *out++ = (1 + sin(*in * frequency[k]))/2;
     *out++ = 1; // alpha
}

static CGFunctionRef myGetFunction (CGColorSpaceRef colorspace)// 1
{
    size_t numComponents;
    static const CGFloat input_value_range [2] = { 0, 1 };
    static const CGFloat output_value_ranges [8] = { 0, 1, 0, 1, 0, 1, 0, 1 };
    static const CGFunctionCallbacks callbacks = { 0,// 2
                                &myCalculateShadingValues,
                                NULL };
 
    numComponents = 1 + CGColorSpaceGetNumberOfComponents (colorspace);// 3
    return CGFunctionCreate ((void *) numComponents, // 4
                                1, // 5
                                input_value_range, // 6
                                numComponents, // 7
                                output_value_ranges, // 8
                                &callbacks);// 9
}

void myPaintRadialShading (CGContextRef myContext,// 1
                            CGRect bounds)
{
    CGPoint startPoint,
            endPoint;
    CGFloat startRadius,
            endRadius;
    CGAffineTransform myTransform;
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
 
    startPoint = CGPointMake(0.25,0.3); // 2
    startRadius = 0.1;  // 3
    endPoint = CGPointMake(.7,0.7); // 4
    endRadius = .25; // 5
 
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB(); // 6
    CGFunctionRef myShadingFunction = myGetFunction (colorspace); // 7
 
    CGShadingRef shading = CGShadingCreateRadial (colorspace, // 8
                            startPoint, startRadius,
                            endPoint, endRadius,
                            myShadingFunction,
                            false, false);
 
    myTransform = CGAffineTransformMakeScale (width, height); // 9
    CGContextConcatCTM (myContext, myTransform); // 10
    CGContextSaveGState (myContext); // 11
 
    CGContextClipToRect (myContext, CGRectMake(0, 0, 1, 1)); // 12
    CGContextSetRGBFillColor (myContext, 1, 1, 1, 1);
    CGContextFillRect (myContext, CGRectMake(0, 0, 1, 1));
 
    CGContextDrawShading (myContext, shading); // 13
    CGColorSpaceRelease (colorspace); // 14
    CGShadingRelease (shading);
    CGFunctionRelease (myShadingFunction);
 
    CGContextRestoreGState (myContext); // 15
}

@end
