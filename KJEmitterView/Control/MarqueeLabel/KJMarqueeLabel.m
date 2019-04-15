//
//  KJMarqueeLabel.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/14.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJMarqueeLabel.h"

@implementation KJMarqueeLabel

@synthesize wordList = _wordList;
@synthesize duration = _duration;

- (void)animateWithWords:(NSArray *)words forDuration:(double)time {
    [self animateWithWords:words forDuration:time withAnimation:KJAnimationLabelTypeFadeInOut];
}

- (void)animateWithWords:(NSArray *)words forDuration:(double)time withAnimation:(KJAnimationLabelType)animation {
    self.duration = time;
    if (self.wordList) {
        self.wordList = nil;
    }
    self.animationType = animation;
    self.wordList = [[NSArray alloc] initWithArray:words];
    self.text = [self.wordList objectAtIndex:0];
    [NSThread detachNewThreadSelector:@selector(_startAnimations:) toTarget:self withObject:self.wordList];
}

- (void)_startAnimations:(NSArray *)images {
    @autoreleasepool {
        for (uint i = 1; i < [images count]; i++) {
            sleep(self.duration);
            [self performSelectorOnMainThread:@selector(_animate:) withObject:[NSNumber numberWithInt:i] waitUntilDone:YES];
            sleep(self.duration);
            if (i == [images count] - 1) {
                i = -1;
            }
        }
    }
}

- (void)_animate:(NSNumber *)num {
    CGRect __block originalSize;
    if (self.animationType == KJAnimationLabelTypeFadeInOut) {
        [UIView animateWithDuration:self.duration / 2 animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.duration / 2 animations:^{
                self.alpha = 1.0;
                self.text = [self.wordList objectAtIndex:[num intValue]];
            } completion:^(BOOL finished) {}];
        }];
    } else {
        [UIView animateWithDuration:self.duration / 2 animations:^{
            self.alpha = 0.0;
            CGRect fullSize = self.frame;
            originalSize = self.frame;
            switch (self.animationType) {
                case KJAnimationLabelTypeSlideTopInTopOut:
                    fullSize.origin.y -= fullSize.size.height/4;
                    break;
                case KJAnimationLabelTypeSlideBottomtInBottomOut:
                    fullSize.origin.y += fullSize.size.height/4;
                    break;
                case KJAnimationLabelTypeSlideTopInBottomOut:
                    fullSize.origin.y += originalSize.size.width/4;
                    break;
                case KJAnimationLabelTypeSlideBottomInTopOut:
                    fullSize.origin.y -= originalSize.size.width/4;
                    break;
                case KJAnimationLabelTypeSlideLeftInLeftOut:
                    fullSize.origin.x -= originalSize.size.width/2;
                    break;
                case KJAnimationLabelTypeSlideRightInRightOut:
                    fullSize.origin.x += originalSize.size.width/2;
                    break;
                case KJAnimationLabelTypeSlideLeftInRightOut:
                    fullSize.origin.x += originalSize.size.width/2;
                    break;
                case ATAnimationLabelTypeSlideRightInLeftOut:
                    fullSize.origin.x -= originalSize.size.width/2;
                    break;
                default:
                    break;
            }
            self.frame = fullSize;
        }
                         completion:^(BOOL finished) {
                             CGRect fullSize = self.frame;
                             switch (self.animationType) {
                                 case KJAnimationLabelTypeSlideTopInTopOut:
                                     break;
                                 case KJAnimationLabelTypeSlideBottomtInBottomOut:
                                     break;
                                 case KJAnimationLabelTypeSlideTopInBottomOut:
                                     fullSize.origin.y = originalSize.origin.y;
                                     fullSize.origin.y -= originalSize.size.height/4;
                                     break;
                                 case KJAnimationLabelTypeSlideBottomInTopOut:
                                     fullSize.origin.y = originalSize.origin.y;
                                     fullSize.origin.y += originalSize.size.height/4;
                                     break;
                                 case KJAnimationLabelTypeSlideLeftInLeftOut:
                                     break;
                                 case KJAnimationLabelTypeSlideRightInRightOut:
                                     break;
                                 case KJAnimationLabelTypeSlideLeftInRightOut:
                                     fullSize.origin.x -= 2 * originalSize.size.width/4;
                                     break;
                                 case ATAnimationLabelTypeSlideRightInLeftOut:
                                     fullSize.origin.x += 2 * originalSize.size.width/4;
                                     break;
                                 default:
                                     break;
                             }
                             self.frame = fullSize;
                             
                             [UIView animateWithDuration:self.duration / 2 animations:^{
                                 self.alpha = 1.0;
                                 CGRect fullSize = self.frame;
                                 fullSize = originalSize;
                                 self.frame = fullSize;
                                 self.text = [self.wordList objectAtIndex:[num intValue]];
                             } completion:^(BOOL finished) {}];
                         }];
    }
}


@end
