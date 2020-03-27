//
//  NSDate+MCExtension.m
//  MCFoundation
//
//  Created by illScholar on 2019/2/21.
//

#import "NSDate+MCExtension.h"


@implementation NSDate (MCExtension)

#pragma mark - Comparison Day
- (BOOL)mcIsToday {
    return [self mcIsEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)mcIsTomorrow {
    return [self mcIsEqualToDateIgnoringTime:[NSDate mcDateTomorrow]];
}

- (BOOL)mcIsYesterday {
    return [self mcIsEqualToDateIgnoringTime:[NSDate mcDateYesterday]];
}

- (BOOL)mcIsSameDay:(NSDate *)other {
    NSDateComponents *components1 = [self mcComponents];
    NSDateComponents *components2 = [other mcComponents];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

#pragma mark - Comparison Week
- (BOOL)mcIsThisWeek {
    return [self mcIsSameWeekAsDate:[NSDate date]];
}

- (BOOL)mcIsNextWeek {
    return [self mcIsSameWeekAsDate:[[NSDate date] mcDateByAddingWeeks:1]];
}

- (BOOL)mcIsLastWeek {
    return [self mcIsSameWeekAsDate:[[NSDate date] mcDateBySubtractingWeeks:1]];
}

- (BOOL)mcIsSameWeekAsDate:(NSDate *)other {
    /*
     NOTE: Depending on localization, week starts on Monday or Sunday.
     */
    
    NSDateComponents *components1 = [self mcComponents];
    NSDateComponents *components2 = [other mcComponents];
    
    return (([components1 year] == [components2 year]) &&
            ([components1 weekOfYear] == [components2 weekOfYear]));
}

#pragma mark - Comparison Month
- (BOOL)mcIsThisMonth {
    return [self mcIsSameMonth:[NSDate date]];
}

- (BOOL)mcIsNextMonth {
    return [self mcIsSameWeekAsDate:[self mcDateByAddingMonths:1]];
}

- (BOOL)mcIsLastMonth {
    return [self mcIsSameWeekAsDate:[self mcDateBySubtractingMonths:1]];
}

- (BOOL)mcIsSameMonth:(NSDate *)other {
    NSDateComponents *components1 = [self mcComponents];
    NSDateComponents *components2 = [other mcComponents];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]);
}

#pragma mark - Comparison Year
- (BOOL)mcIsThisYear {
    return [self mcIsSameYearAsDate:[NSDate date]];
}

- (BOOL)mcIsNextYear {
    return [self mcIsSameYearAsDate:[[NSDate date] mcDateByAddingYears:1]];
}

- (BOOL)mcIsLastYear {
    return [self mcIsSameYearAsDate:[[NSDate date] mcDateBySubtractingYears:1]];
}

- (BOOL)mcIsSameYearAsDate:(NSDate *)other {
    NSDateComponents *components1 = [self mcComponents];
    NSDateComponents *components2 = [other mcComponents];
    
    return ([components1 year] == [components2 year]);
}

