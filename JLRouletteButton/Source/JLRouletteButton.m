//
//  JLRouletteButton.m
//  JLRouletteButton
//
//  Created by JohnnyLiu on 2016/11/29.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import "JLRouletteButton.h"
#import "JLButton.h"

@interface JLRouletteButton ()
@property (strong, nonatomic) NSMutableArray <JLButton *> *buttons;
@property (strong, nonatomic) JLButton *centerButton;
@end

@implementation JLRouletteButton

- (void)initData {
    [self.layer setCornerRadius:MIN(self.bounds.size.width, self.bounds.size.height)/2];
    [self.layer setMasksToBounds:YES];
    
    _duration = 0.5;
    _subButtonBackgroundColor = [UIColor clearColor];
    [self setupCenterButton];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    if (!titles) {
        return;
    }
    
    if (!_buttons) {
        [self setupSubButtonWithCount:[titles count]];
    }
    for (int i=0; i<[titles count]; i++) {
        JLButton *button = [_buttons objectAtIndex:i];
        [button setTitle:[titles objectAtIndex:i]];
    }

    _titles = titles;
}

- (void)setImages:(NSArray<UIImage *> *)images {
    if (!images) {
        return;
    }
    
    if (!_buttons) {
        [self setupSubButtonWithCount:[images count]];
    }
    for (int i=0; i<[images count]; i++) {
        JLButton *button = [_buttons objectAtIndex:i];
        [button setImage:[images objectAtIndex:i]];
    }
    
    _images = images;
}

- (void)setSubButtonBackgroundColor:(UIColor *)subButtonBackgroundColor {
    for (JLButton *button in _buttons) {
        [button setBackgroundColor:subButtonBackgroundColor];
    }
    _subButtonBackgroundColor = subButtonBackgroundColor;
}

- (void)setupCenterButton {
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height);
    _centerButton = [[JLButton alloc] initWithFrame:CGRectMake(0, 0, radius/3, radius/3)];
    _centerButton.center = self.center;
    [_centerButton.layer setCornerRadius:radius/6];
    [_centerButton.layer setMasksToBounds:YES];
    [self addSubview:_centerButton];
}

- (void)setupSubButtonWithCount:(NSInteger)count {
    _buttons = [[NSMutableArray alloc] init];
    CGFloat angle = 360/count;
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height);
    for (int i=0; i<count; i++) {
        JLButton *button = [[JLButton alloc] initWithFrame:CGRectMake(0, 0, radius/3, radius/3)];
        button.center = [self calcCircleCoordinateWithCenter:CGPointMake(radius/2, radius/2) angle:-90+i*angle radius:radius/3];
        button.tag = i;
        [button addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:_subButtonBackgroundColor];
        [button.layer setCornerRadius:radius/6];
        [button.layer setMasksToBounds:YES];
        [self addSubview:button];
        [_buttons addObject:button];
    }
}

- (void)touchUpInside:(JLButton *)button {
    NSLog(@"%d,%d",(int)[button tag],(int)[self tag]);
    if (_titles) {
        [_centerButton setTitle:[_titles objectAtIndex:[button tag]]];
    }
    
    if (_images) {
        [_centerButton setImage:[_images objectAtIndex:[button tag]]];
    }
    
    CGFloat angle = 360/[_buttons count];
    CGFloat rotationAngle = ([button tag]-[self tag])*angle*M_PI/180;
    self.tag = button.tag;
    [UIView animateWithDuration:_duration animations:^{
        [self setTransform:CGAffineTransformRotate(self.transform, -rotationAngle)];
        [_centerButton setTransform:CGAffineTransformRotate(_centerButton.transform, rotationAngle)];
        for (JLButton *button in _buttons) {
            [button setTransform:CGAffineTransformRotate(button.transform, rotationAngle)];
        }
    } completion:^(BOOL finished) {
        
    }];
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(rouletteButton:clickButtonAtIndex:)]) {
            [_delegate rouletteButton:self clickButtonAtIndex:[button tag]];
        }
    }
}

/**
 计算圆圈上点的坐标

 @param center 中心点
 @param angle 角度，指向右为0或360，指向上为-90，指向下为90
 @param radius 半径
 @return 坐标
 */
- (CGPoint)calcCircleCoordinateWithCenter:(CGPoint) center angle:(CGFloat)angle radius:(CGFloat)radius {
    CGFloat x = radius*cosf(angle*M_PI/180);
    CGFloat y = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x, center.y+y);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
