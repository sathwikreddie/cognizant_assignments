-- Enable output for DBMS_OUTPUT
SET SERVEROUTPUT ON;


-- 1. Create Tables


-- Drop tables if they already exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE accounts';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Create accounts table
CREATE TABLE accounts (
  account_id     NUMBER PRIMARY KEY,
  balance        NUMBER(10, 2),
  account_type   VARCHAR2(20)
);

-- Create employees table
CREATE TABLE employees (
  employee_id    NUMBER PRIMARY KEY,
  department_id  NUMBER,
  salary         NUMBER(10, 2)
);


-- 2. Insert Sample Data


-- Accounts
INSERT INTO accounts VALUES (1001, 5000.00, 'SAVINGS');
INSERT INTO accounts VALUES (1002, 3000.00, 'SAVINGS');
INSERT INTO accounts VALUES (1003, 10000.00, 'CURRENT');

-- Employees
INSERT INTO employees VALUES (201, 10, 40000);
INSERT INTO employees VALUES (202, 10, 42000);
INSERT INTO employees VALUES (203, 20, 45000);

COMMIT;


-- 3. Procedure 1: ProcessMonthlyInterest

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  UPDATE accounts
  SET balance = balance + (balance * 0.01)
  WHERE account_type = 'SAVINGS';
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Monthly interest applied to savings accounts.');
END;
/

-- Execute
EXEC ProcessMonthlyInterest;


-- 4. Procedure 2: UpdateEmployeeBonus
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  dept_id        IN NUMBER,
  bonus_percent  IN NUMBER
) IS
BEGIN
  UPDATE employees
  SET salary = salary + (salary * bonus_percent / 100)
  WHERE department_id = dept_id;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Bonus applied to department ' || dept_id || '.');
END;
/

-- Execute (e.g., 10% bonus for department 10)
EXEC UpdateEmployeeBonus(10, 10);


-- 5. Procedure 3: TransferFunds

CREATE OR REPLACE PROCEDURE TransferFunds (
  from_account_id IN NUMBER,
  to_account_id   IN NUMBER,
  amount          IN NUMBER
) IS
  insufficient_balance EXCEPTION;
  current_balance NUMBER;
BEGIN
  -- Get current balance of the source account
  SELECT balance INTO current_balance
  FROM accounts
  WHERE account_id = from_account_id
  FOR UPDATE;

  IF current_balance < amount THEN
    RAISE insufficient_balance;
  END IF;

  -- Deduct from source
  UPDATE accounts
  SET balance = balance - amount
  WHERE account_id = from_account_id;

  -- Add to destination
  UPDATE accounts
  SET balance = balance + amount
  WHERE account_id = to_account_id;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transfer successful.');
EXCEPTION
  WHEN insufficient_balance THEN
    DBMS_OUTPUT.PUT_LINE('Transfer failed: insufficient funds.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Transfer failed due to unexpected error.');
    ROLLBACK;
END;
/

-- Execute (transfer 2000 from 1001 to 1002)
EXEC TransferFunds(1001, 1002, 2000);


-- View updated balances
SELECT * FROM accounts;

-- View updated salaries
SELECT * FROM employees;
