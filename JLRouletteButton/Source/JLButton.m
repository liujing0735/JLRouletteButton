//
//  JLButton.m
//  JLRouletteButton
//
//  Created by JohnnyLiu on 2016/11/29.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import "JLButton.h"

@implementation JLButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutAdjustment {
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    CGRect imageViewRect = self.imageView.frame;
    CGRect titleRect = self.titleLabel.bounds;
    self.titleEdgeInsets = UIEdgeInsetsMake(imageViewRect.size.height, -imageViewRect.size.width, 0, 0);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, titleRect.size.height, -titleRect.size.width);
}

- (void)setTitle:(NSString *)title {
    
    [self setTitle:title forState:UIControlStateNormal];
    if (self.currentImage != nil) {
        [self layoutAdjustment];
    }
}

- (void)setImage:(UIImage *)image {
    
    [self setImage:image forState:UIControlStateNormal];
    if (self.currentTitle != nil) {
        [self layoutAdjustment];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self layoutAdjustment];
}

@end
