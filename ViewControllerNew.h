#import <UIKit/UIKit.h>

@class DataManager;
@class Transaction;

@interface ViewControllerNew : UIViewController
             <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

- (id)initWithDataManager:(DataManager *)dataMgr;
- (id)initWithDataManager:(DataManager *)dataMgr transaction:(Transaction *)tr;

@end
