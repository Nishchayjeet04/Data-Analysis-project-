/*
**NAME    - Nishchayjeet Singh 
**PROJECT - Customer-Churn-Records 
**File    - Customer Churn cheatsheet
**History 
-- -------------------------------------------------------------------
 2024-11-20 Cheatsheet for customer churn project
            - steps used in python for building model.
	    - Working example of boxstore database JOINs Queries.  
*/
-- -------------------------------------------------------------------

-- Steps for python.  


-- Step 1 - importing the libraries and importing the data
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix, accuracy_score

-- load the data
df = pd.read_csv("C:/Users/14379/Desktop/bank customer data.xlsx")
df.head()  
-- Data Cleaning and Preprocessing
-- Check for missing values
df.isnull().sum()

-- Check for duplicates
df.duplicated().sum()

-- Data Preprocessing
--Convert necessary columns to the correct data types.
df['Geography'] = df['Geography'].astype('category')
df['Gender'] = df['Gender'].astype('category')
-- Drop or fill missing values 
df = df.dropna()

-- Used few filters to understand the data in detail and get a valuable insight.
1.)  Filtering out the data of the customers whose Balance > 10000( keeping the balance of 10000 is necerssary of the customer so all the customers whose 
                                                                    balance is less will be excludes from the list).
2.) Getting the data for male customer only. 
3.) Checking whether the customer has a credit card and a satisfaction score > 3

-- data visuals 


-- 1.) Histogram 
df.hist(bins=20, figsize=(12, 10))
plt.tight_layout()
plt.show() 

-- 2.) Box plots for outliers detection
sns.boxplot(data=df[['CreditScore', 'Age', 'Balance', 'Tenure', 'EstimatedSalary']])
plt.show()

-- 3.) Correlation heatmap
corr = df.corr()
numeric_df = df.select_dtypes(include=['number'])
corr = numeric_df.corr()
plt.figure(figsize=(10, 8))
sns.heatmap(corr, annot=True, cmap='coolwarm', fmt='.2f')
plt.show()

-- 4.) Churn rate visualization
sns.countplot(x='Exited', data=df)
plt.title('Customer Churn Distribution')
plt.show()

-- Churn vs. Geography and Gender
sns.countplot(x='Geography', hue='Exited', data=df)
plt.title('Churn by Geography')
plt.show()
sns.countplot(x='Gender', hue='Exited', data=df)
plt.title('Churn by Gender')
plt.show()

-- Feature engeering
df = pd.get_dummies(df, columns=['Geography', 'Gender'], drop_first=True)

scaler = StandardScaler()
df[['CreditScore', 'Age', 'Tenure', 'Balance', 'EstimatedSalary']] = scaler.fit_transform(df[['CreditScore', 'Age', 'Tenure', 'Balance', 'EstimatedSalary']])

-- Training, Validation, and Testing

# Attempt to drop the columns only if they exist
columns_to_drop = ['RowNumber', 'CustomerId', 'Surname']
existing_columns_to_drop = [col for col in columns_to_drop if col in df.columns]
print("Columns to drop:", existing_columns_to_drop)

# Drop only the existing columns
df = df.drop(columns=existing_columns_to_drop, axis=1)


-- Model evaluation 

import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import (
    confusion_matrix,
    classification_report,
    roc_curve,
    auc,
    precision_recall_curve,
    accuracy_score,
    f1_score,
    precision_score,
    recall_score
)

# Evaluate the model on the test set
y_test_pred = model.predict(X_test)
y_test_proba = model.predict_proba(X_test)[:, 1]  # Probability scores for the positive class
 
 
-- Summary 
print("\nSummary of Model Evaluation:")
print(f"Confusion Matrix:\n{conf_matrix}")
print(f"Accuracy: {accuracy:.4f}")
print(f"Precision: {precision:.4f}")
print(f"Recall: {recall:.4f}")
print(f"F1-Score: {f1:.4f}")
print(f"AUC: {roc_auc:.4f}")



-- --------------------------------------------------------------------

-- Boxstore Join Queries. 
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY,
    Surname VARCHAR(255),
    Geography VARCHAR(255),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance DECIMAL(15, 2),
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary DECIMAL(15, 2)
);

