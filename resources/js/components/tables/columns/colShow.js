export default function columnsShow(_module) {
    if (_module === "outcome") {
        return OutcomeColumns();
    } else {
        return IncomeColumns();
    }
}


function OutcomeColumns() {
    return [{
            label: "Categoría",
            field: "category",
            format(value) {
                return value.name;
            },
            type: "text"
        },
        {
            label: "Precio",
            field: "unit_price",
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        },
        {
            label: "Cantidad",
            field: "quantity",
            type: "string"
        },
        {
            label: "Descuento",
            field: "discount",
            type: "string"
        },
        {
            label: "Impuesto",
            field: "tax_amount",
            type: "string"
        },
        {
            label: "Total",
            field: "total",
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        }
    ];
}

function IncomeColumns() {
    return [{
            label: "Producto",
            field: "product",
            format(value) {
                return value.name;
            },
            type: "text",
            align: 'left'
        },
        {
            label: "Precio",
            field: "unit_price",
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        },
        {
            label: "Cantidad",
            field: "quantity",
            type: "string"
        },
        {
            label: "Descuento (%)",
            field: "discount",
            type: "string"
        },
        {
            label: "Impuesto (%)",
            field: "tax_amount",
            type: "string"
        },
        {
            label: "Total",
            field: "total",
            format(value) {
                return accounting.formatMoney(value);
            },
            type: "string",
        }
    ];
}