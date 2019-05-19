export default function Movements_Cols(_module) {

    if (_module === "estimate") {
        return Estimate_Cols();
    } else if (_module === "remision") {
        return Remision_Cols();
    } else if (_module === "invoice") {
        return invoice_Cols();
    } else if (_module === "po") {
        return Po_Cols();
    } else if (_module === "bill") {
        return Bill_Cols();
    } else if (_module === "credit_note") {
        return CreditNote_Cols();
    } else if (_module === "debit_note") {
        return DebitNote_Cols();
    }
}

function Bill_Cols() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            type: "text"
        },
        {
            label: "Proveedor",
            field: "name",
            name: "name",
            sortable: true,
            type: "string"
        },
        {
            label: "Creación",
            field: "date",
            name: "date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
            format(value) {
                return moment(value).fromNow();
            },
        },
        {
            label: "Vence en",
            field: "due_date",
            name: "due_date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
            format(value) {
                return moment(value).format("MMMM Do YYYY");
            },
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
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            sortable: true,
            type: "string",
        },
        {
            label: "Pagado",
            field: "total_payed",
            name: "total_payed",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string"
        },
        {
            label: "Por Pagar",
            field: "pending_to_pay",
            name: "pending_to_pay",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        }
    ];
}

function CreditNote_Cols() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",           
            sortable: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "name",
            name: "name",
            sortable: true,
            sort(a) {
                return a;
            },
            type: "string"
        },
        {
            label: "Creación",
            field: "date",
            name: "date",
            sortable: true,
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value).fromNow();
            },
        },
        {
            label: "Total",
            field: "total",
            name: "total",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string"
        },
        {
            label: "Por aplicar",
            field: "total",
            name: "total2",
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string"
        }
    ];
}

function DebitNote_Cols() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "name",
            name: "name",
            sort(a) {
                return a;
            },
            sortable: true,
            type: "string"
        },
        {
            label: "Creación",
            field: "date",
            name: "date",
            sort(a, b) {
                return new Date(a.date) - new Date(b.date);
            },
            format(value) {
                return moment(value).fromNow();
            },
            sortable: true,
        },
        {
            label: "Total",
            field: "total",
            name: "total",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string"
        },
        {
            label: "Por aplicar",
            field: "total",
            name: "total2",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string"
        }
    ];
}

function Estimate_Cols() {
    return [{
            label: "No",
            name: "public_id",
            field: "public_id",
            sortable: true,
        },
        {
            label: "Cliente",
            name: "name",
            field: "name",
            sortable: true,
        },
        {
            label: "Creación",
            name: "date",
            field: "date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
        },
        {
            label: "Vence en",
            name: "due_date",
            field: "due_date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
        },
        {
            label: "Total",
            name: "total",
            field: "total",
            sortable: true,
            format(value) {
                return accounting.formatMoney(value);
            },
        }
    ];
}

function invoice_Cols() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "name",
            name: "name",
            sortable: true,
            type: "text"
        },
        {
            label: "Fecha",
            field: "date",
            name: "date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            }
        },
        {
            label: "Vencimiento",
            field: "due_date",
            name: "due_date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            }
        },
        {
            label: "Total",
            field: "total",
            name: "total",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        },
        {
            label: "Pagado",
            field: "total_payed",
            name: "total_payed",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        },
        {
            label: "Por Pagar",
            field: "pending_to_pay",
            name: "pending_to_pay",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        },
        {
            label: "Estado",
            field: "status_id",
            name: "status_id",
            sortable: true
        }
    ];
}

function Po_Cols() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "name",
            name: "name",
            sortable: true,
            type: "string"
        },
        {
            label: "Fecha",
            field: "date",
            name: "date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            },
        },
        {
            label: "Fecha de Entrega",
            field: "due_date",
            name: "due_date",
            sortable: true,
            sort(a, b) {
                return new Date(a) - new Date(b);
            }
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
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
            sortable: true
        }
    ];
}

function Remision_Cols() {
    return [{
            label: "No",
            field: "public_id",
            name: "public_id",
            sortable: true,
            type: "text"
        },
        {
            label: "Cliente",
            field: "name",
            name: "name",
            sortable: true,
            sort(a) {
                return a;
            },
            type: "string"
        },
        {
            label: "Creación",
            field: "date",
            name: "date",
            sort(a, b) {
                return new Date(date) - new Date(date);
            },
            sortable: true,
        },
        {
            label: "Vence en",
            field: "due_date",
            name: "due_date",
            sort(a, b) {
                return new Date(a.due_date) - new Date(b.due_date);
            },
            sortable: true,
        },
        {
            label: "Estado",
            field: "status_id",
            name: "status_id",
            sortable: true,
        },
        {
            label: "Total",
            field: "total",
            name: "total",
            sortable: true,
            sort(t) {
                return t;
            },
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        }
    ];
}