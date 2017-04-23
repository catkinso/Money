#import <UIKit/UIKit.h>

@class DataManager;

@interface ViewControllerList : UIViewController <UIScrollViewDelegate>

- (id)initWithDataManager:(DataManager *)dataMgr;

@end
