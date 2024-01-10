In constructing this dynamic Human Resource Dashboard, I employed a blend of SQL queries and DAX (Data Analysis Expressions) in Power BI to create a rich, interactive data model.
An SQL query was meticulously designed for the foundation to construct an accumulative data table, pulling from the raw dataset to drive the dashboard. 
Cumulative headcount.sql was essential in shaping the underlying data structure that supports the interactive elements of the dashboard.
For the dashboard's analytical capabilities, DAX formulas were crafted to calculate columns and measures that power the visuals:

Attrition Rate Measure:
DAX

Attrition Rate = 
CALCULATE(
    COUNTROWS('EmployeeTable'),
    'EmployeeTable'[TerminationDate] <= TODAY()
) / CALCULATE(
    COUNTROWS('EmployeeTable'),
    ALL('EmployeeTable')
)

Headcount Measure:
DAX

Headcount = 
CALCULATE(
    DISTINCTCOUNT('EmployeeTable'[EmployeeID]),
    'EmployeeTable'[DateOfJoining] <= LASTDATE('Calendar'[Date]),
    ISBLANK('EmployeeTable'[TerminationDate]) || 'EmployeeTable'[TerminationDate] > LASTDATE('Calendar'[Date])
)

Active Employee Calculation:
DAX

Active Employees = 
COUNTROWS(
    FILTER(
        'EmployeeTable',
        'EmployeeTable'[DateOfJoining] <= TODAY() && (ISBLANK('EmployeeTable'[TerminationDate]) || 'EmployeeTable'[TerminationDate] > TODAY())
    )
)
These DAX expressions allowed me to dive deep into understanding the nuances of Termination and Attrition, vital HR concepts that can significantly affect strategic decision-making. 
I also explored the dynamics of headcount and active employees, providing the client with actionable insights into their workforce management and planning.
By integrating SQL and DAX, I ensured that the dashboard was a visual treat and a robust analytical tool that stood on the bedrock of accurate, real-time data processing. 
In addition, I made a "dim date" table using DAX formulas in my star data model. This project was a testament to the power of combining database querying with advanced data modelling techniques to deliver a comprehensive and insightful analytical solution.






