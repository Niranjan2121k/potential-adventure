
# **Homicide Data Analysis: A Comprehensive Study**

## **1. Introduction**
Homicides remain a critical global issue, influencing policies, law enforcement strategies, and public safety measures. 
This project aims to analyze homicide trends using real-world data, identifying patterns related to geography, demographics, and weapon usage.

### **Objectives:**
- Understand how homicide rates have changed over time.
- Analyze geographic distribution to find high-risk areas.
- Identify demographic factors influencing homicide trends.
- Examine relationships between victims and perpetrators.

---

## **2. Data Collection and Cleaning**
### **Dataset Used**
- **Source**: `homicide_by_countries.csv`
- **Key Columns**: 
  - `Location` (Country/Region)
  - `Year`
  - `Count` (Total Homicides)
  - `Rate` (Per 100,000 people)
  - `Weapon Used`
  - `Victim Details` (Age, Gender, Relationship to Perpetrator)

### **Data Cleaning Steps:**
- **Checked Missing Values**: Handled null values appropriately.
- **Data Type Corrections**: Converted numerical fields to appropriate types.
- **Standardized Region Names**: Corrected inconsistencies in country/region names.

---

## **3. Exploratory Data Analysis (EDA)**

### **3.1 Trends Over Time**
- Homicide rates analyzed over the years using line plots.
- Certain years exhibit spikes due to conflicts or policy changes.

### **3.2 Geographic Distribution**
- Countries with the highest homicide rates visualized using bar plots.
- Choropleth maps indicate regions with extreme homicide cases.

### **3.3 Demographic Analysis: Age & Gender**
- Gender-based trends reveal disparities in homicide rates.
- Age groups most affected by homicides are highlighted.

### **3.4 Weapon Usage and Victim-Perpetrator Relationship**
- Most common weapons used in homicides.
- Patterns in victim-perpetrator relationships analyzed.

---

## **4. Key Findings & Conclusion**
### **Insights Gathered:**
- Some regions exhibit consistently high homicide rates.
- Certain weapons are more commonly used in specific regions.
- The victim-perpetrator relationship plays a key role in crime investigations.

### **Future Recommendations:**
- More in-depth analysis on policy impacts.
- Cross-analysis with economic and social indicators.

This analysis provides valuable insights into homicide trends, helping policymakers and researchers make informed decisions.

---
*Report generated from an exploratory data analysis project using Python (Pandas, Seaborn, Matplotlib, and Plotly).*

