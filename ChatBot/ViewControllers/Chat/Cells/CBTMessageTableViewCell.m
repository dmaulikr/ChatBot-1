//
//  CBTMessageTableViewCell.m
//  TestTask
//
//  Created by William Boles on 15/08/2016.
//
//

#import "CBTMessageTableViewCell.h"

@implementation CBTMessageTableViewCell

#pragma mark - Layout

- (void)layoutByApplyingConstraints
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
