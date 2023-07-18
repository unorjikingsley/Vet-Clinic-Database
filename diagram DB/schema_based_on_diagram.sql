CREATE TABLE patients (
  id SERIAL NOT NULL PRIMARY KEY,
  name varchar(255),
  date_of_birth DATE
);

CREATE TABLE medical_histories (
  id SERIAL NOT NULL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(255)
  -- INDEX fk_medical_histories_patients_idx (patient_id);
);

CREATE TABLE treatments (
  id SERIAL NOT NULL PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255),
);

-- To create a many to many relationship btw medical_histories(id) and treatment(id) line 53 same thing
CREATE TABLE medical_history_treatments (
  -- id SERIAL PRIMARY KEY,
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE TABLE invoices (
  id SERIAL NOT NULL PRIMARY KEY,
  total_amount DECIMAL(10,2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT NOT NULL 
    UNIQUE(medical_history_id),
    FOREIGN KEY (medical_history_id) 
    REFERENCES medical_histories(id)
  -- INDEX fk_invoices_medical_histories_idx (medical_history_id) line 54 same thing
);

CREATE TABLE invoice_items (
  id SERIAL NOT NULL PRIMARY KEY,
  unit_price DECIMAL(10,2),
  quantity INT,
  total_price DECIMAL(10,2),
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatment(id)
  -- INDEX fk_invoice_items_invoices_idx (invoice_id) line 55 same thing
  -- INDEX fk_invoice_items_treatments_idx ON invoice_items (treatment_id) line 56 same thing
);

-- Add foreign key indexes
CREATE INDEX fk_medical_histories_patients_idx ON medical_histories (patient_id);
CREATE INDEX fk_invoices_medical_histories_idx ON invoices (medical_history_id);
CREATE INDEX fk_invoice_items_invoices_idx ON invoice_items (invoice_id);
CREATE INDEX fk_invoice_items_treatments_idx ON invoice_items (treatment_id);
