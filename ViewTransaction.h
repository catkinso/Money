#import <UIKit/UIKit.h>

@class Transaction;

@interface ViewTransaction : UIView

@property (nonatomic) Transaction *transactionToShow;

- (id)initWithFrame:(CGRect)rect;
- (id)initWithFrame:(CGRect)rect Transaction:(Transaction *)transactionToShow;

@end
