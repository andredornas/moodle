@qtype @qtype_shortanswer
Feature: Test editing a Short answer question
  As a teacher
  In order to be able to update my Short answer question
  I need to edit them

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | T1        | Teacher1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype       | name                        | template |
      | Test questions   | shortanswer | shortanswer-001 for editing | frogtoad |
    And I log in as "teacher1"
    And I follow "Course 1"
    And I navigate to "Question bank" node in "Course administration"

  @javascript
  Scenario: Edit a Short answer question
    When I click on "Edit" "link" in the "shortanswer-001 for editing" "table_row"
    And I set the following fields to these values:
      | Question name | |
    And I press "id_submitbutton"
    Then I should see "You must supply a value here."
    When I set the following fields to these values:
      | Question name | Edited shortanswer-001 name |
    And I press "id_submitbutton"
    Then I should see "Edited shortanswer-001 name"
    When I click on "Edit" "link" in the "Edited shortanswer-001 name" "table_row"
    And I set the following fields to these values:
      | id_answer_1          | newt                       |
      | id_fraction_1        | 70%                        |
      | id_feedback_1        | Newt is an OK good answer. |
    And I press "id_submitbutton"
    Then I should see "Edited shortanswer-001 name"
    When I click on "Preview" "link" in the "Edited shortanswer-001 name" "table_row"
    And I switch to "questionpreview" window
    Then I should see "Name an amphibian:"
    # Set behaviour options
    And I set the following fields to these values:
      | behaviour | immediatefeedback |
    And I press "Start again with these options"
    And I set the field with xpath "//div[@class='qtext']//input[contains(@id, '1_answer')]" to "newt"
    And I press "Check"
    Then I should see "Newt is an OK good answer."
    And I should see "Generalfeedback: frog or toad would have been OK."
    And I should see "The correct answer is: frog"