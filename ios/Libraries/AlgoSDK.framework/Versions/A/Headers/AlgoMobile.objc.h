// Objective-C API for talking to github.com/algorand/go-algorand-sdk/mobile Go package.
//   gobind -lang=objc -prefix="Algo" github.com/algorand/go-algorand-sdk/mobile
//
// File is generated by gobind. Do not edit.

#ifndef __AlgoMobile_H__
#define __AlgoMobile_H__

@import Foundation;
#include "ref.h"
#include "Universe.objc.h"


@class AlgoMobileBytesArray;
@class AlgoMobileInt64Array;
@class AlgoMobileStringArray;
@class AlgoMobileSuggestedParams;
@class AlgoMobileUint64;

@interface AlgoMobileBytesArray : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (nonnull instancetype)init;
- (void)append:(NSData* _Nullable)value;
// skipped method BytesArray.Extract with unsupported parameter or return types

- (NSData* _Nullable)get:(long)index;
- (long)length;
- (void)set:(long)index value:(NSData* _Nullable)value;
@end

@interface AlgoMobileInt64Array : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (nonnull instancetype)init;
- (void)append:(int64_t)value;
// skipped method Int64Array.Extract with unsupported parameter or return types

- (int64_t)get:(long)index;
- (long)length;
- (void)set:(long)index value:(int64_t)value;
@end

@interface AlgoMobileStringArray : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (nonnull instancetype)init;
- (void)append:(NSString* _Nullable)value;
// skipped method StringArray.Extract with unsupported parameter or return types

- (NSString* _Nonnull)get:(long)index;
- (long)length;
- (void)set:(long)index value:(NSString* _Nullable)value;
@end

@interface AlgoMobileSuggestedParams : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (nonnull instancetype)init;
/**
 * Fee is the suggested transaction fee
Fee is in units of micro-Algos per byte.
Fee may fall to zero but transactions must still have a fee of
at least MinTxnFee for the current network protocol.
 */
@property (nonatomic) int64_t fee;
/**
 * Genesis ID
 */
@property (nonatomic) NSString* _Nonnull genesisID;
/**
 * Genesis hash
 */
@property (nonatomic) NSData* _Nullable genesisHash;
/**
 * FirstRoundValid is the first protocol round on which the txn is valid
 */
@property (nonatomic) int64_t firstRoundValid;
/**
 * LastRoundValid is the final protocol round on which the txn may be committed
 */
@property (nonatomic) int64_t lastRoundValid;
/**
 * FlatFee indicates whether the passed fee is per-byte or per-transaction
 */
@property (nonatomic) BOOL flatFee;
@end

@interface AlgoMobileUint64 : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) _Nonnull id _ref;

- (nonnull instancetype)initWithRef:(_Nonnull id)ref;
- (nonnull instancetype)init;
@property (nonatomic) int64_t upper;
@property (nonatomic) int64_t lower;
// skipped method Uint64.Extract with unsupported parameter or return types

@end

/**
 * GetProgramAddress returns the escrow account address for a program, derived from its TEAL bytecode.
 */
FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileAddressFromProgram(NSData* _Nullable program);

/**
 * AssignGroupID computes and return list of encoded transactions with Group field set.
 */
FOUNDATION_EXPORT AlgoMobileBytesArray* _Nullable AlgoMobileAssignGroupID(AlgoMobileBytesArray* _Nullable txns, NSError* _Nullable* _Nullable error);

/**
 * AttachSignature accepts a signature and a transaction, and returns the bytes of a the signed transaction
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileAttachSignature(NSData* _Nullable signature, NSData* _Nullable encodedTx, NSError* _Nullable* _Nullable error);

/**
 * AttachSignatureWithSigner accepts a signature, a transaction, and a signer address and returns the bytes of a the signed transaction
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileAttachSignatureWithSigner(NSData* _Nullable signature, NSData* _Nullable encodedTx, NSString* _Nullable signer, NSError* _Nullable* _Nullable error);

/**
 * FindAndVerifyTxnGroups takes an array of encoded transactions and finds and verifies consecutive
transactions which claim to be an atomic group. It returns an array of integers which is the same
length as the array of input transactions. If two indexes in this array have the same value, then
the transactions at the same indexes in the input array are in the same atomic group.
 */
FOUNDATION_EXPORT AlgoMobileInt64Array* _Nullable AlgoMobileFindAndVerifyTxnGroups(AlgoMobileBytesArray* _Nullable txns, NSError* _Nullable* _Nullable error);

FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileGenerateAddressFromPublicKey(NSData* _Nullable pk, NSError* _Nullable* _Nullable error);

FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileGenerateAddressFromSK(NSData* _Nullable sk, NSError* _Nullable* _Nullable error);

FOUNDATION_EXPORT NSData* _Nullable AlgoMobileGenerateSK(void);

/**
 * GetTxID takes an encoded txn and return the txid as string
 */
FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileGetTxID(NSData* _Nullable encodedTxn);

FOUNDATION_EXPORT BOOL AlgoMobileIsValidAddress(NSString* _Nullable addr);

/**
 * MakeApplicationClearStateTx makes a transaction for clearing out all
account-specific state for an application. It may not be rejected by the
application's logic. (see above for args desc.)
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationClearStateTx(int64_t appIdx, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeApplicationCloseOutTx makes a transaction for closing out of
(deallocating all account-specific state for) an application (see above for args desc.)
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationCloseOutTx(int64_t appIdx, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeApplicationCreateTx makes a transaction for creating an application (see above for args desc.)
- optIn: true for opting in on complete, false for no-op.
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationCreateTx(BOOL optIn, NSData* _Nullable approvalProg, NSData* _Nullable clearProg, int64_t globalSchemaUint, int64_t globalSchemaByteSlice, int64_t localSchemaUint, int64_t localSchemaByteSlice, int32_t extraPages, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeApplicationDeleteTx makes a transaction for deleting an application (see above for args desc.)
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationDeleteTx(int64_t appIdx, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeApplicationNoOpTx makes a transaction for interacting with an existing
application, potentially updating any account-specific local state and
global state associated with it. (see above for args desc.)
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationNoOpTx(int64_t appIdx, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeApplicationOptInTx makes a transaction for opting in to (allocating
some account-specific state for) an application (see above for args desc.)
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationOptInTx(int64_t appIdx, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeApplicationUpdateTx makes a transaction for updating an application's programs (see above for args desc.)
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeApplicationUpdateTx(int64_t appIdx, AlgoMobileBytesArray* _Nullable appArgs, AlgoMobileStringArray* _Nullable accounts, AlgoMobileInt64Array* _Nullable foreignApps, AlgoMobileInt64Array* _Nullable foreignAssets, NSData* _Nullable approvalProg, NSData* _Nullable clearProg, AlgoMobileSuggestedParams* _Nullable params, NSString* _Nullable sender, NSData* _Nullable note, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetAcceptanceTxn creates a tx for marking an account as willing to accept the given asset
- account is a checksummed, human-readable address that will send the transaction and begin accepting the asset
- note is an arbitrary byte array
- index is the asset index
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetAcceptanceTxn(NSString* _Nullable account, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, int64_t index, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetConfigTxn creates a tx template for changing the
keys for an asset. An empty string means a zero key (which
cannot be changed after becoming zero); to keep a key
unchanged, you must specify that key.
- account is a checksummed, human-readable address for which we register the given participation key.
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetConfigTxn(NSString* _Nullable account, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, int64_t index, NSString* _Nullable newManager, NSString* _Nullable newReserve, NSString* _Nullable newFreeze, NSString* _Nullable newClawback, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetCreateTxn constructs an asset creation transaction using the passed parameters.
- account is a checksummed, human-readable address which will send the transaction.
- note is a byte array
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetCreateTxn(NSString* _Nullable account, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, AlgoMobileUint64* _Nullable total, int32_t decimals, BOOL defaultFrozen, NSString* _Nullable manager, NSString* _Nullable reserve, NSString* _Nullable freeze, NSString* _Nullable clawback, NSString* _Nullable unitName, NSString* _Nullable assetName, NSString* _Nullable url, NSData* _Nullable metadataHash, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetDestroyTxn creates a tx template for destroying an asset, removing it from the record.
All outstanding asset amount must be held by the creator, and this transaction must be issued by the asset manager.
- account is a checksummed, human-readable address that will send the transaction; it also must be the asset manager
- index is the asset index
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetDestroyTxn(NSString* _Nullable account, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, int64_t index, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetFreezeTxn constructs a transaction that freezes or unfreezes an account's asset holdings
It must be issued by the freeze address for the asset
- account is a checksummed, human-readable address which will send the transaction.
- note is an optional arbitrary byte array
- assetIndex is the index for tracking the asset
- target is the account to be frozen or unfrozen
- newFreezeSetting is the new state of the target account
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetFreezeTxn(NSString* _Nullable account, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, int64_t assetIndex, NSString* _Nullable target, BOOL newFreezeSetting, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetRevocationTxn creates a tx for revoking an asset from an account and sending it to another
- account is a checksummed, human-readable address; it must be the revocation manager / clawback address from the asset's parameters
- target is a checksummed, human-readable address; it is the account whose assets will be revoked
- recipient is a checksummed, human-readable address; it will receive the revoked assets
- amount defines the number of assets to clawback
- index is the asset index
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetRevocationTxn(NSString* _Nullable account, NSString* _Nullable target, AlgoMobileUint64* _Nullable amount, NSString* _Nullable recipient, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, int64_t index, NSError* _Nullable* _Nullable error);

/**
 * MakeAssetTransferTxn creates a tx for sending some asset from an asset holder to another user
the recipient address must have previously issued an asset acceptance transaction for this asset
- account is a checksummed, human-readable address that will send the transaction and assets
- recipient is a checksummed, human-readable address what will receive the assets
- closeAssetsTo is a checksummed, human-readable address that behaves as a close-to address for the asset transaction; the remaining assets not sent to recipient will be sent to closeAssetsTo. Leave blank for no close-to behavior.
- amount is the number of assets to send
- note is an arbitrary byte array
- creator is the address of the asset creator
- index is the asset index
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeAssetTransferTxn(NSString* _Nullable account, NSString* _Nullable recipient, NSString* _Nullable closeAssetsTo, AlgoMobileUint64* _Nullable amount, NSData* _Nullable note, AlgoMobileSuggestedParams* _Nullable params, int64_t index, NSError* _Nullable* _Nullable error);

FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeBid(NSString* _Nullable bidderAddress, int64_t bidAmount, int64_t maxPrice, int64_t bidID, NSString* _Nullable auctionAddress, int64_t auctionID, NSError* _Nullable* _Nullable error);

/**
 * MakePaymentTxn constructs a payment transaction using the passed parameters.
`from` and `to` addresses should be checksummed, human-readable addresses
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakePaymentTxn(NSString* _Nullable from, NSString* _Nullable to, AlgoMobileUint64* _Nullable amount, NSData* _Nullable note, NSString* _Nullable closeRemainderTo, AlgoMobileSuggestedParams* _Nullable params, NSError* _Nullable* _Nullable error);

/**
 * MakeRekeyTxn constructs a rekey transaction using the passed parameters.
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMakeRekeyTxn(NSString* _Nullable from, NSString* _Nullable rekeyTo, AlgoMobileSuggestedParams* _Nullable params, NSError* _Nullable* _Nullable error);

// skipped function MakeUint64 with unsupported parameter or return types


/**
 * MnemonicFromKey converts a 32-byte key into a 25 word mnemonic. The generated
mnemonic includes a checksum. Each word in the mnemonic represents 11 bits
of data, and the last 11 bits are reserved for the checksum.
 */
FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileMnemonicFromKey(NSData* _Nullable key, NSError* _Nullable* _Nullable error);

/**
 * MnemonicFromMasterDerivationKey is a helper that converts an MDK to a
human-readable mnemonic
 */
FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileMnemonicFromMasterDerivationKey(NSData* _Nullable mdk, NSError* _Nullable* _Nullable error);

/**
 * MnemonicFromPrivateKey is a helper that converts an ed25519 private key to a
human-readable mnemonic
 */
FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileMnemonicFromPrivateKey(NSData* _Nullable sk, NSError* _Nullable* _Nullable error);

/**
 * MnemonicToKey converts a mnemonic generated using this library into the
source key used to create it. It returns an error if the passed mnemonic has
an incorrect checksum, if the number of words is unexpected, or if one of the
passed words is not found in the words list.
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMnemonicToKey(NSString* _Nullable mnemonicStr, NSError* _Nullable* _Nullable error);

/**
 * MnemonicToMasterDerivationKey is a helper that converts a mnemonic directly
to a master derivation key
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMnemonicToMasterDerivationKey(NSString* _Nullable mnemonicStr, NSError* _Nullable* _Nullable error);

/**
 * MnemonicToPrivateKey is a helper that converts a mnemonic directly to an
ed25519 private key
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileMnemonicToPrivateKey(NSString* _Nullable mnemonicStr, NSError* _Nullable* _Nullable error);

// skipped function PendingResultsToTXID with unsupported parameter or return types


FOUNDATION_EXPORT NSData* _Nullable AlgoMobileSignBid(NSData* _Nullable sk, NSData* _Nullable encodedBid, NSError* _Nullable* _Nullable error);

/**
 * SignTransaction accepts a private key and a transaction, and returns the
bytes of a signed txn.
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileSignTransaction(NSData* _Nullable sk, NSData* _Nullable encodedTx, NSError* _Nullable* _Nullable error);

/**
 * TransactionJsonToMsgpack converts a json-encoded Transaction to a
msgpack-encoded Transaction
 */
FOUNDATION_EXPORT NSData* _Nullable AlgoMobileTransactionJsonToMsgpack(NSString* _Nullable jsonTxn, NSError* _Nullable* _Nullable error);

/**
 * TransactionMsgpackToJson converts a msgpack-encoded Transaction to a
json-encoded Transaction
 */
FOUNDATION_EXPORT NSString* _Nonnull AlgoMobileTransactionMsgpackToJson(NSData* _Nullable msgpTxn, NSError* _Nullable* _Nullable error);

/**
 * VerifyGroupID verifies that an atomic group of transactions all contain the correct group ID
 */
FOUNDATION_EXPORT BOOL AlgoMobileVerifyGroupID(AlgoMobileBytesArray* _Nullable txns, BOOL* _Nullable valid, NSError* _Nullable* _Nullable error);

#endif
