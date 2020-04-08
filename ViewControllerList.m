#import "ViewControllerList.h"

#import "DataManager.h"
#import "Transaction.h"
#import "ViewControllerNew.h"
#import "ViewTransaction.h"

@implementation ViewControllerList
{
    DataManager *dm;
    Transaction *ts[5];
    ViewControllerNew *vcn;

    ViewTransaction *vts[5];
    
    UIScrollView *uisv;
    
    UIButton *backButton;
    UIButton *editButtons[5];
    UIButton *deleteButtons[5];
    
    UILabel *totalTransactionsLabel;
    UILabel *uuidTransactionLabels[5];
    
    int topDisplayedIdx;
}


- (id)initWithDataManager:(DataManager *)dataMgr
{
    self = [super init];
    
    if (self) {
        dm = dataMgr;
        
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }

    return self;
}


- (void)viewDidLoad
{
    int i;
    
    CGRect rect;
    
    UILabel *eventTitleLabel;
    UILabel *totalTransactionsTitleLabel;
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    /* Title label */
    rect = CGRectMake(30.0, 40.0, 180.0, 35.0);
    eventTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [eventTitleLabel setFont:[eventTitleLabel.font fontWithSize:28]];
    eventTitleLabel.text = @"Transactions";
    [self.view addSubview:eventTitleLabel];
    
    
    /* Back button */
    rect = CGRectMake(30.0, 80.0, 50.0, 25.0);
    backButton = [[UIButton alloc] initWithFrame:rect];
    [backButton addTarget:self action:@selector(backButtonClicked)
                    forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment
                   = UIControlContentHorizontalAlignmentLeft;
    [backButton setTitleColor:[UIColor blueColor]
                    forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor]
                    forState:UIControlStateHighlighted];
    [self.view addSubview:backButton];

    
    /* Total transactions labels */
    rect = CGRectMake(30.0, 150, 150.0, 25.0);
    totalTransactionsTitleLabel = [[UILabel alloc] initWithFrame:rect];
    totalTransactionsTitleLabel.text = @"Total Transactions:";
    [self.view addSubview:totalTransactionsTitleLabel];
    
    rect = CGRectMake(190.0, 150, 80.0, 25.0);
    totalTransactionsLabel = [[UILabel alloc] initWithFrame:rect];
    [self.view addSubview:totalTransactionsLabel];
    
    
    /* Scroll view */
    rect = CGRectMake(0, 180.0, 375.0, 420.0);
    uisv = [[UIScrollView alloc] initWithFrame:rect];
    //[uisv setBackgroundColor:[UIColor yellowColor]];
    [uisv setContentSize:CGSizeMake(375.0, 700.0)];
    uisv.showsVerticalScrollIndicator = NO;
    uisv.delegate = self;
    [self.view addSubview:uisv];

    /* Three transactions */
    for (i = 0; i < 5; i++) {
        
        /* Transaction uuid label */
        rect = CGRectMake(30.0, 10.0 + (140.0 * i), 300.0, 20.0);
        uuidTransactionLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [uuidTransactionLabels[i] setFont:[uuidTransactionLabels[i].font
                                     fontWithSize:10]];
        uuidTransactionLabels[i].text = @"-";
        uuidTransactionLabels[i].textColor = [UIColor grayColor];
        uuidTransactionLabels[i].textAlignment = NSTextAlignmentLeft;
        

        /* Transaction edit button */
        rect = CGRectMake(310.0, 10.0 + (140.0 * i), 25.0, 20.0);
        editButtons[i] = [[UIButton alloc] initWithFrame:rect];
        [editButtons[i] addTarget:self action:@selector(editButtonsClicked:)
                            forControlEvents:UIControlEventTouchUpInside];
        editButtons[i].titleLabel.font = [editButtons[i].titleLabel.font
                                             fontWithSize:12];
        [editButtons[i] setTitle:@"Edit" forState:UIControlStateNormal];
        editButtons[i].contentHorizontalAlignment
                           = UIControlContentHorizontalAlignmentRight;
        [editButtons[i] setTitleColor:[UIColor blueColor]
                            forState:UIControlStateNormal];
        [editButtons[i] setTitleColor:[UIColor grayColor]
                            forState:UIControlStateHighlighted];
     
        
        /* Transaction view */        
        rect = CGRectMake(20.0, 25.0 + (140.0 * i), 330.0, 110.0);
        vts[i] = [[ViewTransaction alloc] initWithFrame:rect];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    int numTransactions;
    
    /* Update number of transactions label */
    numTransactions = [dm getNumTransactions];
    totalTransactionsLabel.text = [[NSString alloc]
                                   initWithFormat:@"%d", numTransactions];
    
    topDisplayedIdx = numTransactions - 1;
    [uisv setContentOffset:CGPointMake(0, 0)];
    [self updateTransactionLabels];
}


- (void)updateTransactionLabels
{
    int currentIdx;
    int i;

    /* Add and update up to 5 transaction views, transaction number labels
       and edit buttons */
    currentIdx = topDisplayedIdx;
    for (i = 0; i < 5; i++) {
        if (currentIdx >= 0) {
            Transaction *t;
            
            t = [dm getTransactionAtIndex:currentIdx];
            uuidTransactionLabels[i].text = t.uuid;
            vts[i].transactionToShow = t;
            
            if ([uuidTransactionLabels[i] superview] == nil)
                [uisv addSubview:uuidTransactionLabels[i]];
            
            if ([editButtons[i] superview] == nil)
                [uisv addSubview:editButtons[i]];
            
            if ([vts[i] superview] == nil)
                [uisv addSubview:vts[i]];
        }
        else {
            if ([uuidTransactionLabels[i] superview] != nil)
                [uuidTransactionLabels[i] removeFromSuperview];
            
            if ([editButtons[i] superview] != nil)
                [editButtons[i] removeFromSuperview];
            
            if ([vts[i] superview] != nil)
                [vts[i] removeFromSuperview];
        }
        currentIdx--;
    }
}


- (void)editButtonsClicked:(id)sender
{
    int tIdx;
    UIButton *b;
    
    b = (UIButton *)sender;
    tIdx = topDisplayedIdx;
    
    if (b == editButtons[0])
        tIdx -= 0;
    else if (b == editButtons[1])
        tIdx -= 1;
    else if (b == editButtons[2])
        tIdx -= 2;
    else if (b == editButtons[3])
        tIdx -= 3;
    else if (b == editButtons[4])
        tIdx -= 4;
    
    if (tIdx >= 0) {
        vcn = [[ViewControllerNew alloc] initWithDataManager:dm
                  transaction:[dm getTransactionAtIndex:tIdx]];
        [self presentViewController:vcn animated:NO completion:nil];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int prevTopDisplayedIdx;
    
    prevTopDisplayedIdx = topDisplayedIdx;
    if (scrollView.contentOffset.y > 280 && topDisplayedIdx >= 5) {
        topDisplayedIdx--;
    }
    else if (scrollView.contentOffset.y < 0
                && topDisplayedIdx < [dm getNumTransactions] - 1) {
        topDisplayedIdx++;
    }
    
    if (prevTopDisplayedIdx != topDisplayedIdx) {
        [self updateTransactionLabels];
        [scrollView setContentOffset:CGPointMake(0, 140)];
    }
}


- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
