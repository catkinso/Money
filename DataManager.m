#import "DataManager.h"

#import "Transaction.h"

@implementation DataManager
{
    NSMutableArray *transactions;
}

- (Transaction *)getLastTransaction
{
    if (transactions == nil)
        return nil;
    
    return [transactions lastObject];
}


- (void)getSums:(Sums *)s
{
    int i;
    NSCalendar *calendar;
    NSDate *now;
    NSCalendarUnit calendarUnits;
    NSDateComponents *dateComponents;
    NSInteger currentYear, currentMonth, currentWeek, currentDay;
    int dollars, cents;
    int dailyDollars, dailyCents;
    int monthlyDollars, monthlyCents;
    int weeklyDollars, weeklyCents;
    
    if (s == NULL)
        return;
    
    s->dailyTotalDollars = s->dailyTotalCents = 0;
    s->monthlyTotalDollars = s->monthlyTotalCents = 0;
    s->weeklyTotalDollars = s-> weeklyTotalCents = 0;
    s->totalDollars = s->totalCents = 0;
    
    if (transactions == nil)
        return;
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier
                                       :NSCalendarIdentifierGregorian];
    now = [[NSDate alloc] init];
    calendarUnits = NSCalendarUnitYear | NSCalendarUnitMonth
                        | NSCalendarUnitDay | NSCalendarUnitWeekOfYear;
    dateComponents = [calendar components:calendarUnits fromDate:now];
    currentYear = [dateComponents year];
    currentMonth = [dateComponents month];
    currentWeek = [dateComponents weekOfYear]; 
    currentDay = [dateComponents day];
     
    dollars = cents = dailyDollars = dailyCents = 0;
    monthlyDollars = monthlyCents = weeklyDollars = weeklyCents = 0;
    for (i = 0; i < [transactions count]; i++) {
        Transaction *t = [transactions objectAtIndex:i];
        
        dateComponents = [calendar components:calendarUnits fromDate:t.date];
        if (currentYear == [dateComponents year]) {
            dollars += t.costDollars;
            cents += t.costCents;
            
            if (currentMonth == [dateComponents month]) {
                monthlyDollars += t.costDollars;
                monthlyCents += t.costCents;
                
                if (currentWeek == [dateComponents weekOfYear]) {
                    weeklyDollars += t.costDollars;
                    weeklyCents += t.costCents;
                }

                if (currentDay == [dateComponents day]) {
                    dailyDollars += t.costDollars;
                    dailyCents += t.costCents;
                }   
            }
        }
    }
    
    s->totalDollars = dollars + (cents / 100);
    s->totalCents = cents % 100;
    s->monthlyTotalDollars = monthlyDollars + (monthlyCents / 100);
    s->monthlyTotalCents = monthlyCents % 100;
    s->dailyTotalDollars = dailyDollars + (dailyCents / 100);
    s->dailyTotalCents = dailyCents % 100;
    s->weeklyTotalDollars = weeklyDollars + (weeklyCents / 100);
    s->weeklyTotalCents = weeklyCents % 100;
}


- (int)getNumTransactions
{
    if (transactions == nil)
        return 0;
    
    return (int)[transactions count];
}


- (Transaction *)getTransactionAtIndex:(int)index
{
    if (index >= [transactions count])
        return nil;
    
    return [transactions objectAtIndex:index];
}


- (NSArray *)getLastThreeTransactions
{
    int numOfTransactions;
    Transaction *t1, *t2, *t3;
    
    if (transactions == nil)
        return nil;
    
    numOfTransactions = (int)[transactions count];
    
    if (numOfTransactions >= 1)
        t1 = [transactions objectAtIndex:numOfTransactions - 1];
    
    if (numOfTransactions >= 2)
        t2 = [transactions objectAtIndex:numOfTransactions - 2];
    
    if (numOfTransactions >= 3)
        t3 = [transactions objectAtIndex:numOfTransactions - 3];
    
    return [[NSArray alloc] initWithObjects:t1, t2, t3, nil];
}


- (void)inputTransaction:(Transaction *)t
{
    if (transactions == nil)
        transactions = [[NSMutableArray alloc] init];
    
    [transactions addObject:t];
}


- (int)saveData:(NSString **)status plistName:(NSString *)s
{
    NSString *appDir, *appDatafile;
    NSFileManager *fm;
    bool appDirExists;
    
    if (transactions == nil || [transactions count] == 0) {
        *status = @"Nothing to save.";
        return -1;
    }
    
    appDir = NSHomeDirectory( );
    appDir = [appDir stringByAppendingString:@"/Documents/MoneyApp"];

    fm = [[NSFileManager alloc] init];
    appDirExists = [fm fileExistsAtPath:appDir];
    
    if (appDirExists == false) {
        [fm createDirectoryAtPath:appDir withIntermediateDirectories:YES
                attributes:nil error:nil];
    }
    
    appDatafile = [[NSString alloc] initWithString:appDir];
    appDatafile = [appDatafile stringByAppendingString:@"/"];
    appDatafile = [appDatafile stringByAppendingString:s];

    [NSKeyedArchiver archiveRootObject:transactions toFile:appDatafile];
    *status = @"Data saved.";
    
    return 0;
}


- (int)loadData:(NSString **)status plistName:(NSString *)s
{
    NSString *appDir, *appDatafile;
    NSFileManager *fm;
    bool appDirExists;
    
    appDir = NSHomeDirectory( );
    appDir = [appDir stringByAppendingString:@"/Documents/MoneyApp"];
    appDatafile = [[NSString alloc] initWithString:appDir];
    appDatafile = [appDatafile stringByAppendingString:@"/"];
    appDatafile = [appDatafile stringByAppendingString:s];

    fm = [[NSFileManager alloc] init];
    appDirExists = [fm fileExistsAtPath:appDatafile];
    
    if (appDirExists == false) {
        *status = @"File does not exist.";
        return -1;
    }
    
    transactions = [NSKeyedUnarchiver unarchiveObjectWithFile:appDatafile];
    *status = @"File loaded.";
    
    return 0;
}

@end