- (BOOL)mcIsLeapYear {
    NSUInteger year = [self mcYear];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - Comparison Workday
- (BOOL)mcIsTypicallyWorkday {
    return ![self mcIsTypicallyWorkend];
}

#pragma mark - Comparison Workend

#pragma mark - EarlierThan
- (BOOL)mcIsEarlierThanDate:(NSDate *)other {
    return ([self compare:other] == NSOrderedAscending);
}

- (BOOL)mcIsInFuture {
    return ([self mcIsEarlierThanDate:[NSDate date]]);
}

#pragma mark -
#pragma mark LaterThan
- (BOOL)mcIsLaterThanDate:(NSDate *)other {
    return ([self compare:other] == NSOrderedDescending);
}

- (BOOL)mcIsInPast {
    return ([self mcIsLaterThanDate:[NSDate date]]);
}

- (BOOL)mcIsEqualToDateIgnoringTime:(NSDate *)other {
    NSDateComponents *components1 = [self mcComponents];
    NSDateComponents *components2 = [other mcComponents];
    
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}

- (NSUInteger)mcDaysInYear {
    return [self mcIsLeapYear] ? 366 : 365;
}



#pragma mark - Components
- (NSInteger)mcYear {
    return [[self mcComponents] year];
}

- (NSInteger)mcMonth {
    return [[self mcComponents] month];
}

- (NSInteger)mcWeekOfMonth {
    return [[self mcComponents] weekOfMonth];
}

- (NSInteger)mcWeekOfYear {
    return [[self mcComponents] weekOfYear];
}

- (NSInteger)mcWeekday {
    /*
     NOTE: Depending on localization, week starts on Monday or Sunday.
     */
    return [[self mcComponents] weekday];
}

- (NSInteger)mcNthWeekday {
    return [[self mcComponents] weekdayOrdinal];
}

- (NSInteger)mcDay {
    return [[self mcComponents] day];
}

- (NSInteger)mcHour {
    return [[self mcComponents] hour];
}

- (NSInteger)mcMinutes {
    return [[self mcComponents] minute];
}

- (NSInteger)mcSeconds {
    return [[self mcComponents] second];
}

- (NSInteger)mcEra {
    return [[self mcComponents] era];
}

- (NSDateComponents *)mcComponents {
    return [[NSCalendar currentCalendar] components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
}

#pragma mark - Creation
+ (NSDate *)mcDateTomorrow {
    return [[NSDate date] mcDateByAddingDays:1];
}

+ (NSDate *)mcDateYesterday {
    return [[NSDate date] mcDateBySubtractingDays:1];
}

+ (NSDate *)mcDateWithoutTime {
    return [[NSDate date] mcDateWithoutTime];
}

+ (NSDate *)mcDateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] mcDateByAddingDays:days];
}

+ (NSDate *)mcDateFromString:(NSString *)string {
    return [self mcDateFromString:string withFormat:[NSDate mcDateFormatDDMMYYYYDashed]];
}

+ (nullable NSDate *)mcDateFromString:(NSString *)string withFormat:(NSString *)format {
    if ((NSNull *)string == [NSNull null] || string == nil || [string isEqualToString:@""]) {
        return nil;
    }
    
    if (format == nil) {
        format = [NSDate mcDateFormatDDMMYYYYDashed];
    }
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    NSDate *result = [formatter dateFromString:string];
    
    return result;
}

- (NSDate *)mcDateWithoutTime {
    NSString *formattedString = [self mcFormattedString];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:[NSDate mcDateFormatDDMMYYYYDashed]];
    NSDate *result = [formatter dateFromString:formattedString];
    
    return result;
}

#pragma mark - Formatting
+ (NSString *)mcDateFormatCCCCDDMMMYYYY {
    return @"cccc, dd MMM yyyy";
}

+ (NSString *)mcDateFormatCCCCDDMMMMYYYY {
    return @"cccc, dd MMMM yyyy";
}

+ (NSString *)mcDateFormatDDMMMYYYY {
    return @"dd MMM yyyy";
}

+ (NSString *)mcDateFormatDDMMYYYYDashed {
    return @"dd-MM-yyyy";
}

+ (NSString *)mcDateFormatDDMMYYYYSlashed {
    return @"dd/MM/yyyy";
}

+ (NSString *)mcDateFormatDDMMMYYYYSlashed {
    return @"dd/MMM/yyyy";
}

+ (NSString *)mcDateFormatMMMDDYYYY {
    return @"MMM dd, yyyy";
}

+ (NSString *)mcDateFormatYYYYMMDDDashed {
    return @"yyyy-MM-dd";
}


#pragma mark - Manipulation
- (NSDate *)mcDateByAddingDays:(NSInteger)days {
    return [self _mcDateByAdding:days ofUnit:NSCalendarUnitDay];
}

- (NSDate *)mcDateByAddingWeeks:(NSInteger)weeks {
    return [self mcDateByAddingDays:(weeks * 7)];
}

- (NSDate *)mcDateByAddingMonths:(NSInteger)months {
    return [self _mcDateByAdding:months ofUnit:NSCalendarUnitMonth];
}

- (NSDate *)mcDateByAddingYears:(NSInteger)years {
    return [self _mcDateByAdding:years ofUnit:NSCalendarUnitYear];
}

- (NSDate *)mcDateByAddingHours:(NSInteger)hours {
    return [self _mcDateByAdding:hours ofUnit:NSCalendarUnitHour];
}

