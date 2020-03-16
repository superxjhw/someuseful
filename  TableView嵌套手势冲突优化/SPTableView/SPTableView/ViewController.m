//
//  ViewController.m
//  SPTableView
//
//  Created by Super Y on 2020/3/16.
//  Copyright © 2020 Super Y. All rights reserved.
//

#import "ViewController.h"
#import "SPTableViewController.h"
#import "SPTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) SPTableViewController *spVC;
@property (nonatomic, assign) BOOL canScroll;

@end

static NSString *const reuseIdentifier = @"mainCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    self.canScroll = YES;
}

- (void)setupTableView {
    SPTableView *mainTableView = [[SPTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.rowHeight = 60;
    [mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    [self.view addSubview:mainTableView];
    
    SPTableViewController *spVC = [[SPTableViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    spVC.outCanScrollBlock = ^(BOOL canScroll) {
        weakSelf.canScroll = canScroll;
    };
    spVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 500);
    mainTableView.tableFooterView = spVC.view;
    [self addChildViewController:spVC];
    self.spVC = spVC;
}


#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"mainTableViewCell 第%zd行",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height) {
        // table滑到底部
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - scrollView.bounds.size.height);
        self.spVC.canScroll = YES;
    }else {
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - scrollView.bounds.size.height);
        }
    }
}
@end
