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