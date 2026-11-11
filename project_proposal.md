# R@1D
## Sprint Teams
* Dragon
  * [Samuel Fu](mailto:jiaruifu@tamu.edu)
  * [Kiefer Crowley](mailto:jwadley@tamu.edu)
  * [--Alana Ordonez--](mailto:alordonez1@tamu.edu)
* Phoenix
  * [William Tyler Weber](mailto:wtweber@tamu.edu)
  * [Caleb Austin](mailto:calebaustin01@tamu.edu)
  * [Lee Houchin](mailto:l_lee_houchin3@tamu.edu)
  
## Project Description
**R@1D** is a bug tracking application that allows a developer team to form    \
projects where they can post and track issues. Users in a project would be     \
able to discuss ongoing issues, and once assigned to one or more developers,   \
they could post their ongoing progress on a specific issue until eventually    \
marked as resolved by a manager or administrator.

### Product Goal

By the end of the project, R@1D will allow software developers and project     \
managers to track, fix, and archive bugs by letting them create managed        \
projects that assign developers different roles, where each issue would get    \
its own discussion page for the team to give updates and feedback to each      \
other as the bug is fixed.

### Target Users and Stakeholders

**Who will use this app?**\
Development teams (developers and project leads)

**Who cares whether this app succeeds?**\
Stakeholders/management/product owners

### Core Problem and Value Proposition

**What problem are you solving and why is it meaningful?**\
As projects get larger or have more people involved, it becomes harder to      \
track bugs by simpler methods or by word of mouth. This application allows     \
developers to track and archive bugs for others to discuss and fix.

**Why would a user choose to use this app instead of doing nothing or using    \
a simpler workaround?**\
This application would provide a history of issues, such that if an issue      \
comes up again, then previous data is available from prior attempts to resolve \
the issue (traceability).

It provides an overall view of the list of issues that needs to be resolved    \
for your end product.

## Features

### MVP Features

* Submit a bug report with
    * description
    * priority
    * type
    * how to replicate.
* Set a bug report’s status to 
  * open
  * closed
  * in progress
* Assign a bug to a developer
* Display a report showing
  * status of bug reports
  * User accounts with roles (lead or developer)
  * Comments for users to discuss the issue.

### Out-of-Scope Features
* attachments, _**only text/images**_

### Stretch Features

* Attach supporting documents to the bug report.
* Implement Google or Apple login for authorization.

## Initial User Stories

<table>
    <thead>
      <tr>
        <th class="center_text">#</th>
        <th class="center_text">Description</th>
        <th class="center_text">Importance</th>
        <th class="center_text">Team Assigned</th> 
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="first_col">1</td>
        <td>As a new user, I want to sign up and sign in as a developer so that I can post and discuss bugs with my team.</td>
        <td class="center_text">Essential</td>
        <td class="center_text">Dragon</td>
      </tr>
      <tr>
        <td class="first_col center_text">2</td>
        <td >As a developer, I want to report a bug with a description, priority, type, and steps to replicate so that others can reproduce it.</td>
        <td class="center_text">Essential</td> 
        <td class="center_text first_col alert_color">Dragon</td>
      </tr>
      <tr> 
        <td class="first_col center_text">3</td>
        <td>As a developer, I want to move my assigned bug through allowed statuses so that the team sees progress.</td>
        <td class="center_text">Essential</td> 
        <td class="center_text first_col alert_color">Phoenix</td>
      </tr>
      <tr>
        <td class="first_col center_text">4</td>
        <td>As an administrator, I want to create a project and invite members with roles so that my team has a shared workspace.</td>
        <td class="center_text">Essential</td> 
        <td class="center_text">Phoenix</td>
      </tr>
      <tr> 
        <td class="first_col center_text">5</td>
        <td>As a team member, I want to discuss a bug in a comment thread and see its change history so that decisions are recorded.</td>
        <td class="center_text">Essential</td> 
        <td class="center_text first_col alert_color">Phoenix</td>
      </tr>
      <tr>
      <td class="first_col center_text">6</td>
        <td>As a developer, I want a clear error when I submit a bug missing required fields so that reports are always actionable.</td>
        <td class="center_text">Error-Handling</td> 
        <td class="center_text first_col alert_color">Dragon</td>
      </tr>
      <tr>
        <td class="first_col center_text">7</td>
        <td>As a developer, I want to attach screenshots or logs to a bug report so that the others have the supporting evidence.</td>
        <td class="center_text">Stretch</td> 
        <td class="center_text first_col alert_color">Unassigned</td>
      </tr>
      <tr>
        <td class="first_col center_text">8</td>
        <td>As a user, I want to sign in with my Google or Apple account so that I do not need to manage another password.</td>
        <td class="center_text">Stretch</td> 
        <td class="center_text first_col alert_color">Unassigned</td>
      </tr>
    </tbody>
