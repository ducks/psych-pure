# frozen_string_literal: true

require_relative "test_helper"

module Psych
  module Pure
    class LoadedObjectDirtyFlagTest < Minitest::Test
      def test_string_mutation_sets_dirty_flag
        yaml = "value: hello"
        result = Psych::Pure.load(yaml, comments: true)

        # Initially not dirty
        refute result["value"].dirty, "String should not be dirty initially"

        # Mutate the string
        result["value"].upcase!

        # Should be dirty after mutation
        assert result["value"].dirty, "String should be dirty after upcase!"
      end

      def test_string_gsub_mutation_sets_dirty_flag
        yaml = "message: hello world"
        result = Psych::Pure.load(yaml, comments: true)

        refute result["message"].dirty, "String should not be dirty initially"

        result["message"].gsub!("hello", "goodbye")

        assert result["message"].dirty, "String should be dirty after gsub!"
      end

      def test_string_concat_sets_dirty_flag
        yaml = "text: foo"
        result = Psych::Pure.load(yaml, comments: true)

        refute result["text"].dirty, "String should not be dirty initially"

        result["text"] << " bar"

        assert result["text"].dirty, "String should be dirty after concat"
      end

      def test_array_mutation_sets_dirty_flag
        yaml = "list:\n  - one\n  - two"
        result = Psych::Pure.load(yaml, comments: true)

        refute result["list"].dirty, "Array should not be dirty initially"

        result["list"] << "three"

        assert result["list"].dirty, "Array should be dirty after push"
      end

      def test_array_delete_sets_dirty_flag
        yaml = "items:\n  - keep\n  - remove"
        result = Psych::Pure.load(yaml, comments: true)

        refute result["items"].dirty, "Array should not be dirty initially"

        result["items"].delete("remove")

        assert result["items"].dirty, "Array should be dirty after delete"
      end
    end
  end
end
