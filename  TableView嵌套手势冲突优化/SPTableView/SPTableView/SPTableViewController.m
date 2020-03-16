//
//  SPTableViewController.m
//  SPTableView
//
//  Created by Super Y on 2020/3/16.
//  Copyright © 2020 Super Y. All rights reserved.
//

#import "SPTableViewController.h"

@interface SPTableViewController ()

@end

@implementation SPTableViewController

static NSString *const reuseIdentifier = @"subCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = [NSString stringWithFormat:@"subTableViewCell 第%.2zd行",indexPath.row];
    [self scrollViewDidScroll:tableView];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        // table滑到顶部
        scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
        if (self.outCanScrollBlock) {
            self.outCanScrollBlock(YES);
        }
    }else {
        if (self.outCanScrollBlock) {
            self.outCanScrollBlock(NO);
        }
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointZero;
        }
    }
}

@end
