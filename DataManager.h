#import <Foundation/Foundation.h>

@class Transaction;

@interface DataManager : NSObject
    
- (Transaction *)getLastTransaction;
- (void)getTotalDollars:(int *)d Cents:(int *)c;
- (int)getNumTransactions;
- (Transaction *)getTransactionAtIndex:(int)index;
- (NSArray *)getLastThreeTransactions;
- (void)inputTransaction:(Transaction *)t;
- (int)saveData:(NSString **)status plistName:(NSString *)s;
- (int)loadData:(NSString **)status plistName:(NSString *)s;

@end
