#import "ViewControllerList.h"

#import "DataManager.h"
#import "Transaction.h"
#import "ViewControllerNew.h"
#import "ViewTransaction.h"

@implementation ViewControllerList
{
    DataManager *dm;
    Transaction *ts[3];
    ViewControllerNew *vcn;

    ViewTransaction *vts[3];
    
    UIButton *backButton;
    UIButton *editButtons[3];
    UIButton *deleteButtons[3];
    
    UILabel *totalTransactionsLabel;
    UILabel *numTransactionLabels[3];
}


- (id)initWithDataManager:(DataManager *)dataMgr
{
    self = [super init];
    
    if (self)
        dm = dataMgr;

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

    
    /* Three transactions */
    for (i = 0; i < 3; i++) {
        
        /* Transaction number label */
        rect = CGRectMake(30.0, 180.0 + (140.0 * i), 50.0, 20.0);
        numTransactionLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [numTransactionLabels[i] setFont:[numTransactionLabels[i].font
                                     fontWithSize:12]];
        numTransactionLabels[i].text = @"-";
        numTransactionLabels[i].textColor = [UIColor grayColor];
        numTransactionLabels[i].textAlignment = NSTextAlignmentLeft;
        
        
        /* Transaction edit button */
        rect = CGRectMake(310.0, 180.0 + (140.0 * i), 25.0, 20.0);
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
        rect = CGRectMake(20.0, 195.0 + (140.0 * i), 330.0, 110.0);
        vts[i] = [[ViewTransaction alloc] initWithFrame:rect];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    int numTransactions;
    int currentIdx;
    int i;

    /* Update number of tranactions label */    
    numTransactions = [dm getNumTransactions];
    totalTransactionsLabel.text = [[NSString alloc]
                                      initWithFormat:@"%d", numTransactions];


    /* Add and update up to 3 transaction views, transaction number labels
       and edit buttons */
    currentIdx = numTransactions - 1;
    for (i = 0; i < 3; i++) {
        if (currentIdx >= 0) {
            numTransactionLabels[i].text = [[NSString alloc]
                                       initWithFormat:@"%05d", currentIdx + 1];
            vts[i].transactionToShow = [dm getTransactionAtIndex:currentIdx];

            if ([numTransactionLabels[i] superview] == nil)
                [self.view addSubview:numTransactionLabels[i]];
            
            if ([editButtons[i] superview] == nil)
                [self.view addSubview:editButtons[i]];
            
            if ([vts[i] superview] == nil)
                [self.view addSubview:vts[i]];
        }
        else {
            if ([numTransactionLabels[i] superview] != nil)
                [numTransactionLabels[i] removeFromSuperview];
            
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
    tIdx = [dm getNumTransactions] - 1;
    
    if (b == editButtons[0])
        tIdx -= 0;
    else if (b == editButtons[1])
        tIdx -= 1;
    else if (b == editButtons[2])
        tIdx -= 2;
    
    if (tIdx >= 0) {
        vcn = [[ViewControllerNew alloc] initWithDataManager:dm
                  transaction:[dm getTransactionAtIndex:tIdx]];
        [self presentViewController:vcn animated:NO completion:nil];
    }
}


- (void)backButtonClicked
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
