export default function indexColumns(_module) {
    
    if (_module === "estimate") {
        return estimateColumns();
    } else if (_module === "remision") {
        return remisionColumns();
    } else if (_module === "invoice") {
        return invoiceColumns();
    } else if (_module === "purchase-order") {
        return poColumns();
    } else if (_module === "bill") {
        return billColumns();
    } else if (_module === "credit-note") {
        return creditNoteColumns();
    } else if (_module === "debit-note") {
        return debitNoteColumns();
    } else if (_module === "payment-in") {
        return paymentInColumns();
    } else if (_module === "payment-out") {
        return paymentOutColumns();
    }
}


function estimateColumns() {
    return [{
            label: "No",
            field: "public_id",
            sortable: true,
            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            sort(a) {
                return a.name;
            },
            format(value) {
                return value.name;
            },
            filter: true,
            type: "string"
        },
        {
            label: "Creación",
            field: "created_at",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Actualización",
            field: "updated_at",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Total",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string"
        },
        {
            label: "Acciones",
            field: "actions",
            sortable: false,
            filter: false
        }
    ];
}

function remisionColumns() {
    return [{
            label: "No",
            field: "public_id",
            width: "35px",
            sort: true,
            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            sort(a) {
                return a.name;
            },
            format(value) {
                return value.name;
            },
            filter: true,
            width: "140px",
            type: "string"
        },
        {
            label: "Creación",
            field: "created_at",
            width: "80px",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Vence en",
            field: "due_date",
            width: "80px",
            sort(a, b) {
                return new Date(a.due_date) - new Date(b.due_date);
            },
            format(value) {
                return moment(value.due_date).format("MMMM Do YYYY");
            },
            filter: true
        },
        {
            label: "Estado",
            field: "status_id",
            width: "60px",
            sort: true,
            filter: true
        },
        {
            label: "Total",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "80px"
        },
        {
            label: "Acciones",
            field: "actions",
            sort: false,
            filter: false,
            width: "150px"
        }
    ];
}

function debitNoteColumns() {
    return [{
            label: "No",
            field: "public_id",
            width: "40px",
            sort: true,

            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            sort(a) {
                return a.name;
            },
            format(value) {
                return value.name;
            },
            filter: true,
            width: "150px",
            type: "string"
        },
        {
            label: "Creación",
            field: "created_at",
            width: "80px",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Actualización",
            field: "updated_at",
            width: "80px",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Total",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "70px"
        },
        {
            label: "Por aplicar",
            field: "amount_pending_to_apply",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "70px"
        },
        {
            label: "Acciones",
            field: "actions",
            sort: false,
            filter: false,
            width: "100px"
        }
    ];
}

function creditNoteColumns() {
    return [{
            label: "No",
            field: "public_id",
            width: "40px",
            sort: true,

            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            sort(a) {
                return a.name;
            },
            format(value) {
                return value.name;
            },
            filter: true,
            width: "150px",
            type: "string"
        },
        {
            label: "Creación",
            field: "created_at",
            width: "80px",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Actualización",
            field: "updated_at",
            width: "80px",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Total",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "70px"
        },
        {
            label: "Por aplicar",
            field: "amount_pending_to_apply",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "70px"
        },
        {
            label: "Acciones",
            field: "actions",
            sort: false,
            filter: false,
            width: "100px"
        }
    ];
}

function paymentInColumns() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            name: "contact",
            sortable: true,
            filter: true,
            type: "string"
        },
        {
            label: "Asociado a",
            field: "IsCategory",
            name: "IsCategory",
            sortable: true,
            filter: true,
            format(value) {
                if (value === 0) {
                    return "Factura de venta";
                }
                return "Categoría";
            },
        },
        {
            label: "Fecha",
            field: "date",
            name: "date",
            sortable: true,
            format(value) {
                return moment(value).format("MMMM Do YYYY");
            },
            filter: true
        },
        {
            label: "Cuenta",
            field: "bank_account_name",
            name: "bank_account_name",
            sortable: true,
            filter: true,
            type: "string"
        },
        {
            label: "Estado",
            field: "status_id",
            name: "status_id",
            sortable: true,
            filter: true
        },
        {
            label: "Monto",
            field: "total",
            name: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        },
        {
            label: "Acciones",
            field: "actions",
            name: "actions",
            sortable: false,
            filter: false,
        }
    ];
}

