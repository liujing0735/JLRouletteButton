//
//  ViewController.m
//  JLRouletteButton
//
//  Created by JohnnyLiu on 2016/11/29.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import "ViewController.h"
#import "JLRouletteButton.h"

@interface ViewController () <JLRouletteButtonDelegate>
@property (strong, nonatomic) JLRouletteButton *rouletteButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _rouletteButton = [[JLRouletteButton alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [_rouletteButton setCenter:self.view.center];
    [_rouletteButton setImages:@[[UIImage imageNamed:@"德国"],[UIImage imageNamed:@"法国"],[UIImage imageNamed:@"荷兰"],[UIImage imageNamed:@"意大利"],[UIImage imageNamed:@"英国"]]];
    [_rouletteButton setTitles:@[@"德国",@"法国",@"荷兰",@"意大利",@"英国"]];
    [_rouletteButton setBackgroundColor:[UIColor lightGrayColor]];
    [_rouletteButton setDelegate:self];
    [self.view addSubview:_rouletteButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JLRouletteButtonDelegate
- (void)rouletteButton:(JLRouletteButton *)rouletteButton clickButtonAtIndex:(NSInteger)index {
    NSLog(@"点击了第%d个按钮",(int)index);
}
@end
