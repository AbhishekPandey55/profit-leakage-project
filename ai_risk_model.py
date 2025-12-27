import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder

# Load data
df = pd.read_csv("vendor_risk_output.csv")

# Encode risk labels (High, Medium, Low -> numbers)
le = LabelEncoder()
df["risk_encoded"] = le.fit_transform(df["risk_level"])

# Features (input) and Target (output)
X = df[["profit"]]          # input
y = df["risk_encoded"]      # output

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42
)

# Train AI model
model = RandomForestClassifier(random_state=42)
model.fit(X_train, y_train)

# Accuracy
accuracy = model.score(X_test, y_test)
print("Model Accuracy:", accuracy)

# Predict risk for new profit value
new_profit = [[-15000]]
predicted_risk = model.predict(new_profit)

print("Predicted Risk Level:",
      le.inverse_transform(predicted_risk))


