require 'minitest'
require 'minitest/autorun'
require 'minitest/unit'
require 'simplecov'

require 'simplecov-phabricator'

class TestSimpleCovFormatterPhabricatorFormatter < MiniTest::Test
  def setup
    @rcov_file = File.join( SimpleCov::Formatter::PhabricatorFormatter.output_path, SimpleCov::Formatter::PhabricatorFormatter.file_name)
    File.delete( @rcov_file ) if File.exists?( @rcov_file )

    @result = SimpleCov::Result.new(
      {
        File.expand_path( File.join( File.dirname( __FILE__ ), 'fixtures', 'some_class.rb' ) )  =>
        [1,1,1,1,nil,1,0,1,1,nil,0,1,1]
      }
    )

    # Set to default encoding
    Encoding.default_internal = nil if defined?(Encoding)
  end

  def test_format
    SimpleCov::Formatter::PhabricatorFormatter.new.format( @result )

    assert File.exists?( @rcov_file )
  end

  def test_encoding
    # This is done in many rails environments
    Encoding.default_internal = 'UTF-8' if defined?(Encoding)

    SimpleCov::Formatter::PhabricatorFormatter.new.format( @result )
  end

  def test_create_content
    SimpleCov::Formatter::PhabricatorFormatter.new.format( @result )
    content = File.open(@rcov_file, "r").read
    assert_match(/{".+some_class\.rb":"CCCCNCUCCNUCC"}/, content)
  end
end
