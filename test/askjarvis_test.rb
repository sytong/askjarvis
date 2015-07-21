require 'test_helper'

class AskjarvisTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Askjarvis::VERSION
  end

  def test_it_raises_error_if_private_key_is_not_defined
    env = ENV.to_hash
    env.delete(Askjarvis::ENV_MARVEL_API_PRIVATE_KEY)  # could be nil
    env[Askjarvis::ENV_MARVEL_API_PUBLIC_KEY] = "PUBLIC_KEY"

    Object.stub_const(:ENV, env) do
      error = assert_raises Askjarvis::AskjarvisError do
        Askjarvis.default_query_params
      end

      assert_equal Askjarvis::MISSING_PRIVATE_KEY_ERROR, error.message
    end
  end

  def test_it_raises_error_if_public_key_is_not_defined
    env = ENV.to_hash
    env.delete(Askjarvis::ENV_MARVEL_API_PUBLIC_KEY)  # could be nil
    env[Askjarvis::ENV_MARVEL_API_PRIVATE_KEY] = "PRIVATE_KEY"

    Object.stub_const(:ENV, env) do
      error = assert_raises Askjarvis::AskjarvisError do
        Askjarvis.default_query_params
      end

      assert_equal Askjarvis::MISSING_PUBLIC_KEY_ERROR, error.message
    end
  end

  def test_it_should_return_default_params
    fixed_time = Time.new(2015,1,1,12,0,0)
    env = ENV.to_hash
    env[Askjarvis::ENV_MARVEL_API_PRIVATE_KEY] = "PRIVATE"
    env[Askjarvis::ENV_MARVEL_API_PUBLIC_KEY] = "PUBLIC"

    Object.stub_const(:ENV, env) do
      Time.stub :now, fixed_time do
        Digest::MD5.stub :hexdigest, "test_hash_value" do
          assert_equal "ts=#{fixed_time.to_i.to_s}&apikey=PUBLIC&hash=test_hash_value", Askjarvis.default_query_params
        end
      end
    end
  end
end
