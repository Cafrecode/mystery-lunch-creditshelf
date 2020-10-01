# Coding Challenge: Mystery lunch app

Mystery lunch is part of the creditshelf culture: at the beginning of each month, every employee is
randomly selected to have lunch with another employee of a different department. Build a
Mystery Lunch web application using Ruby on Rails following the specification below.

## Starting

• Create a private Github repository
• If you have any questions, please send us a message: development@creditshelf.com

## Specification

### Homepage

• Display the current mystery partners
• For every employee, display: photo, name and department name
• Filter by department
• Allow the user to see all mystery partners from previous months

### Employees management

• Restricted area (requires authentication)
• Manage employees (index, display, create, edit and delete)
• Departments: operations, sales, marketing, risk, management, finance, HR, development
and data
• The employee deletion should only disable the employee for future mystery lunches
• When an employee is created, he/she should join an existing mystery pair (3 people
mystery lunch)
• When an employee is deleted:
o This employee had one mystery partner: the remaining employee should join
another existing mystery pair (3 people mystery lunch)
o This employee had two mystery partners: nothing should be done

### Mystery partners selection

• The selection should be automatically performed on 1st day of each month
• Two employees should not be selected to be partners if they were partners in the last 3
months
• When the number of employees is odd, the remaining employee should join an existing
mystery pair (3 people mystery lunch). The department of these three employees should
be different.

### Must have

• Automated tests
• Use your creativity and build a new feature of your choice

### Nice to have

• Create a Dockerfile to run your application
• Manage your coding progress using branches/PRs

### Finishing

• Please include a README.md file and explain your design decisions and any other
important considerations
• Add the creditshelf-dev-team user to your repository
• Please notify us that you have finished your coding assessment