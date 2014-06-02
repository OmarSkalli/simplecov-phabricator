require 'fileutils'
require 'time'
require 'pathname'
require 'json'

unless defined?(SimpleCov)
  raise RuntimeError, "simplecov-phabricator is a formatter for simplecov. Please update your test helper and gemfile to require 'simplecov'!"
end

class SimpleCov::Formatter::PhabricatorFormatter
  def format( result )
    coverage_report = {}
    result.files.each do |file|
      file_path = rails_file_path(file.filename)
      coverage_report[file_path] = format_file_coverage(file)
    end
    save_coverage_report(coverage_report)
  end

  def self.output_path
    SimpleCov.coverage_path
  end

  def self.file_name
    'phabricator-coverage.json'
  end

  private

  def save_coverage_report(coverage)
    output_filepath = File.join(SimpleCov::Formatter::PhabricatorFormatter.output_path,
                                SimpleCov::Formatter::PhabricatorFormatter.file_name)

    File.open( output_filepath, "w" ) do |file_result|
      file_result.write coverage.to_json
    end
  end

  def rails_file_path(filename)
    if defined?(Rails)
      Pathname.new(filename).relative_path_from(Rails.root).to_s
    else
      filename
    end
  end

  def format_file_coverage(file)
    file.lines.map do |file_line|
      if file_line.covered?
        'C' # C Covered. This line has test coverage.
      elsif file_line.missed?
        'U' # U Uncovered. This line is executable but has no test coverage.
      elsif file_line.never? || file_line.skipped?
        'N' # N Not executable. This is a comment or whitespace which should be ignored when computing test coverage.
      else
        ' '
      end
    end.join
  end
end
