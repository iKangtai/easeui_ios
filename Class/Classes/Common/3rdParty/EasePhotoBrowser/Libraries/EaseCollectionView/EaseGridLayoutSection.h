//
//  EaseGridLayoutSection.h
//  PSPDFKit
//
//  Copyright (c) 2012-2013 Peter Steinberger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EaseGridLayoutInfo, EaseGridLayoutRow, EaseGridLayoutItem;

@interface EaseGridLayoutSection : NSObject

@property (nonatomic, strong, readonly) NSArray *items;
@property (nonatomic, strong, readonly) NSArray *rows;

// fast path for equal-size items
@property (nonatomic, assign) BOOL fixedItemSize;
@property (nonatomic, assign) CGSize itemSize;
// depending on fixedItemSize, this either is a _ivar or queries items.
@property (nonatomic, assign) NSInteger itemsCount;

@property (nonatomic, assign) CGFloat verticalInterstice;
@property (nonatomic, assign) CGFloat horizontalInterstice;
@property (nonatomic, assign) UIEdgeInsets sectionMargins;

@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CGRect headerFrame;
@property (nonatomic, assign) CGRect footerFrame;
@property (nonatomic, assign) CGFloat headerDimension;
@property (nonatomic, assign) CGFloat footerDimension;
@property (nonatomic, unsafe_unretained) EaseGridLayoutInfo *layoutInfo;
@property (nonatomic, strong) NSDictionary *rowAlignmentOptions;

@property (nonatomic, assign, readonly) CGFloat otherMargin;
@property (nonatomic, assign, readonly) CGFloat beginMargin;
@property (nonatomic, assign, readonly) CGFloat endMargin;
@property (nonatomic, assign, readonly) CGFloat actualGap;
@property (nonatomic, assign, readonly) CGFloat lastRowBeginMargin;
@property (nonatomic, assign, readonly) CGFloat lastRowEndMargin;
@property (nonatomic, assign, readonly) CGFloat lastRowActualGap;
@property (nonatomic, assign, readonly) BOOL lastRowIncomplete;
@property (nonatomic, assign, readonly) NSInteger itemsByRowCount;
@property (nonatomic, assign, readonly) NSInteger indexOfImcompleteRow; // typo as of iOS6B3

//- (EaseGridLayoutSection *)copyFromLayoutInfo:(EaseGridLayoutInfo *)layoutInfo;

// Faster variant of invalidate/compute
- (void)recomputeFromIndex:(NSInteger)index;

// Invalidate layout. Destroys rows.
- (void)invalidate;

// Compute layout. Creates rows.
- (void)computeLayout;

- (EaseGridLayoutItem *)addItem;

- (EaseGridLayoutRow *)addRow;

// Copy snapshot of current object
- (EaseGridLayoutSection *)snapshot;

@end