- (NSDate *)mcDateByAddingMinutes:(NSInteger)minutes {
    return [self _mcDateByAdding:minutes ofUnit:NSCalendarUnitMinute];
}

- (NSDate *)mcDateByAddingSeconds:(NSInteger)seconds {
    return [self _mcDateByAdding:seconds ofUnit:NSCalendarUnitSecond];
}

- (NSDate *)mcDateBySubtractingDays:(NSInteger)days {
    return [self _mcDateByAdding:-days ofUnit:NSCalendarUnitDay];
}

- (NSDate *)mcDateBySubtractingWeeks:(NSInteger)weeks {
    return [self mcDateByAddingDays:- (weeks * 7)];
}

- (NSDate *)mcDateBySubtractingMonths:(NSInteger)months {
    return [self _mcDateByAdding:- months ofUnit:NSCalendarUnitMonth];
}

- (NSDate *)mcDateBySubtractingYears:(NSInteger)years {
    return [self _mcDateByAdding:- years ofUnit:NSCalendarUnitYear];
}

- (NSDate *)mcDateBySubtractingHours:(NSInteger)hours {
    return [self _mcDateByAdding:- hours ofUnit:NSCalendarUnitHour];
}

- (NSDate *)mcDateBySubtractingMinutes:(NSInteger)minutes {
    return [self _mcDateByAdding:- minutes ofUnit:NSCalendarUnitMinute];
}

- (NSDate *)mcDateBySubtractingSeconds:(NSInteger)seconds {
    return [self _mcDateByAdding:- seconds ofUnit:NSCalendarUnitSecond];
}

- (NSDate *)_mcDateByAdding:(NSInteger)value ofUnit:(NSCalendarUnit)unit {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    switch (unit) {
        case NSCalendarUnitYear:
            [components setYear:value];
            break;
        case NSCalendarUnitMonth:
            [components setMonth:value];
            break;
        case NSCalendarUnitDay:
            [components setDay:value];
            break;
        case NSCalendarUnitHour:
            [components setHour:value];
            break;
        case NSCalendarUnitMinute:
            [components setMinute:value];
            break;
        case NSCalendarUnitSecond:
            [components setSecond:value];
            break;
        default:
            break;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    return date;
}

- (NSInteger)mcDifferenceInDaysToDate:(NSDate *)toDate {
    return [self _mcDifferenceInUnit:NSCalendarUnitDay toDate:toDate];
}

- (NSInteger)mcDifferenceInMonthsToDate:(NSDate *)toDate {
    return [self _mcDifferenceInUnit:NSCalendarUnitMonth toDate:toDate];
}

- (NSInteger)mcDifferenceInYearsToDate:(NSDate *)toDate {
    return [self _mcDifferenceInUnit:NSCalendarUnitYear toDate:toDate];
}

- (NSInteger)mcDifferenceInHoursToDate:(NSDate *)toDate {
    return [self _mcDifferenceInUnit:NSCalendarUnitHour toDate:toDate];
}

- (NSInteger)mcDifferenceInMinutesToDate:(NSDate *)toDate {
    return [self _mcDifferenceInUnit:NSCalendarUnitMinute toDate:toDate];
}

- (NSInteger)mcDifferenceInSecondsToDate:(NSDate *)toDate {
    return [self _mcDifferenceInUnit:NSCalendarUnitSecond toDate:toDate];
}

- (NSInteger)_mcDifferenceInUnit:(NSCalendarUnit)unit toDate:(NSDate *)toDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unit
                                               fromDate:self toDate:toDate options:0];
    
    switch (unit) {
        case NSCalendarUnitYear:
            return [components year];
            break;
        case NSCalendarUnitMonth:
            return [components month];
            break;
        case NSCalendarUnitDay:
            return [components day];
            break;
        case NSCalendarUnitHour:
            return [components hour];
            break;
        case NSCalendarUnitMinute:
            return [components minute];
            break;
        case NSCalendarUnitSecond:
            return [components second];
            break;
        default:
            return [components year];
            break;
    }
}

#pragma mark - TimeStamp
+ (double)mcCurrentDateTimeStamp {
    return [[NSDate date] timeIntervalSince1970];
}

+ (UInt64)mcCurrentDateMillisecondTimeStamp {
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

@end
