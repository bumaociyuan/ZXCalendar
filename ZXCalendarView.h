//
//  ZXCalendar.h
//  ZXCalendar
//
//  Created by niko on 9/18/14.
//  Copyright (c) 2014 niko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCalendarGridView.h"

#define GRID_HEIGHT 46.0f
#define GRID_WIDTH 46.0f

typedef NS_ENUM(NSInteger, ZXCalendarViewType) {
    ZXCalendarViewTypeMonth = 0,
    ZXCalendarViewTypeWeek
};

@class ZXCalendarView;

@protocol ZXCalendarViewDataSource <NSObject>
- (ZXCalendarGridViewType)calendarView:(ZXCalendarView *)calendarView typeAtDate:(NSDate *)date;
@end
@protocol ZXCalendarViewDelegate <NSObject>
- (void)calendarView:(ZXCalendarView *)calendarView didSelectedAtDate:(NSDate *)date;
@end

@interface ZXCalendarView : UIView

@property (nonatomic, weak) id<ZXCalendarViewDataSource> dateSource;
@property (nonatomic, weak) id<ZXCalendarViewDelegate> delegate;
@property (nonatomic, assign) ZXCalendarViewType type;
@property (nonatomic, strong) NSDate *selectedDate;
- (void)setSelectedDate:(NSDate *)selectedDate animated:(BOOL)animated;
+ (instancetype)calendarView;
- (void)reloadData;

@end
