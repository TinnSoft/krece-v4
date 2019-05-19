<!DOCTYPE html>
<html>
<head>
    <title>{{$id_file}} </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  

    
  <style>     

@import url("https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700");
@import url("https://fonts.googleapis.com/css?family=Roboto:400,300,500,700");

    body {
    font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif; 
    }

    table.total th,  table.total td, table.total header {
        padding: 4px;
        text-align: right; 
        
    }
    table.total{
        float: right;
        font-size:70%;
    }
    table.detail th, table.detail td {
        border-bottom: 1px solid #ddd;
        padding: 5px;
        text-align: left;    
    }
    table {border-collapse: collapse;}

    .footer {
        background: none repeat scroll 0 0 white;       
        bottom: 0;
        left: 0;
        padding: 10px 20px;
        position: absolute;
        right: 0;
    }
    .text-muted {
        color: #888888;
        font-size: 70%;
        
    }

    .ibox {
        clear: both;
        margin-bottom: 25px;
        margin-top: 0;
        padding: 0;
    }
    span{
        font-size: 80%;
    }

    small{
        font-size: 70%;
    }
    .block {
    display: block;
    }

    .hr-line-solid {
    border-bottom: 1px solid #e7eaec;
    background-color: rgba(0, 0, 0, 0);
    border-style: solid !important;
    margin-top: 15px;
    margin-bottom: 15px;
    }
    .ibox-title  {
        -moz-border-bottom-colors: none;
        -moz-border-left-colors: none;
        -moz-border-right-colors: none;
        -moz-border-top-colors: none;
        background-color: #ffffff;
        border-color: #e7eaec;
        border-image: none;
        border-style: solid solid none;
        border-width: 2px 0 0;
        color: inherit;
        margin-bottom: 0;
        padding: 15px 15px 7px;
        min-height: 48px;
    }

    .text-navy {
        color: #1ab394;
    }

</style>

</head>
<body class="white-bg">  
        @yield('content')
         <div class="footer">                         
             <div align="center">             
               <small class="text-muted ">Documento generado en el sistema <strong> www.krece.co</strong></small>
             </div>
         </div>
</body>
</html>