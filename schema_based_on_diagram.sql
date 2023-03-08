
CREATE TABLE patients (
    id serial PRIMARY KEY,
    name VARCHAR(100),
    date_of_birth DATE,

);

-- invoice table

CREATE TABLE invoices (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL(10, 2),
    generate_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

-- MEDICAL_HISTORY

CREATE TABLE medical_histories (
    id serial PRIMARY KEY,
    admitted_at TIMESTAMP,
    status VARCHAR(100),
    patient_id INT REFERENCES patients(id)
);

-- invoice_items table

CREATE TABLE invoice_items (
    id serial PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);

-- treatment table

CREATE TABLE treatments (
    id serial PRIMARY KEY,
    type VARCHAR(100),
    name VARCHAR(100)
);

-- many to many relationship

CREATE TABLE patient_invoice (
    patient_id INT REFERENCES patients(id),
    invoice_id INT REFERENCES invoices(id),
    PRIMARY KEY (patient_id, invoice_id)
);

CREATE TABLE medical_history_treatment (
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE TABLE invoice_item_treatment (
    invoice_item_id INT REFERENCES invoice_items(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY (invoice_item_id, treatment_id)
);



