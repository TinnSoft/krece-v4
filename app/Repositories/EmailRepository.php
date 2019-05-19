<?php

namespace App\Repositories;
use Auth;
use App\Models\Account;
use App\Models\Contact;
use Illuminate\Support\Facades\DB;
use App\Contracts\IEmailRepository;
use App\Utilities\Helper;
use Carbon\Carbon;

class EmailRepository implements IEmailRepository
{
    public function TemplateEmailToCustomer($model, $id)
        {
            $_text1=null;
            $_text2=null;

            switch (class_basename($model))
            {
                case 'Estimate'; //estimate
                    $_text1='la cotización # ';
                    $_text2='Cotización # ';
                    break;

                case 'InvoiceSaleOrder'; //Invoice
                    $_text1='la factura de venta # ';
                    $_text2='Factura de venta # ';
                    break; 

                case 'CreditNote'; 
                    $_text1='la nota crédito # ';
                    $_text2='Nota Crédito # ';
                    break;    

                case 'Remision'; 
                    $_text1='la remisión # ';
                    $_text2='Remisión # ';
                    break; 

                case 'PurchaseOrder'; 
                    $_text1='la órden de compra # ';
                    $_text2='Órden de Compra # ';
                    break;   

                case 'Payment'; 
                    $kindOfProcess=$model::where('account_id',Auth::user()->account_id)->where('resolution_id',$id)->select('type_id')->first()['type_id'];
                    if ($kindOfProcess=='in')
                    {
                        $_text1='el recibo de caja # ';
                        $_text2='Recibo de caja # ';
                    }
                    else{
                        $_text1='el comprobante de egreso # ';
                        $_text2='Comprobante de egreso # ';
                    }
                    break;           
                    
            };

            $document_date=Carbon::parse($model::where('resolution_id',$id)
                                        ->where('isDeleted',0)
                                        ->select('date')->first()->date)
                                    ->toFormattedDateString();
                                   

            $accountDetail=Account::where('id',Auth::user()->id)->select('email','phone','name')->first();

            $customerInfo=$model::where('resolution_id',$id)
            ->where('isDeleted',0)->select('customer_id')->first();
            
            $to='';
            if ($customerInfo->customer_id)
            {
                $to=Contact::where('id',$customerInfo->customer_id)
                ->select('email')->first()->email;
            }

            $subject=$_text2.$id;

            $body='Cordial saludo, <br/><br/>';
            $body .= 'En este correo adjuntamos '.$_text1.$id.' con fecha '.$document_date;
            $body .='. Agradecemos por utilizar los servicios de '.$accountDetail->name.' .';
            $body .= '<br/>';
            $body .= 'Cualquier inquietud le atenderemos en el teléfono '.$accountDetail->phone.'.';
            $body .= '<br/><br/>';
            $body .= 'Si desea reportar alguna novedad, por favor hacerlo al correo: '.$accountDetail->email;
            $body .= '<br/><br/>';
            $body .= 'Cordialmente,';
            $body .= '<br/><br/>';
            $body .= $accountDetail->name;
            $body .= '<br/>';

            
            $additional_emails='';

            $emailTemplate=[
                'to'=>$to,
                'subject'=>$subject,
                'body'=>$body,
                'additional_emails'=>$additional_emails
            ];

            return $emailTemplate;
        }
}