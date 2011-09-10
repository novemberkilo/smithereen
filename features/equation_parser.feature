Feature: Algebraic Equation Parser
  In order to make sense of user entered algebraic equations
  I want to have an algebraic equation parser

  Background:
    Given I have loaded the algebraic equation parser

  Scenario Outline: Run some calculations
    When I ask the algebraic equation parser for the answer to "<input>"
    Then I should see "<result>"

    Examples:
      | input          | result |
      | 24             |     24 |
      | pi             | 3.141592653589793 |
      | 24 +2          |     26 |
      | 24 + 2 * 3     |     30 |
      | 24+2* - 3-12   |      6 |
      | 24+2*(-3-12)   |     -6 |
      | 24+2*-(3-12)   |     42 |
      | 24+2*-(3-12^2) |    306 |
      | 24+3*4/2 - 5   |     25 |
      | 6+sqrt(9)      |      9 |
      | sin(0)         |      0 |
      | cos(0)         |      1 |
      | cos(pi)        |     -1 |
      | cos( 3.141592653589793)      |     -1 |

  Scenario: Leading whitespace
    When I ask the algebraic equation parser for the answer to "  2+2"
    Then I should see "4"

  Scenario: Trailing whitespace
    When I ask the algebraic equation parser for the answer to "2+2  "
    Then I should see "4"

  Scenario: Odd whitespace characters
    When I ask the algebraic equation parser for the answer to " \t \n 2 \r\n + \t - \r 2 \n"
    Then I should see "0"

  Scenario Outline: Syntax errors
    When I ask the algebraic equation parser for the answer to "<input>"
    Then I should get the error "<message>"

    Examples:
      | input   | message                               |
      |         | Unexpected end of input               |
      | 2+      | Unexpected end of input               |
      | +2      | Unexpected '+'                        |
      | 2 2     | Unexpected integer (2)                |
      | 2+(3    | Unexpected end of input; expected ')' |
      | 2+)3    | Unexpected ')'                        |
      | 2+*3    | Unexpected '*'                        |
      | 2-      | Unexpected end of input               |
      | 3-18(4) | Expected a function name              |
      | sqrt(8  | Missing closing parenthesis           |
      | foo(8)  | Unrecognized function                 |
