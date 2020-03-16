//
//  SPTableView.m
//  SPTableView
//
//  Created by Super Y on 2020/3/16.
//  Copyright © 2020 Super Y. All rights reserved.
//

#import "SPTableView.h"

@implementation SPTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