CREATE TABLE CreditInfo (
    CustomerId INT PRIMARY KEY,
    CreditScore INT,
    Balance DECIMAL(15, 2),
    EstimatedSalary DECIMAL(15, 2),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

-- Insert Data into the Customer Table
INSERT INTO Customer (CustomerId, Surname, Geography, Gender, Age, Tenure, Balance, NumOfProducts, HasCrCard, IsActiveMember, EstimatedSalary) 
VALUES
(15634602, 'Hargrave', 'France', 'Female', 42, 2, 0, 1, 1, 1, 101348.88),
(15647311, 'Hill', 'Spain', 'Female', 41, 1, 83807.86, 1, 0, 1, 112542.58),
(15619304, 'Onio', 'France', 'Female', 42, 8, 159660.8, 3, 1, 0, 113931.57),
(15701354, 'Boni', 'France', 'Female', 39, 1, 0, 2, 0, 0, 93826.63),
(15737888, 'Mitchell', 'Spain', 'Female', 43, 2, 125510.82, 1, 1, 1, 79084.1),
(15574012, 'Chu', 'Spain', 'Male', 44, 8, 113755.78, 2, 1, 0, 149756.71),
(15592531, 'Bartlett', 'France', 'Male', 50, 7, 0, 2, 1, 1, 10062.8),
(15656148, 'Obinna', 'Germany', 'Female', 29, 4, 115046.74, 4, 1, 0, 119346.88),
(15792365, 'He', 'France', 'Male', 44, 4, 142051.07, 2, 0, 1, 74940.5),
(15592389, 'H?', 'France', 'Male', 27, 2, 134603.88, 1, 1, 1, 71725.73),
(15767821, 'Bearce', 'France', 'Male', 31, 6, 102016.72, 2, 0, 0, 80181.12),
(15737173, 'Andrews', 'Spain', 'Male', 24, 3, 0, 2, 1, 0, 76390.01),
(15632264, 'Kay', 'France', 'Female', 34, 10, 0, 2, 1, 0, 26260.98),
(15691483, 'Chin', 'France', 'Female', 25, 5, 0, 2, 0, 0, 190857.79),
(15600882, 'Scott', 'Spain', 'Female', 35, 7, 0, 2, 1, 1, 65951.65),
(15643966, 'Goforth', 'Germany', 'Male', 45, 3, 143129.41, 2, 0, 1, 64327.26),
(15737452, 'Romeo', 'Germany', 'Male', 58, 1, 132602.88, 1, 1, 0, 5097.67),
(15788218, 'Henderson', 'Spain', 'Female', 24, 9, 0, 2, 1, 1, 14406.41);

-- Insert Data into CreditInfo Table 
INSERT INTO CreditInfo (CustomerId, CreditScore, Balance, EstimatedSalary)
VALUES
(15634602, 619, 0, 101348.88),
(15647311, 608, 83807.86, 112542.58),
(15619304, 502, 159660.8, 113931.57),
(15701354, 699, 0, 93826.63),
(15737888, 850, 125510.82, 79084.1),
(15574012, 645, 113755.78, 149756.71),
(15592531, 822, 0, 10062.8),
(15656148, 376, 115046.74, 119346.88),
(15792365, 501, 142051.07, 74940.5),
(15592389, 684, 134603.88, 71725.73),
(15767821, 528, 102016.72, 80181.12),
(15737173, 497, 0, 76390.01),
(15632264, 476, 0, 26260.98),
(15691483, 549, 0, 190857.79),
(15600882, 635, 0, 65951.65),
(15643966, 616, 143129.41, 64327.26),
(15737452, 653, 132602.88, 5097.67),
(15788218, 549, 0, 14406.41);

-- Join query (Customer and CreditInfo tables)
SELECT c.CustomerId, c.Surname, c.Geography, c.Gender, ci.CreditScore, ci.Balance, ci.EstimatedSalary
FROM Customer c
JOIN CreditInfo ci ON c.CustomerId = ci.CustomerId;

-- Inner Join Between Customer and CreditInfo
SELECT c.CustomerId, c.Surname, c.Geography, c.Gender, ci.CreditScore, ci.Balance, ci.EstimatedSalary
FROM Customer c
INNER JOIN CreditInfo ci ON c.CustomerId = ci.CustomerId
WHERE ci.Balance > 10000;

--  Right Join to Include All Credit Info Records and Corresponding Customers
SELECT c.CustomerId, c.Surname, c.Geography, c.Gender, ci.CreditScore, ci.Balance, ci.EstimatedSalary
FROM Customer c
RIGHT JOIN CreditInfo ci ON c.CustomerId = ci.CustomerId;


