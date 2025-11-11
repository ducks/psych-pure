# frozen_string_literal: true

require_relative "test_helper"

module Psych
  module Pure
    class LoadedObjectMutationTest < Minitest::Test
      def test_string_mutation_upcase_bang
        yaml = "value: hello"
        result = Psych::Pure.load(yaml, comments: true)

        # Mutate the string in place
        result["value"].upcase!

        # Dump and reload
        dumped = Psych::Pure.dump(result)
        reloaded = Psych::Pure.load(dumped)

        # Should reflect the mutation
        assert_equal "HELLO", reloaded["value"]
      end

      def test_string_mutation_gsub_bang
        yaml = "message: hello world"
        result = Psych::Pure.load(yaml, comments: true)

        # Mutate with gsub!
        result["message"].gsub!("hello", "goodbye")

        dumped = Psych::Pure.dump(result)
        reloaded = Psych::Pure.load(dumped)

        assert_equal "goodbye world", reloaded["message"]
      end

      def test_string_mutation_concat
        yaml = "text: foo"
        result = Psych::Pure.load(yaml, comments: true)

        # Mutate with concat (<<)
        result["text"] << " bar"

        dumped = Psych::Pure.dump(result)
        reloaded = Psych::Pure.load(dumped)

        assert_equal "foo bar", reloaded["text"]
      end

      def test_array_mutation_push
        yaml = "list:\n  - one\n  - two"
        result = Psych::Pure.load(yaml, comments: true)

        # Mutate array
        result["list"] << "three"

        dumped = Psych::Pure.dump(result)
        reloaded = Psych::Pure.load(dumped)

        assert_equal ["one", "two", "three"], reloaded["list"]
      end

      def test_array_mutation_delete
        yaml = "items:\n  - keep\n  - remove\n  - keep"
        result = Psych::Pure.load(yaml, comments: true)

        # Mutate array
        result["items"].delete("remove")

        dumped = Psych::Pure.dump(result)
        reloaded = Psych::Pure.load(dumped)

        assert_equal ["keep", "keep"], reloaded["items"]
      end
    end
  end
end
