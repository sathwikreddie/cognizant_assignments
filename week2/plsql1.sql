-- Create Customers table
CREATE TABLE customers (
    customer_id     NUMBER PRIMARY KEY,
    first_name      VARCHAR2(50),
    last_name       VARCHAR2(50),
    age             NUMBER,
    balance         NUMBER(10, 2),
    isvip           VARCHAR2(5) DEFAULT 'FALSE'
);

-- Create Loans table
CREATE TABLE loans (
    loan_id         NUMBER PRIMARY KEY,
    customer_id     NUMBER,
    interest_rate   NUMBER(5, 2),
    due_date        DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
-- Insert into customers
INSERT INTO customers VALUES (1, 'John', 'Doe', 65, 15000, 'FALSE');
INSERT INTO customers VALUES (2, 'Jane', 'Smith', 45, 8000, 'FALSE');
INSERT INTO customers VALUES (3, 'Raj', 'Kumar', 61, 12000, 'FALSE');
INSERT INTO customers VALUES (4, 'Anita', 'Verma', 30, 9500, 'FALSE');

-- Insert into loans
INSERT INTO loans VALUES (101, 1, 10.5, SYSDATE + 20);
INSERT INTO loans VALUES (102, 2, 9.0, SYSDATE + 40);
INSERT INTO loans VALUES (103, 3, 11.0, SYSDATE + 10);
INSERT INTO loans VALUES (104, 4, 8.5, SYSDATE + 5);
COMMIT;




BEGIN
  FOR cust IN (SELECT customer_id, loan_id, interest_rate, age 
               FROM customers 
               JOIN loans ON customers.customer_id = loans.customer_id) 
  LOOP
    IF cust.age > 60 THEN
      UPDATE loans
      SET interest_rate = interest_rate - 1
      WHERE loan_id = cust.loan_id;
    END IF;
  END LOOP;
  COMMIT;
END;
/
