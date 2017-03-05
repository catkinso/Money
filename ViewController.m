#import "ViewController.h"

#import "ViewControllerList.h"
#import "ViewControllerNew.h"
#import "ViewControllerUtil.h"
#import "ViewTransaction.h"
#import "DataManager.h"
#import "Transaction.h"

@implementation ViewController
{
    DataManager *dm;
    
    ViewControllerList *vcl;
    ViewControllerNew *vcn;
    ViewControllerUtil *vcu;
    
    ViewTransaction *vt;
    
    UILabel *sumLabel;
    UILabel *lastTransactionTitleLabel;
}


- (void)viewDidLoad
{
    CGRect rect;
    
    UILabel *summaryTitleLabel;
    UILabel *sumTitleLabel;
    
    UIButton *listButton;
    UIButton *newTransactionButton;
    UIButton *utilitiesButton;
    
    
    [super viewDidLoad];
    
    dm = [[DataManager alloc] init];
    vcl = [[ViewControllerList alloc] initWithDataManager:dm];
    vcn = [[ViewControllerNew alloc] initWithDataManager:dm];
    vcu = [[ViewControllerUtil alloc] initWithDataManager:dm];

   
    /* Title label */
    rect = CGRectMake(30.0, 40.0, 100.0, 35.0);
    summaryTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [summaryTitleLabel setFont:[summaryTitleLabel.font fontWithSize:28]];
    summaryTitleLabel.text = @"Money";
    [self.view addSubview:summaryTitleLabel];
    

    /* Transactions button */
    rect = CGRectMake(30.0, 80.0, 110.0, 25.0);
    listButton = [[UIButton alloc] initWithFrame:rect];
    [listButton addTarget:self action:@selector(eventButtonClicked)
                    forControlEvents:UIControlEventTouchUpInside];
    [listButton setTitle:@"Transactions" forState:UIControlStateNormal];
    listButton.contentHorizontalAlignment
                   = UIControlContentHorizontalAlignmentLeft;
    [listButton setTitleColor:[UIColor blueColor]
                    forState:UIControlStateNormal];
    [listButton setTitleColor:[UIColor grayColor]
                    forState:UIControlStateHighlighted];
    [self.view addSubview:listButton];
    
    
    /* New transaction button */
    rect = CGRectMake(30.0, 120.0, 140.0, 25.0);
    newTransactionButton = [[UIButton alloc] initWithFrame:rect];
    [newTransactionButton addTarget:self
                              action:@selector(newTransactionButtonClicked)
                              forControlEvents:UIControlEventTouchUpInside];
    [newTransactionButton setTitle:@"New Transaction"
                              forState:UIControlStateNormal];
    newTransactionButton.contentHorizontalAlignment
                             = UIControlContentHorizontalAlignmentLeft;
    [newTransactionButton setTitleColor:[UIColor blueColor]
                              forState:UIControlStateNormal];
    [newTransactionButton setTitleColor:[UIColor grayColor]
                              forState:UIControlStateHighlighted];
    [self.view addSubview:newTransactionButton];

    
    /* Utilities button */
    rect = CGRectMake(30.0, 160.0, 70.0, 25.0);
    utilitiesButton = [[UIButton alloc] initWithFrame:rect];
    [utilitiesButton addTarget:self action:@selector(utilitiesButtonClicked)
                         forControlEvents:UIControlEventTouchUpInside];
    [utilitiesButton setTitle:@"Utilities" forState:UIControlStateNormal];
    utilitiesButton.contentHorizontalAlignment
                        = UIControlContentHorizontalAlignmentLeft;
    [utilitiesButton setTitleColor:[UIColor blueColor]
                         forState:UIControlStateNormal];
    [utilitiesButton setTitleColor:[UIColor grayColor]
                         forState:UIControlStateHighlighted];
    [self.view addSubview:utilitiesButton];


    /* Sum amount labels */
    rect = CGRectMake(30.0, 410.0, 140.0, 25.0);
    sumTitleLabel = [[UILabel alloc] initWithFrame:rect];
    sumTitleLabel.text = @"Total:";
    [self.view addSubview:sumTitleLabel];
    
    rect = CGRectMake(130.0, 410.0, 140.0, 25.0);
    sumLabel = [[UILabel alloc] initWithFrame:rect];
    [self.view addSubview:sumLabel];
    
    
    /* Last transaction title label */
    rect = CGRectMake(30.0, 460.0, 110.0, 20.0);
    lastTransactionTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [lastTransactionTitleLabel setFont:[lastTransactionTitleLabel.font
                                   fontWithSize:12]];
    lastTransactionTitleLabel.text = @"Last Transaction";
    lastTransactionTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:lastTransactionTitleLabel];
    
    
    /* Last transaction view */
    rect = CGRectMake(20.0, 475.0, 330.0, 110.0);
    vt = [[ViewTransaction alloc] initWithFrame:rect];
}


- (void)viewWillAppear:(BOOL)animated
{
    int d, c;
    
    /* Update amount in sum amount label */
    [dm getTotalDollars:&d Cents:&c];
    sumLabel.text = [NSString stringWithFormat:@"$%d.%02d", d, c];

    
    /* Add or remove last transaction label and view */
    vt.transactionToShow = [dm getLastTransaction];
    if (vt.transactionToShow != nil) {
        [self.view addSubview:vt];
        [self.view addSubview:lastTransactionTitleLabel];
    }
    else {
        [vt removeFromSuperview];
        [lastTransactionTitleLabel removeFromSuperview];
    }
}


- (void)eventButtonClicked
{
    [self presentViewController:vcl animated:NO completion:nil];
}


- (void)newTransactionButtonClicked
{
    [self presentViewController:vcn animated:NO completion:nil];
}


- (void)utilitiesButtonClicked
{
    [self presentViewController:vcu animated:NO completion:nil];
}

@end
