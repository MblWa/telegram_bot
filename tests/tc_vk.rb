# Tests for Vk class
require_relative '../vk.rb'
require 'test/unit'
require 'rest-client'
require 'dotenv/load'
require 'json'

class TestVk < Test::Unit::TestCase
  def test_albums
    assert_equal(true, Vk.albums_get.is_a?(Hash), "Method albums_get doesn't return Hash.")
  end

  def test_photos
    assert_equal(true, Vk.photos_get.is_a?(String), "Method photos_get doesn't work without parameters.")
    assert_equal(true, Vk.photos_get('Easy').is_a?(String), "Method photos_get doesn't work with correct album name.")
    assert_equal(true, Vk.photos_get('f;klgjf').is_a?(String), "Method photos_get doesn't work with wrong album name.")
  end

  def test_all
    assert_equal(true, Vk.all_get.is_a?(String), "Method all_get doesn't work without parameters.")
    assert_equal(true, Vk.all_get('Easy').is_a?(String), "Method all_get doesn't work with correct album name.")
    assert_equal(true, Vk.all_get('f;klgjf').is_a?(String), "Method all_get doesn't work with wrong album name.")
  end

  def test_source
    assert_equal(true, Vk.source_get.is_a?(String), "Method source_get doesn't return String.")
  end
end
