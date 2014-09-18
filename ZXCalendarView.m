//
//  ZXCalendar.m
//  ZXCalendar
//
//  Created by niko on 9/18/14.
//  Copyright (c) 2014 niko. All rights reserved.
//

#import "ZXCalendarView.h"
#import "ZXCalendarGridView.h"
#import "NSDate+Calendar.h"

@interface ZXCalendarView () {
    NSDate *_selectedDate;
}

@property (nonatomic, strong) NSMutableArray *gridViews;
@end

@implementation ZXCalendarView

+ (instancetype)calendarView {
    ZXCalendarView *result = [[self alloc] init];
    return result;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)reloadData {
    [self updateGridViews];
}

#pragma mark - property
- (void)setDateSource:(id<ZXCalendarViewDataSource>)dateSource {
    if (_dateSource != dateSource) {
        _dateSource = dateSource;
        [self updateGridViews];
    }
    
}

- (NSMutableArray *)gridViews {
    if (!_gridViews) {
        _gridViews = [NSMutableArray new];
    }
    return _gridViews;
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    if (![_selectedDate isEqualToDate:selectedDate]) {
        _selectedDate = selectedDate;
        [self updateGridViews];
    }
}

- (NSDate *)selectedDate {
    if (!_selectedDate) {
        _selectedDate = [NSDate date];
    }
    return _selectedDate;
}

- (void)setType:(ZXCalendarViewType)type {
    if (_type != type) {
        _type = type;
        [self updateFrame];
        [self updateGridViews];
    }
}

#pragma mark - helper

- (void)updateFrame {
    CGRect frame = self.frame;
    if (self.type == ZXCalendarViewTypeMonth) {
        frame.size = CGSizeMake(GRID_WIDTH * 7, GRID_HEIGHT * 5);
    }else {
        frame.size = CGSizeMake(GRID_WIDTH * 7, GRID_HEIGHT);
    }
    self.frame = frame;
}

- (void)setup {
    self.clipsToBounds = YES;
    [self updateFrame];
    [self setupGridViews];
    [self layoutGridViews];
    [self updateGridViews];
}

- (void)layoutGridViews {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j< 7; j++) {
            ZXCalendarGridView *gridView = self.gridViews[i*7+j];
            CGRect frame = gridView.frame;
            frame.origin = CGPointMake(j * GRID_WIDTH, i * GRID_HEIGHT);
            gridView.frame = frame;
            [self addSubview:gridView];
        }
    }
}

- (void)setupGridViews {
    for (int i = 0; i < 35; i++) {
        ZXCalendarGridView *gridView = [ZXCalendarGridView gridViewWithOnClick:^(ZXCalendarGridView * sender) {
            [self.delegate calendarView:self didSelectedAtDate:sender.date];
        }];
        [self.gridViews addObject:gridView];
    }
}

- (void)updateGridViews {
    NSDate *selecetedDate = self.selectedDate;
    NSDate *firstDateInThisCalendar = nil;

    if (self.type == ZXCalendarViewTypeMonth) {
        NSDate *firstDateInThisMonth = nil;
        firstDateInThisMonth = [selecetedDate firstDayOfTheMonth];
        NSInteger weekday = firstDateInThisMonth.weekday;
        if (weekday == 7) {
            firstDateInThisCalendar = firstDateInThisMonth;
        }else {
            firstDateInThisCalendar = [firstDateInThisMonth dateWithDayInterval:-weekday + 1];
        }
        for (int i = 0; i < 35; i++) {
            NSDate *date = [firstDateInThisCalendar dateWithDayInterval:i];
            ZXCalendarGridView *gridView = self.gridViews[i];
            [self configGridView:gridView date:date];
        }
    }else {
        NSDate *firstDateInThisWeek = nil;
        firstDateInThisWeek = [selecetedDate firstDayOfTheWeek];
        firstDateInThisCalendar = firstDateInThisWeek;
        for (int i = 0; i < 7; i++) {
            NSDate *date = [firstDateInThisCalendar dateWithDayInterval:i];
            ZXCalendarGridView *gridView = self.gridViews[i];
            [self configGridView:gridView date:date];
        }
    }
}

- (void)configGridView:(ZXCalendarGridView *)gridView date:(NSDate *)date {
    gridView.date = date;
    if (self.type == ZXCalendarViewTypeMonth) {
        if (![date sameMonthWithDate:self.selectedDate]) {
            gridView.type = ZXCalendarGridViewTypeOther;
        }else if ([date sameDayWithDate:self.selectedDate]) {
            gridView.type = ZXCalendarGridViewTypeSelected;
        }else if ([date sameDayWithDate:[NSDate date]]) {
            gridView.type = ZXCalendarGridViewTypeToday;
        }else{
            gridView.type = [self.dateSource calendarView:self typeAtDate:date];
        }
    }else {
        if ([date sameDayWithDate:self.selectedDate]) {
            gridView.type = ZXCalendarGridViewTypeSelected;
        }else if ([date sameDayWithDate:[NSDate date]]) {
            gridView.type = ZXCalendarGridViewTypeToday;
        }else{
            gridView.type = [self.dateSource calendarView:self typeAtDate:date];
        }
    }

}

@end
