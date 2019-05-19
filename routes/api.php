<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::group(['middleware' => 'auth:api'], function () {
    Route::post('logout', 'Auth\LoginController@logout');
    //Route::post('logout', 'AppController@logout');
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

 
    Route::get('dashboard_info', 'AppController@index');
    //Route::get('home', 'AppController@index');

    //Estimate
    Route::get('getEstimateList', 'EstimateController@getEstimateList');
    Route::resource('estimate', 'EstimateController');
    Route::get('estimate/{id}/pdf', 'EstimateController@pdf');
    Route::get('estimate_EmailToCustomer/{resolution_id}', 'EstimateController@getTemplateEmailToCustomer');

     //Remision
     Route::get('getRemisionList', 'RemisionController@getRemisionList');
     Route::resource('remision', 'RemisionController');
     Route::get('remision/{id}/pdf', 'RemisionController@pdf');
     Route::get('remision_EmailToCustomer/{resolution_id}', 'RemisionController@getTemplateEmailToCustomer');
     Route::put('remision_update_state/{req}', 'RemisionController@update_state');

     //Nota crédito
    Route::resource('credit-note', 'CreditNoteController');
    Route::get('getCreditNoteList', 'CreditNoteController@getCreditNoteList');
    Route::get('credit-note/{id}/pdf', 'CreditNoteController@pdf');
    Route::get('getTemplateEmailToCustomerCreditNote/{resolution_id}', 'CreditNoteController@getTemplateEmailToCustomer');

    //payment received
    Route::resource('payment-in', 'PaymentIn_Controller');
    Route::get('getPaymentList', 'PaymentIn_Controller@getPaymentList');
    Route::get('getInvoicePendingtoPay/{customer_id}', 'PaymentIn_Controller@getInvoicePendingtoPay_data');
    Route::get('getInvoicePendingtoPay_edit/{customer_id}', 'PaymentIn_Controller@getInvoicePendingtoPay_data_edit');
    Route::put('payment_in_update_state/{req}', 'PaymentIn_Controller@update_state');
    Route::get('payment_in_ToCategorySection', 'PaymentIn_Controller@getBaseInfoToCategorySection');
    Route::get('payment-in/{id}/pdf', 'PaymentIn_Controller@pdf');
    Route::get('getTemplateEmailToCustomerPaymentIn/{resolution_id}', 'PaymentIn_Controller@getTemplateEmailToCustomer');

    //purchase order
    Route::resource('purchase-order', 'PurchaseOrderController');
    Route::get('getPOList', 'PurchaseOrderController@getPOList');
    Route::get('purchase-order/{id}/pdf', 'PurchaseOrderController@pdf');
    Route::get('getTemplateEmailToCustomerPO/{resolution_id}', 'PurchaseOrderController@getTemplateEmailToCustomer');

    //Invoice for sale
    Route::resource('invoice', 'InvoiceSaleOrderController');
    Route::get('getInvoiceList','InvoiceSaleOrderController@getInvoiceList');
    Route::get('invoice/{id}/pdf', 'InvoiceSaleOrderController@pdf');
    Route::put('invoice_update_state/{req}','InvoiceSaleOrderController@update_state');
    Route::get('getTemplateEmailToCustomerInvoice/{resolution_id}', 'InvoiceSaleOrderController@getTemplateEmailToCustomer');

    //Bill
    Route::resource('bill', 'BillController');
    Route::get('getBillList','BillController@getBillList');
    Route::get('bill/{id}/pdf', 'BillController@pdf');
    Route::put('bill_update_state/{req}','BillController@update_state');

    //Debit note
    Route::resource('debit-note', 'DebitNoteController');
    Route::get('getDebitNoteList','DebitNoteController@getDebitNoteList');
    Route::get('debit-note/{id}/pdf', 'DebitNoteController@pdf');    

    //purchase order
    Route::resource('purchase-order', 'PurchaseOrderController');
    Route::get('getPOList','PurchaseOrderController@getPOList');
    Route::get('purchase-order/{id}/pdf', 'PurchaseOrderController@pdf');
    Route::get('getTemplateEmailToCustomerPO/{resolution_id}', 'PurchaseOrderController@getTemplateEmailToCustomer');

    //payment made by customer
    Route::resource('payment-out', 'PaymentOut_Controller');
    Route::get('getPaymentOut_List','PaymentOut_Controller@getPaymentList');
    Route::get('getInvoicePendingtoPay_out/{customer_id}','PaymentOut_Controller@getInvoicePendingtoPay_data');
    Route::get('getInvoicePendingtoPay_edit_out/{customer_id}','PaymentOut_Controller@getInvoicePendingtoPay_data_edit');
    Route::get('payment_out_ToCategorySection','PaymentOut_Controller@getBaseInfoToCategorySection');
    Route::put('payment_out_update_state/{req}','PaymentOut_Controller@update_state');
    Route::get('payment-out/{id}/pdf', 'PaymentOut_Controller@pdf');
    Route::get('getTemplateEmailToCustomerPaymentOut/{resolution_id}', 'PaymentOut_Controller@getTemplateEmailToCustomer');

    //Contacts
    Route::resource('contact', 'ContactsController');
    Route::get('getContactlist/{filter}','ContactsController@ContactIndex');
    Route::get('getContactReports/{process_type}/{contact_id}', 'ContactsController@getContactReports');
    //Route::post('sendEmailToContact','ContactsController@sendEmailToContact');

    //Seller
    Route::resource('seller', 'SellerController');

    //profile
    Route::resource('profile', 'ProfileController');

    //Company
    Route::resource('account', 'AccountController');

    //Resolution
    Route::resource('resolution', 'ResolutionController');
    Route::get('resolutionAll','ResolutionController@resolutionAll');
    Route::put('resolution_update_state/{req}','ResolutionController@update_state');
    Route::put('update_numeration/{req}','ResolutionController@update_numeration');

    //payment terms
    Route::resource('payterms', 'PaymentTermsController');
    Route::get('getPaymentTermsList','PaymentTermsController@getPaymentTermsList');

    //Retentions
    Route::resource('retention', 'RetentionController');
    Route::get('getRetentionList','RetentionController@getRetentionList');

    //taxes
    Route::resource('taxes', 'TaxesController');
    Route::get('getTaxesList','TaxesController@getTaxesList');

    //dashboard
    Route::get('getDashboardInfo','AppController@getDashboardInfo');
    
    //Category
    Route::resource('category', 'CategoryController');
    Route::get('getCategoryIncome','CategoryController@CategoryIncome');
    Route::get('getCategoryAll','CategoryController@CategoryAll');

    //Inventory
    Route::resource('inventory', 'InventoryController');
    Route::get('getInventorylist','InventoryController@InventoryIndex');
    Route::get('getInventoryReports/{process_type}/{product_id}', 'InventoryController@getInventoryReports');


    //enviar documentos adjuntos por correos
    Route::post('sendEmailToContact', 'ContactsController@sendEmailToContact');

    //Upload documents
    Route::get('getDocuments/{id}/{model}', 'UploadController@getDocuments');
    Route::delete('deleteDocuments/{id}', 'UploadController@delete');
    Route::get('downloadDocuments/{id}', 'UploadController@download');
    Route::post('document', 'UploadController@uploadDocument');

    //Bank accounts
    Route::resource('bank', 'BankAccountController');
    Route::get('getBankAccount_Type','BankAccountController@BaseInfo');
    Route::get('getBankAccountlist','BankAccountController@BankAccountIndex');
    Route::get('getBankList','BankAccountController@bankList');
    Route::get('getbank_transaction_history/{bank_id}','BankAccountController@bank_transaction_history');
    Route::post('saveBankTransference','BankAccountController@CreateBankTransference');

});

