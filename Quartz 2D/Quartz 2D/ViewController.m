//
//  ViewController.m
//  Quartz 2D
//
//  Created by Super Y on 2020/3/18.
//  Copyright © 2020 Super Y. All rights reserved.
//

#import "ViewController.h"
#import "SPView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSPView];
}

- (void)setupSPView {
    SPView *spView = [[SPView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:spView];
    spView.backgroundColor = [UIColor whiteColor];

}


@end
