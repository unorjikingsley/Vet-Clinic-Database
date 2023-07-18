CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name varchar(255),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(255)
);

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255),
);

-- To create a many to many relationship btw medical_histories(id) and treatment(id)
CREATE TABLE medical_history_treatments (
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL(10,2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL(10,2),
  quantity INT,
  total_price DECIMAL(10,2),
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatment(id), 
);