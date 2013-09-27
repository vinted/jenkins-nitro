Jenkins test suite slowdown analyzer
=====================================

Analyze Jenkins test duration changes between builds and pinpoint the slowdowns

Usage
=====
View build time trend graph in Jenkins, pick two builds - one that was reasonably fast, another one after a slowdown. Feed them to `jenkins-nitro` and analyze the output:

![jenkins build time trend](https://dl.dropboxusercontent.com/u/176100/opensource/jenkins-nitro.png)

```
$ jenkins-nitro https://jenkins.internal/job/vinted-master 151 172
Slowdown        Test
============    ====
    1.0873 s    Item_push_down!
    1.0518 s    UserVoucherService_add_voucher_to_transaction raises an error if transaction already has a voucher
    0.9660 s    Item_update_timestamps push up by price only enabled when enough time has passed since last push up and title is changed behaves like unpushed item
    0.9552 s    Item_update_timestamps when user_updated_at is nil behaves like pushed up item
    0.9397 s    Item_update_timestamps push up by price only disabled when not enough time has passed since last push up and when price is lowered behaves like unpushed item
    0.8350 s    Transaction__History_existing_msg when its present and finding by item and user
    0.8225 s    Item_update_timestamps push up by price only enabled when enough time has passed since last push up behaves like unpushed item
    0.7932 s    Item_update_timestamps push up by price only enabled when not enough time has passed since last push up behaves like unpushed item
    0.7836 s    AdminAlertController_notify
    0.7785 s    Admin__ItemFunnelController show
    0.7550 s    Item_update_timestamps push up by price only disabled when enough time has passed since last push up behaves like unpushed item
    0.7488 s    Item_update_timestamps push up by price only enabled when enough time has passed since last push up and price is lowered not low enough behaves like pushed up item
    0.7424 s    Item_update_timestamps push up by price only disabled when enough time has passed since last push up and title is changed behaves like pushed up item
    0.7272 s    Item_update_timestamps push up by price only disabled when not enough time has passed since last push up and title is changed behaves like unpushed item
    0.7265 s    Item_update_timestamps push up by price only enabled when not enough time has passed since last push up and title is changed behaves like unpushed item
    0.7226 s    Item_update_timestamps push up by price only disabled when not enough time has passed since last push up behaves like unpushed item
    0.7219 s    Item_update_timestamps push up by price only enabled when not enough time has passed since last push up and when price is lowered behaves like unpushed item
    0.7123 s    Item_update_timestamps push up by price only enabled when enough time has passed since last push up and price is lowered behaves like pushed up item
    0.6858 s    Api__Api12Controller submit_item, update_item, delete_item submits item in colourless catalog item with colour
    0.6757 s    MarketplaceBalanceService_get_balance shows correct balance available_amount
    0.6297 s    UserVoucherService_add_voucher_to_transaction raises an error if transaction is not estimated or debit failed but new
    0.6159 s    UserVoucherService_add_voucher_to_transaction adds voucher and sets correct discount when transaction is after failed debit and voucher is more than item price
    0.6062 s    Transaction__History_available_ when available
    0.5821 s    TransactionService_update doesn't update when transaction is locked
    0.5745 s    Synchronizer_synchronize_model synchronizes existing entry attribute body
    0.5680 s    Items__Moderation.post_item_moderation item photo deletion doesn't delete photo behaves like accepted item status changer
    0.5252 s    UserVoucherService_add_voucher_to_transaction adds voucher and sets correct discount when transaction is after failed debit and voucher is less than item price
    0.5227 s    ItemsController_show mobile only behaves like meta tag filler og_title
    0.5202 s    Teaser__Experiment teaser A_B test logic old teaser
    0.5147 s    Item_is_visible locking_unlock
    0.5124 s    UserVoucherService_add_voucher_to_transaction adds voucher and sets correct discount when transaction is after failed debit and voucher is equal to item price
    0.5029 s    Transaction__CheckoutController_secure_payment when can debit and it succeeds and we can find the thread
    0.4939 s    UserVoucherService_remove_voucher_from_transaction removes voucher and removes discount
    0.4878 s    Transaction__CheckoutController_secure_payment when can debit and it succeeds and we cannot find the thread
    0.4488 s    UserVoucherService_remove_voucher_from_transaction raises an error if transaction has no voucher
    0.4483 s    Transaction__History_existing_msg when its present and finding by thread_id
    0.4461 s    UserVoucherService_add_voucher_to_transaction adds voucher and sets correct discount when transaction is estimated and voucher is more than item price
    0.4461 s    UserVoucherService_add_voucher_to_transaction adds voucher and sets correct discount when transaction is estimated and voucher is equal to item price
    0.4329 s    UserVoucherService_remove_voucher_from_transaction raises an error if transaction is not in estimated or debit failed
    0.4249 s    UserVoucherService_add_voucher_to_transaction raises an error if transaction is not estimated or debit failed but debit processed
    0.4236 s    UserVoucherService_add_voucher_to_transaction adds voucher and sets correct discount when transaction is estimated and voucher is less than item price
    0.4062 s    Transaction__History_conversation_url_params when not available
    0.4002 s    Transaction__History_available_ without user
    0.3990 s    Transaction__History_available_ when not available
    0.3911 s    Transaction__History_conversation_url_params when available
    0.3844 s    Item_update_timestamps push up by price only enabled when price is rised and last_push_up_at is greater than user_updated_at
    0.3839 s    Transaction__History_existing_msg when its not present
    0.3839 s    Item_update_timestamps push up by price only disabled when price is rised and last_push_up_at is greater than user_updated_at
    0.3825 s    Item_update_timestamps push up by price only disabled when price is rised

Total slowdown from worst 50 changes
============
   30.8340 s
```