</table>

## Initial Data Model

### Project

* Owner
  * user
  * role
  * bugs
* Bug Report
  * ID
  * Title
  * Description
  * Replication
  * Priority
  * Submitted by
  * Status
  * Assigned to
  * Comments
* Comment
  * User
  * Comment
  * Bug report ID
* Status
  * Current status
  * Date
  * Changed by
* Assignment
  * Assigned to user
  * Date 
  * Assigned by
* User 
  * Username
  * Name

## Authentication and Authorization Plan

### Identify at least 2 different roles

* User
* Developer
* Manager
* Administrator

### Identify at least 2 actions that require login (authentication)

* Submitting or editing a bug report
* Commenting on a bug report
* Changing status of a bug report 
* Assigning a bug report to a developer

### Identify at least 2 actions that are restricted by role (authorization)

* Changing status to closed will require Manager or admin role 
* Setting the priority requires a developer or admin role
* Assigning a bug report to another developer will require the manager or admin role

## Testing Plan

### Acceptance tests

* Administrator creates a project and invites a member, and inviting an unknown or duplicate email fails.
* Developer files a bug with _**(the missing required fields show errors.)**_
  * a description
  * type
  * steps to replicate 
* Manager assigns a developer to a bug and a dev sets priority, and a user can do neither.
* Visitors are redirected to sign-in, non-members cannot open a project.

### Unit tests (RSpec)
* Authorization policies for each role/action
* Model validations and associations for every model
* Coverage measured with SimpleCov and enforced at 90%

## Deployment Plan

**Where will the app be deployed?**\
Likely one of Heroku or Render
  
## Risks and Mitigations
* One or more team members are unable to attend a scrum meeting
  **<u>Mitigation</u>**: Send an email addressing the 3 items you would have brought up in the daily scrum meeting
* The chosen deployment platform runs into a critical issue with our project
  **<u>Mitigation</u>**: Write the project in a way that switching platforms is not too difficult (abstraction)

## Scrum Logistics

* How many Sprints? (at least 2)
  * 3 Sprints, one before mid project and 2 after 
* When and where is the Daily Scrum?
  * Where: Google Meet
  * When:  3:00 PM to 3:20 PM
* When will Sprint Planning, Reviews, and Retrospectives occur?
  * Sprint Planning: 3 to 5 days at the beginning of the sprint (10/12/2026 - 10/16/2026)
  * Sprint Review:
    * Mid-Sprint 9th day of sprint (10/22/2026)
    * 12th day of sprint (10/29/2026)
    * Retrospective: Last day of Sprint (10/30/2026)

## Initial Product Backlog
_(Ordered by priority)_

1. User Story 1: 3 points
2. User Story 4: 5 points
3. User Story 2: 4 points
4. User Story 6: 2 points
5. User Story 3: 2 points
6. User Story 5: 3 points

## Definition of Done
      
A Product Backlog item is considered done when:
* The feature has associated user stories
* The feature has acceptance tests (Cucumber scenarios) for happy and sad paths
* Relevant unit tests (RSpec examples) have been added or updated
* All tests are passing
  * Test coverage is at least 90%
* RuboCop reports no correctable offenses
* The feature has been reviewed through a pull request
* The feature is deployed to production
* Documentation is updated if behavior, setup, or usage changed
