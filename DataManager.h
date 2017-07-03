#import <Foundation/Foundation.h>

struct sums_t {
    int dailyTotalDollars;
    int dailyTotalCents;
    int weeklyTotalDollars;
    int weeklyTotalCents;
    int monthlyTotalDollars;
    int monthlyTotalCents;
    int totalDollars;
    int totalCents;
};
typedef struct sums_t Sums;

struct topCategories_t {
    char categoryNames[5][12];
    int dailyCategoryTotalDollars[5];
    int dailyCategoryTotalCents[5];
    int weeklyCategoryTotalDollars[5];
    int weeklyCategoryTotalCents[5];
    int monthlyCategoryTotalDollars[5];
    int monthlyCategoryTotalCents[5];
};
typedef struct topCategories_t TopCategories;

@class Transaction;

@interface DataManager : NSObject
    
- (Transaction *)getLastTransaction;
- (void)getSums:(Sums *)s;
- (void)getTopMonthCategories:(TopCategories *)tc;
- (int)getNumTransactions;
- (Transaction *)getTransactionAtIndex:(int)index;
- (NSArray *)getLastThreeTransactions;
- (void)inputTransaction:(Transaction *)t;
- (int)saveData:(NSString **)status plistName:(NSString *)s;
- (int)loadData:(NSString **)status plistName:(NSString *)s;

@end