Route::group(['middleware' => 'guest:api'], function () {
    Route::post('login', 'Auth\LoginController@login');
    Route::post('register', 'Auth\RegisterController@register');
    Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail');
    Route::post('password/reset', 'Auth\ResetPasswordController@reset');
});

define('CURRENCY_CODE_DEFAULT', 'COP');

define('PAYMENT_LOCAL_VIEW_EVENT_OUT','/payment-out/');
define('PAYMENT_LOCAL_VIEW_OUT','payment-out');
define('PAYMENT_LOCAL_VIEW_EVENT_IN','/payment-in/');
define('PAYMENT_LOCAL_VIEW_IN','payment-in');

define('PAYMENT_INCOME_TYPE', 'in');
define('PAYMENT_OUTCOME_TYPE', 'eg');

define('CATEGORY_TYPE_INCOME', 1);
define('CATEGORY_TYPE_OUTCOME', 2);
define('CATEGORY_TYPE_ASSETS', 3); //ACTIVOS
define('CATEGORY_TYPE_LIABILITIES',4); //pasivos
define('CATEGORY_TYPE_PATRIMONY',5);
define('CATEGORY_TYPE_TRANSFERENCE',6);

define('CONTACT_IS_PROVIDER','p');
define('CONTACT_IS_CUSTOMER','c');
define('CONTACT_IS_SELLER','s');

define('INVOICE_STATUS_OPEN', 1);
define('INVOICE_STATUS_VOIDED', 2);//=>NULL
define('INVOICE_STATUS_APPROVED', 3);
define('INVOICE_STATUS_PAID',4);
define('INVOICE_STATUS_DRAFT', 5);
define('INVOICE_STATUS_CLOSE', 6);
define('INVOICE_STATUS_SENT', 7);

define('BILL_STATUS_OPEN', 1);
define('BILL_STATUS_VOIDED', 2);
define('BILL_STATUS_APPROVED', 3);
define('BILL_STATUS_PAID',4);
define('BILL_STATUS_DRAFT', 5);
define('BILL_STATUS_CLOSE', 6);
define('BILL_STATUS_SENT', 7);

define('PAYMENT_STATUS_APPLIED', 1);
define('PAYMENT_STATUS_VOIDED', 2);
define('PAYMENT_STATUS_RETURNED', 3);
define('PAYMENT_STATUS_COMPLETE',4);