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
            name: "product",
            label: "Producto",
            field: "product",
            format(value) {
                return value.name;
            },
            align: 'left'
        },
        {
            name: "unit_price",
            label: "Precio",
            field: "unit_price",
            format(value) {
                return accounting.formatMoney(value);
            },
        },
        {
            name: "quantity",
            label: "Cantidad",
            field: "quantity",
        },
        {
            name: "discount",
            label: "Descuento (%)",
            field: "discount",
        },
        {
            name: "tax_amount",
            label: "Impuesto (%)",
            field: "tax_amount",
        },
        {
            name: "total",
            label: "Total",
            field: "total",
            format(value) {
                return accounting.formatMoney(value);
            },
        }
    ];
}