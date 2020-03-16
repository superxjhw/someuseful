//
//  SPTableViewController.h
//  SPTableView
//
//  Created by Super Y on 2020/3/16.
//  Copyright © 2020 Super Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPTableViewController : UITableViewController

@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, copy) void(^outCanScrollBlock)(BOOL canScroll);
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
