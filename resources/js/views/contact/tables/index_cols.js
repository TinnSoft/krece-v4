export default function _contactIndexColumns(_module) {

    if (_module === "client" || _module === "provider") {
        return clientColumns();
    } else if (_module === "seller") {
        return sellerColumns();
    }
}

function clientColumns() {
    return [{
            label: "Nombre",
            field: "name",
            name: "name",
            align: "left",
            sortable: true,
            type: "string"
        },
        {
            label: "Nit",
            field: "nit",
            name: "nit",
            sortable: true
        },
        {
            label: "Teléfono",
            field: "phone_mobile",
            name: "phone_mobile",
            sortable: true
        },
        {
            label: "Observaciones",
            field: "observation",
            name: "observation",
            sortable: true,
            type: "string"
        },
        {
            label: "Acciones",
            field: "actions",
            name: "actions",
            type: "string",
            sortable: true
        }
    ];
}

function sellerColumns() {
    return [{
            label: "Nombre",
            field: "name",
            name: "name",
            align: "left",
            sortable: true,
            type: "string"
        },
        {
            label: "Identificación",
            field: "dni",
            name: "dni",
            sortable: true
        },
        {
            label: "Teléfono de trabajo",
            field: "work_phone",
            name: "work_phone",
            sortable: true
        },
        {
            label: "Teléfono privado",
            field: "private_phone",
            name: "private_phone",
            sortable: true
        },
        {
            label: "Observaciones",
            field: "observations",
            name: "observations",
            type: "string",
            sortable: true
        },
        {
            label: "Acciones",
            field: "actions",
            name: "actions",
            type: "string",
            sortable: true
        }
    ];
}