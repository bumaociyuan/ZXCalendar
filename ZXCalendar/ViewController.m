//
//  ViewController.m
//  ZXCalendar
//
//  Created by niko on 9/18/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "ZXCalendarView.h"
#import "NSDate+Calendar.h"

@interface ViewController ()<ZXCalendarViewDataSource>
@property (nonatomic, strong) ZXCalendarView *calendarView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    ZXCalendarView *view = [ZXCalendarView calendarView];
    view.selectedDate = [NSDate date];
    view.dateSource = self;
    [self.view addSubview:view];
    self.calendarView = view;
    view.center = self.view.center;
    self.view.backgroundColor = [UIColor colorWithRed:0.361 green:0.537 blue:0.293 alpha:1.000];
}

- (ZXCalendarGridViewType)calendarView:(ZXCalendarView *)calendarView typeAtDate:(NSDate *)date {
    if ([date isEqualToDate:[NSDate date]]) {
        return ZXCalendarGridViewTypeToday;
    }
    return ZXCalendarGridViewTypeNone;
}
- (IBAction)typeChange:(UISwitch *)sender {
    self.calendarView.type = !self.calendarView.type;
}


- (IBAction)nextMonth:(id)sender {
    self.calendarView.selectedDate = [self.calendarView.selectedDate associateDayOfTheFollowingMonth];
}
- (IBAction)lastMonth:(id)sender {
    self.calendarView.selectedDate = [self.calendarView.selectedDate associateDayOfThePreviousMonth];
}


@end
