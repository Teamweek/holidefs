defmodule Holidefs.Definition.RuleTest do
  use ExUnit.Case
  alias Holidefs.Definition.Rule

  doctest Rule

  test "build/2 buils the definition for a valid rule map" do
    assert %Rule{} =
             rule = Rule.build(:us, 0, %{"name" => "Passover", "function" => "easter(year)"})

    assert rule.month == 0
    assert rule.name == "Passover"
    assert rule.function == :easter

    assert %Rule{} = rule = Rule.build(:us, 6, %{"name" => "Bday", "mday" => 20})

    assert rule.month == 6
    assert rule.name == "Bday"
    assert rule.day == 20

    assert %Rule{} = rule = Rule.build(:us, 6, %{"name" => "Monday", "week" => 1, "wday" => 1})

    assert rule.month == 6
    assert rule.name == "Monday"
    assert rule.week == 1
    assert rule.weekday == 1
  end

  test "build/2 returns error tuple for an invalid rule map" do
    assert_raise FunctionClauseError, fn ->
      Rule.build(:us, 0, %{"no_name" => "Bad"})
    end

    assert_raise FunctionClauseError, fn ->
      Rule.build(:us, 0, %{"name" => "Bad"})
    end

    assert_raise FunctionClauseError, fn ->
      Rule.build(:us, 0, %{"name" => "Bad", "function" => "no_function()"})
    end
  end
end
