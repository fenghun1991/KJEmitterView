//
//  KJMarqueeLabel.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/14.
//  Copyright © 2019 杨科军. All rights reserved.
//  一款跑马灯Label

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
enum {
    KJAnimationLabelTypeFadeInOut = 1,
    KJAnimationLabelTypeSlideLeftInLeftOut = 2,
    KJAnimationLabelTypeSlideRightInRightOut = 3,
    KJAnimationLabelTypeSlideTopInTopOut = 4,
    KJAnimationLabelTypeSlideBottomtInBottomOut = 5,
    KJAnimationLabelTypeSlideLeftInRightOut = 6,
    ATAnimationLabelTypeSlideRightInLeftOut = 7,
    KJAnimationLabelTypeSlideBottomInTopOut = 8,
    KJAnimationLabelTypeSlideTopInBottomOut = 9
};
typedef NSUInteger KJAnimationLabelType;

@interface KJMarqueeLabel : UILabel
/** 文字宽度 */
@property(nonatomic, retain) NSArray *__nonnull wordList;
/** 持续时间 */
@property(nonatomic, assign) double duration;
/** 动画类型 */
@property(nonatomic, assign) KJAnimationLabelType animationType;
/** Animate the words from the list
 *  @param words list of words.
 *  @param time  total duration of the animation between each switch.
 */
- (void)animateWithWords:(NSArray *)words forDuration:(double)time;

/** Animation with the type of animation type.
 *  @param words     list of words.
 *  @param time      total duration of the animation between each switch.
 *  @param animation type of animation
 */
- (void)animateWithWords:(NSArray *)words forDuration:(double)time withAnimation:(KJAnimationLabelType)animation;

@end

NS_ASSUME_NONNULL_END
