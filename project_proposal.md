# R@1D
## Team Members
Samuel Fu
Lee Houchin
Caleb Austin
William Tyler Weber
Alana Ordonez
Kiefer Crowley
App Name
R@1D
Short Description
R@1D is a bug tracking application that allows a developer team to form projects where they can post and track issues. Users in a project would be able to discuss ongoing issues, and once assigned to one or more developers, they could post their ongoing progress on a specific issue until eventually marked as resolved by a manager or administrator.
Product Goal
By the end of the project, R@1D will allow software developers and project managers to track, fix, and archive bugs by letting them create managed projects that assign developers different roles, where each issue would get its own discussion page for the team to give updates and feedback to each other as the bug is fixed.
Target Users and Stakeholders
Who will use this app?
Development teams (developers and project leads)
Who cares whether this app succeeds?
Stakeholders/management/product owners
Core Problem and Value Proposition
What problem are you solving and why is it meaningful?
As projects get larger or have more people involved, it becomes harder to track bugs by simpler methods or by word of mouth. This application allows developers to track and archive bugs for others to discuss and fix.
Why would a user choose to use this app instead of doing nothing or using a simpler workaround?
This application would provide a history of issues, such that if an issue comes up again, then previous data is available from prior attempts to resolve the issue (traceability).
It provides an overall view of the list of issues that needs to be resolved for your end product.
MVP Features
Submit a bug report with description, priority, type, and how to replicate.
Set a bug report’s status to open, closed, in progress.
Assign a bug to a developer.
Display a report showing status of bug reports
User accounts with roles (lead or developer)
Comments for users to discuss the issue.
Out-of-Scope Features
For attachments, only text/images
Stretch Features
Attach supporting documents to the bug report.
Implement Google or Apple login for authorization.
Initial User Stories
#1 [Essential] As a new user, I want to sign up and sign in as a developer so that I can post and discuss bugs with my team. - Team Dragon
#2 [Essential] As a developer, I want to report a bug with a description, priority, type, and steps to replicate so that others can reproduce it.
#3 [Essential] As a developer, I want to move my assigned bug through allowed statuses so that the team sees progress.
#4 [Essential] As an administrator, I want to create a project and invite members with roles so that my team has a shared workspace. - Team Phoenix
#5 [Essential] As a team member, I want to discuss a bug in a comment thread and see its change history so that decisions are recorded.
#6 [Error-Handling] As a developer, I want a clear error when I submit a bug missing required fields so that reports are always actionable.
[Stretch] As a developer, I want to attach screenshots or logs to a bug report so that the others have the supporting evidence.
[Stretch] As a user, I want to sign in with my Google or Apple account so that I do not need to manage another password.
Initial Data Model
Project
Owner
[User, role]
Bugs
Bug Report
ID
Title
Description
Replication
Priority
Submitted by
Status 
Assigned to 
Comments
Comment
User
Comment
Bug report ID
Status
Current status
Date
Changed by
Assignment
Assigned to user
Date
Assigned by
User
Username
Name
Authentication and Authorization Plan
Identify at least 2 different roles
User
Developer
Manager
Administrator
Identify at least 2 actions that require login (authentication)
Submitting or editing a bug report
Commenting on a bug report
Changing status of a bug report
Assigning a bug report to a developer
Identify at least 2 actions that are restricted by role (authorization)
Changing status to closed will require Manager or admin role
Setting the priority requires a developer or admin role
Assigning a bug report to another developer will require the manager or admin role

Testing Plan
Acceptance tests
Administrator creates a project and invites a member, and inviting an unknown or duplicate email fails.
Developer files a bug with a description, type, and steps to replicate, and the missing required fields show errors.
Manager assigns a developer to a bug and a dev sets priority, and a user can do neither.
Visitors are redirected to sign-in, non-members cannot open a project.
Unit tests (RSpec)
Authorization policies for each role/action
Model validations and associations for every model
Coverage measured with SimpleCov and enforced at 90%
Deployment Plan
Where will the app be deployed?
Likely one of Heroku or Render
Risks and Mitigations
One or more team members are unable to attend a scrum meeting
Mitigation: Send an email addressing the 3 items you would have brought up in the daily scrum meeting
The chosen deployment platform runs into a critical issue with our project
Mitigation: Write the project in a way that switching platforms is not too difficult (abstraction)
Scrum Logistics
How many Sprints? (at least 2)
3 Sprints, one before mid project and 2 after 
When and where is the Daily Scrum?
Where: Google Meet
When:  3:00 PM to 3:20 PM
When will Sprint Planning, Reviews, and Retrospectives occur?
Sprint Planning: 3 to 5 days at the beginning of the sprint (10/12/2026 - 10/16/2026)
Sprint Review: 
Mid-Sprint 9th day of sprint (10/22/2026)
12th day of sprint (10/29/2026)
Retrospective: Last day of Sprint (10/30/2026)
Initial Product Backlog
Ordered by priority
User Story 1: 3 points
User Story 4: 5 points
User Story 2: 4 points
User Story 6: 2 points
User Story 3: 2 points
User Story 5: 3 points
Definition of Done
A Product Backlog item is considered done when:
The feature has associated user stories
The feature has acceptance tests (Cucumber scenarios) for happy and sad paths
Relevant unit tests (RSpec examples) have been added or updated
All tests are passing
Test coverage is at least 90%
RuboCop reports no correctable offenses
The feature has been reviewed through a pull request
The feature is deployed to production
Documentation is updated if behavior, setup, or usage changed


10/18/2026 Meeting Notes:
For this sprint, we are going for minimum 3 points (3 is good!)
Use email / text, try to avoid meetings unless needed
Team Dragon [Samuel, Kiefer]
User story 1
Team Phoenix [Will, Caleb]
Setting up the rails project
User story 4
Team Griffin [Lee, Alana]
Undecided, determined next meeting

Next meeting on Tuesday (same time?)





