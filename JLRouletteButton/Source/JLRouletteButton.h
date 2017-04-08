//
//  JLRouletteButton.h
//  JLRouletteButton
//
//  Created by JohnnyLiu on 2016/11/29.
//  Copyright © 2016年 JohnnyLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JLRouletteButton;

@protocol JLRouletteButtonDelegate <NSObject>
@required// 必须实现


@optional// 可选实现

/**
 子按钮点击事件代理
 
 @param rouletteButton JLRouletteButton的实例
 @param index 被点击按钮的序号
 */
- (void)rouletteButton:(JLRouletteButton *)rouletteButton clickButtonAtIndex:(NSInteger)index;
@end

@interface JLRouletteButton : UIControl

/**
 代理
 */
@property (strong, nonatomic) id <JLRouletteButtonDelegate> delegate;

/**
 子按钮标题数组
 */
@property (strong, nonatomic) NSArray <NSString *> *titles;

/**
 子按钮图片数组
 */
@property (strong, nonatomic) NSArray <UIImage *> *images;

/**
 旋转动画持续时间，默认值0.5
 */
@property (assign, nonatomic) NSTimeInterval duration;

/**
 子按钮背景颜色，默认值[UIColor clearColor]
 */
@property (strong, nonatomic) UIColor *subButtonBackgroundColor;
@end
