module ActAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    attr_reader :headers, :csv_contents

    def initialize
      read
    end

    def each(&block)
      @csv_contents.each do |row|
        block.call CsvRow.new(@headers, row)
      end
    end

  end

  class CsvRow
    def initialize(headers, row)
      @headers = headers
      @row = row
    end

    def method_missing(name, *args)
      return @row[@headers.index(name.to_s)] if @headers.include?(name.to_s)
      super
    end

    def respond_to?(name)
      @headers.include?(name.to_s) || super
    end
  end
end


class RubyCsv
  include ActAsCsv
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
m.each {|row| puts row.one}