function paymentOutColumns() {
    return [{
            label: "No",
            field: "public_id",
            width: "40px",
            sort: true,

            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            sort: true,
            filter: true,
            width: "110px",
            type: "string"
        },
        {
            label: "Tipo de proceso",
            field: "IsCategory",
            sort: true,
            filter: true,
            format(value) {
                if (value === 0) {
                    return "Factura de compra";
                }
                return "Categoría";
            },
            width: "130px"
        },
        {
            label: "Fecha",
            field: "date",
            width: "90px",
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
            format(value) {
                return moment(value).format("MMMM Do YYYY");
            },
            filter: true
        },
        {
            label: "Cuenta",
            field: "payment_method",
            sort: true,
            filter: true,
            width: "100px",
            type: "string"
        },
        {
            label: "Estado",
            field: "status_id",
            width: "60px",
            sort: true,
            filter: true
        },
        {
            label: "Monto",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "70px"
        },
        {
            label: "Acciones",
            field: "actions",
            sort: false,
            filter: false,
            width: "170px"
        }
    ];
}

function invoiceColumns() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            type: "text",
            align: 'left'
        },
        {
            label: "Cliente",
            field: "contact_name",
            name: "contact_name",
            sortable: true,
            type: "string",
            align: 'left'
        },
        {
            label: "Creación",
            field: "created_at",
            name: "created_at",
            sortable: true,
            format: val => moment(val.due_date).format("MMMM Do YYYY")
        },
        {
            label: "Vence en",
            field: "due_date",
            name: "due_date",
            sortable: true,
            format: val => moment(val.due_date).format("MMMM Do YYYY")
        },
        {
            label: "Estado",
            field: "status_id",
            name: "status_id",
            sortable: true
        },
        {
            label: "Total",
            field: "total",
            name: "total",
            sortable: true,
            type: "string",
            format: val => accounting.formatMoney(val),
            align: 'right'
        },
        {
            label: "Pagado",
            field: "total_payed",
            name: "total_payed",
            sortable: true,
            type: "string",
            format: val => accounting.formatMoney(val),
            align: 'right'
        },
        {
            label: "Por Pagar",
            field: "pending_to_pay",
            name: "pending_to_pay",
            sortable: true,
            type: "string",
            format: val => accounting.formatMoney(val),
            align: 'right'
        },
        {
            label: "Acciones",
            field: "actions",
            name: "actions",
            sortable: false,
        }
    ];
}

function billColumns() {
    return [{
            label: "No",
            field: "public_id",
            width: "35px",
            sort: true,
            filter: true,
            type: "text"
        },
        {
            label: "Proveedor",
            field: "contact_name",
            sort: true,
            filter: true,
            width: "120px",
            type: "string"
        },
        {
            label: "Creación",
            field: "created_at",
            width: "80px",
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
            format(value) {
                return moment(value).fromNow();
            },
            filter: true
        },
        {
            label: "Vence en",
            field: "due_date",
            width: "80px",
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
            format(value) {
                return moment(value).format("MMMM Do YYYY");
            },
            filter: true
        },
        {
            label: "Estado",
            field: "status_id",
            width: "60px",
            sort: true,
            filter: true
        },
        {
            label: "Total",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "80px"
        },
        {
            label: "Pagado",
            field: "total_payed",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "80px"
        },
        {
            label: "Por Pagar",
            field: "pending_to_pay",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "80px"
        },
        {
            label: "Acciones",
            field: "actions",
            sort: false,
            filter: false,
            width: "150px"
        }
    ];
}

function poColumns() {
    return [{
            label: "No",
            field: "public_id",
            width: "35px",
            sort: true,
            filter: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "contact",
            sort: true,
            format(value) {
                return value.name;
            },
            filter: true,
            width: "120px",
            type: "string"
        },
        {
            label: "Creación",
            field: "created_at",
            width: "80px",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value.date).fromNow();
            },
            filter: true
        },
        {
            label: "Estado",
            field: "status_id",
            width: "60px",
            sort: true,
            filter: true
        },
        {
            label: "Total",
            field: "total",
            filter: false,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            width: "80px"
        },
        {
            label: "Acciones",
            field: "actions",
            sort: false,
            filter: false,
            width: "150px"
        }
    ];
}