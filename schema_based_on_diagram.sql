CREATE DATABASE clinic;

CREATE TABLE patients (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    date_of_birth DATE
);

CREATE TABLE medical_histories (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(50),
    admitted_at TIMESTAMP,
);
CREATE TABLE invoices (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL(10, 2),
    generate_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);
CREATE TABLE treatments (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    type VARCHAR(50)
);

CREATE TABLE medical_history_treatments (
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
    PRIMARY KEY (medical_history_id, treatment_id)
);