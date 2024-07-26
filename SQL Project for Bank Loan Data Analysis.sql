CREATE DATABASE Project;

USE Project;

SELECT * FROM Finance;
SELECT * FROM Finance_2;


                                    #     1.YEARWISE LOAN AMOUNT STATS    #
                                    
SELECT
    YEAR(issue_d) AS loan_year,
    COUNT(*) AS total_loans,
    SUM(loan_amnt) AS total_loan_amount,
    AVG(loan_amnt) AS average_loan_amount,
    MIN(loan_amnt) AS min_loan_amount,
    MAX(loan_amnt) AS max_loan_amount
FROM
    Finance
GROUP BY
    YEAR(issue_d)
ORDER BY
    YEAR(issue_d);    



                               #          2.GRADE AND SUBGRADE WISE REVOL_BAL       #
                               
SELECT 
    Finance.Grade,
    Finance.Sub_grade,
    SUM(Finance_2.revol_bal) AS 'Total Revol Bal'
FROM 
    Finance
JOIN 
    Finance_2 ON Finance.id = Finance_2.id
GROUP BY 
    Finance.Grade, Finance.Sub_grade
ORDER BY 
    Finance.Grade, Finance.Sub_grade;
    
    
    
    
								  #        3.TOTAL PAYMENT FOR VERIFIED STATUS Vs TOTAL PAYMENT FOR NON-VERIFIED STATUS      #
                                  
SELECT
		Finance.Verification_status, ROUND(SUM(Finance_2.total_pymnt)) AS 'Total Payment'
		FROM Finance JOIN Finance_2 ON Finance.id = Finance_2.id
		WHERE Finance.verification_status IN ('Verified', 'Not Verified')
		GROUP BY Finance.verification_status;


                                    #          4.STATEWISE AND LAST_CREDIT_PULL_D WISE LOAN STATUS        #
                                    
SELECT
    addr_state,
    last_credit_pull_d,
    loan_status,
    COUNT(*) AS total_loans
FROM
    Finance JOIN Finance_2 ON Finance.id = Finance_2.id
GROUP BY
    addr_state,
    last_credit_pull_d,
    loan_status
ORDER BY
    addr_state,
    last_credit_pull_d;


                              #           5.HOME OWNERSHIP Vs LAST PAYMENT DATE STATS        #
                              
SELECT
          YEAR(Finance_2.last_pymnt_d) AS 'Years', Finance.home_ownership,ROUND(SUM(Finance_2.last_pymnt_amnt)) AS 'Total_Payment'
		  FROM Finance 
		  JOIN Finance_2 
          ON Finance.id = Finance_2.id
          WHERE Finance.home_ownership IN ('RENT', 'MORTGAGE', 'OWN')
		  GROUP BY Finance.home_ownership, years
		  HAVING ROUND(SUM(Finance_2.last_pymnt_amnt)) != 0
		  ORDER BY YEAR(Finance_2.last_pymnt_d), ROUND(SUM(Finance_2.last_pymnt_amnt)) DESC;
          