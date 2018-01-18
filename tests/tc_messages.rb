# Tests for Messages class
require 'test/unit'
require 'rest-client'
require 'dotenv/load'
require 'json'
require_relative '../messages.rb'
require_relative '../vk.rb'

class TestMessages < Test::Unit::TestCase
  def test_start
    assert_equal(true, Messages.start.is_a?(String), "Method start doesn't return String.")
  end

  def test_help
    assert_equal(true, Messages.help.is_a?(String), "Method help doesn't return String.")
  end

  def test_list
    assert_equal(true, Messages.list.is_a?(String), "Method list doesn't return String.")
  end

  def test_random
    assert_equal(true, Messages.random.is_a?(String), "Method random doesn't work without parameter.")

    ['fkgjdf;kgj;fdkgjf;kg;f', 349_758, 45_984_958.0, true, false, nil, Object].each do |x|
      assert_equal(true, Messages.random(x).is_a?(String), "Method random doesn't work with wrong album name as #{x.class}.")
    end

    assert_equal(true, Messages.random('Easy').is_a?(String), "Method random doesn't work with correct album name.")
  end

  def test_all
    assert_equal(true, Messages.all.is_a?(String), "Method all doesn't work without parameter.")

    ['fkgjdf;kgj;fdkgjf;kg;f', 349758, 45_984_958.0, true, false, nil, Object].each do |x|
      assert_equal(true, Messages.all(x).is_a?(String), "Method all doesn't work with wrong album name as #{x.class}.")
    end

    assert_equal(true, Messages.all('Easy').is_a?(String), "Method all doesn't work with correct album name.")
  end

  def test_source
    assert_equal(true, Messages.source.is_a?(String), "Method source doesn't return String.")
  end

  def test_other
    assert_equal(true, Messages.other.is_a?(String), "Method other doesn't return String.")
  end
end
