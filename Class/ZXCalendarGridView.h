//
//  ZXCalendarGridView.h
//  ZXCalendar
//
//  Created by niko on 9/18/14.
//  Copyright (c) 2014 niko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXCalendarGridViewType) {
    ZXCalendarGridViewTypeNone          = 0,
    ZXCalendarGridViewTypeSelected      = 1,
    ZXCalendarGridViewTypeToday         = 2,
    ZXCalendarGridViewTypeOther         = 3
};

@interface ZXCalendarGridView : UIControl

+ (instancetype)gridViewWithOnClick:(void(^)(ZXCalendarGridView *))onClick;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) ZXCalendarGridViewType type;
@property (nonatomic, strong) void(^onClick)(ZXCalendarGridView *);

@end
