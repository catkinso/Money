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

@class Transaction;

@interface DataManager : NSObject
    
- (Transaction *)getLastTransaction;
- (void)getSums:(Sums *)s;
- (int)getNumTransactions;
- (Transaction *)getTransactionAtIndex:(int)index;
- (NSArray *)getLastThreeTransactions;
- (void)inputTransaction:(Transaction *)t;
- (int)saveData:(NSString **)status plistName:(NSString *)s;
- (int)loadData:(NSString **)status plistName:(NSString *)s;

@end
